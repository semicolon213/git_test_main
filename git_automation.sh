#!/bin/bash

# 커밋 메시지 입력 받기
read -p "커밋 메시지를 입력하세요: " commit_message

# 브랜치 선택 받기
read -p "푸시할 브랜치를 입력하세요: " branch_name

# 현재 디렉토리에서 변경된 파일을 git에 추가
git add .

# 입력한 커밋 메시지로 커밋
git commit -m "$commit_message"

# 선택한 브랜치로 푸시
git push origin "$branch_name"