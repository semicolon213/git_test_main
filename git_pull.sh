#!/bin/bash

# OS 감지
os_type="unknown"
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
    os_type="windows"
else
    os_type="unix"
fi

# 작업 로그 초기화
log="\n--------작업로그--------\n\n"

# 사용 가능한 로컬 브랜치 목록 가져오기
if [[ "$os_type" == "windows" ]]; then
    branches=$(git branch --list)
else
    branches=$(git branch --list | sed 's/^[* ]*//')
fi

# 브랜치 선택
echo "사용 가능한 브랜치 목록:"
select branch_name in $branches; do
  if [[ -n "$branch_name" ]]; then
    log+="브랜치: $branch_name\n"
    break
  else
    echo "유효하지 않은 선택입니다. 다시 시도하세요."
  fi
done

# 선택한 브랜치에서 최신 코드 가져오기
git pull origin "$branch_name"

# 작업 로그 출력
log+="브랜치 $branch_name 에서 최신 코드 가져옴\n"
echo -e "$log"
echo "-----------------------"
