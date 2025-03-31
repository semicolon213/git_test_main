#!/bin/bash

# 작업 로그 초기화ㄴㅇㄹㄴㅇㄹㄴㅇㄹ
log="\n--------작업로그--------\n\n"

# 사용 가능한 로컬 브랜치 목록을 가져오기
branches=$(git branch --list | sed 's/^[* ]*//')

# 브랜치 번호로 목록 보여주기
PS3="선택할 브랜치 번호를 입력하세요 : "
select branch_name in $branches; do
  if [[ -n "$branch_name" ]]; then
    log+="브랜치: $branch_name\n"
    break
  else
    echo "유효하지 않은 선택입니다. 다시 시도하세요."
  fi
done

# 작업 선택: push 또는 pull
PS3="선택할 작업을 입력하세요 : "
options=("push" "pull")
select operation in "${options[@]}"; do
  if [[ "$operation" == "push" || "$operation" == "pull" ]]; then
    log+="작업: $operation\n"
    break
  else
    echo "유효하지 않은 선택입니다. 다시 시도하세요."
  fi
done

# 커밋 메시지 입력 받기
read -p "커밋 메시지를 입력하세요 : " commit_message
log+="커밋 메시지 : $commit_message\n"

# 새 파일 또는 수정된 파일 확인
new_files=$(git status --porcelain | grep '??' | wc -l)
modified_files=$(git status --porcelain | grep '^[ M]' | wc -l)

# 새 파일이 있으면 git add .
if [[ "$new_files" -gt 0 ]]; then
  add_option="."
  log+="새로운 파일이 존재하여 git add . 사용\n"
# 수정된 파일만 있으면 git add -u
elif [[ "$modified_files" -gt 0 ]]; then
  add_option="-u"
  log+="수정된 파일만 있어 git add -u 사용\n"
fi

# 파일 추가
git add $add_option

# 커밋
git commit -m "$commit_message"

# 선택된 작업 수행 (push 또는 pull)
if [[ "$operation" == "push" ]]; then
  git push origin "$branch_name"
elif [[ "$operation" == "pull" ]]; then
  git pull origin "$branch_name"
fi

# 작업 로그 출력
echo -e "$log"
echo "-----------------------"