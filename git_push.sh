#!/bin/bash

# 작업 디렉토리 설정 (현재 스크립트가 위치한 디렉토리로 설정)
work_dir="$(cd "$(dirname "$0")" && pwd)"  # 스크립트 파일의 디렉토리
cd "$work_dir" || { echo "작업 디렉토리로 이동할 수 없습니다: $work_dir"; exit 1; }

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

# 자동 커밋 메시지 생성 (현재 날짜 + 시간 + "자동업데이트")
if [[ "$os_type" == "windows" ]]; then
    commit_message=$(wmic os get localdatetime | findstr /r "[0-9]" | cut -c1-14)
    commit_message="${commit_message:0:4}-${commit_message:4:2}-${commit_message:6:2} ${commit_message:8:2}:${commit_message:10:2}:${commit_message:12:2} 자동업데이트"
else
    commit_message="$(date '+%Y-%m-%d %H:%M:%S') 자동업데이트"
fi
log+="커밋 메시지 : $commit_message\n"

# 새 파일 또는 수정된 파일 확인 후 add 방식 결정
if [[ "$os_type" == "windows" ]]; then
    git status --porcelain | find "??" > nul
    if [[ $? -eq 0 ]]; then
        add_option="."
        log+="새로운 파일이 존재하여 git add . 사용\n"
    else
        add_option="-u"
        log+="수정된 파일만 있어 git add -u 사용\n"
    fi
else
    new_files=$(git status --porcelain | grep '??' | wc -l)
    modified_files=$(git status --porcelain | grep '^[ M]' | wc -l)

    if [[ "$new_files" -gt 0 ]]; then
        add_option="."
        log+="새로운 파일이 존재하여 git add . 사용\n"
    elif [[ "$modified_files" -gt 0 ]]; then
        add_option="-u"
        log+="수정된 파일만 있어 git add -u 사용\n"
    fi
fi

# 파일 추가 및 커밋
git add $add_option
git commit -m "$commit_message"
git push origin "$branch_name"

# 작업 로그 출력
echo -e "$log"
echo "-----------------------"