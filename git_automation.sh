#!/bin/bash

# 커밋 메시지 입력 받기
read -p "커밋 메시지를 입력하세요: " commit_message

# 사용 가능한 로컬 브랜치 목록을 가져오기
branches=$(git branch --list | sed 's/^[* ]*//')

# 브랜치 번호로 목록 보여주기
PS3="선택할 브랜치 번호를 입력하세요: "
select branch_name in $branches; do
  if [[ -n "$branch_name" ]]; then
    break
  else
    echo "유효하지 않은 선택입니다. 다시 시도하세요."
  fi
done

# 새 파일 또는 수정된 파일 확인
new_files=$(git status --porcelain | grep '??' | wc -l)
modified_files=$(git status --porcelain | grep '^[ M]' | wc -l)

# 새 파일이 있으면 git add .
if [[ "$new_files" -gt 0 ]]; then
  add_option="."
# 수정된 파일만 있으면 git add -u
elif [[ "$modified_files" -gt 0 ]]; then
  add_option="-u"
fi

# 선택한 옵션으로 파일 추가
git add $add_option

# 입력한 커밋 메시지로 커밋
git commit -m "$commit_message"

# 선택한 브랜치로 푸시
git push origin "$branch_name"