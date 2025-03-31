#!/bin/bash

# 커밋 메시지 입력 받기
read -p "커밋 메시지를 입력하세요: " commit_message

# 사용 가능한 브랜치 목록을 가져오기
branches=$(git branch -r | sed 's/origin\///')

# 브랜치 번호로 목록 보여주기
PS3="선택할 브랜치 번호를 입력하세요: "
select branch_name in $branches; do
  if [[ -n "$branch_name" ]]; then
    break
  else
    echo "유효하지 않은 선택입니다. 다시 시도하세요."
  fi
done

# 현재 디렉토리에서 변경된 파일을 git에 추가
git add .

# 입력한 커밋 메시지로 커밋
git commit -m "$commit_message"

# 선택한 브랜치로 푸시
git push origin "$branch_name"