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

# 브랜치 이름 직접 지정
branch_name="main"  # 여기에서 사용할 브랜치 이름을 입력하세요
log+="브랜치: $branch_name\n"

# 선택한 브랜치에서 최신 코드 가져오기
git pull origin "$branch_name"

# 작업 로그 출력
log+="브랜치 $branch_name 에서 최신 코드 가져옴\n"
echo -e "$log"
echo "-----------------------"