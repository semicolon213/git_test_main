# 🚀 깃허브 서브트리 사용법

## 📌 1. 개요
Git 서브트리(Subtree)는 하나의 메인 레포지토리에서 여러 개의 서브 레포지토리를 효율적으로 관리할 수 있는 강력한 기능입니다. 이는 별도의 서브모듈 관리 없이도 서브 레포지토리의 코드와 히스토리를 유지하며 통합 관리할 수 있는 장점이 있습니다.

## 🛠️ 2. 기본 준비
* 📁 메인 레포지토리: `main-repo`
* 📂 서브 레포지토리 1: `sub-repo-1`
* 📂 서브 레포지토리 2: `sub-repo-2`

## 🏗️ 3. 서브트리 추가 방법
### 1️⃣ 메인 레포지토리 클론
```sh
 git clone https://github.com/username/main-repo.git
 cd main-repo
```

### 2️⃣ 서브 레포지토리 추가
```sh
 git subtree add --prefix=sub-repo-1 https://github.com/username/sub-repo-1.git main --squash
 git subtree add --prefix=sub-repo-2 https://github.com/username/sub-repo-2.git main --squash
```
✅ `--prefix` 옵션은 서브 레포지토리가 위치할 디렉터리를 지정합니다.
✅ `--squash` 옵션은 커밋 히스토리를 단일 커밋으로 병합합니다.

## 🔗 4. 기존 서브트리 등록(연결) 방법
```sh
 git remote add sub-repo-1 https://github.com/username/sub-repo-1.git
 git remote add sub-repo-2 https://github.com/username/sub-repo-2.git
```

## 🌿 5. 서브트리 브랜치 추가 방법
### 1️⃣ 메인 레포지토리에서 `feature/mypage` 브랜치 생성
```sh
 git checkout -b feature/mypage
```
### 2️⃣ 서브레포지토리에 `feature/mypage` 브랜치 추가
```sh
 git subtree push --prefix=sub-repo-1 https://github.com/username/sub-repo-1.git feature/mypage
 git subtree push --prefix=sub-repo-2 https://github.com/username/sub-repo-2.git feature/mypage
```

## 🔄 6. 서브트리 업데이트 방법
### 🔹 서브레포지토리 업데이트 가져오기 (Pull)
```sh
 git subtree pull --prefix=sub-repo-1 https://github.com/username/sub-repo-1.git main --squash
 git subtree pull --prefix=sub-repo-2 https://github.com/username/sub-repo-2.git main --squash
```

### 🔹 메인 레포지토리에서 변경사항을 서브레포지토리에 반영하기 (Push)
```sh
 git subtree push --prefix=sub-repo-1 https://github.com/username/sub-repo-1.git main
 git subtree push --prefix=sub-repo-2 https://github.com/username/sub-repo-2.git main
```

## 🌍 7. 서브트리 Remote 관리
### 🔍 서브트리의 원격 저장소 목록 확인
```sh
 git remote -v
```
### ❌ 특정 서브트리 원격 저장소 제거
```sh
 git remote remove sub-repo-1
 git remote remove sub-repo-2
```

## ⚠️ 8. 서브트리 관리 시 유의사항
✔️ 서브트리 디렉터리에서 직접 Git 작업을 하지 않고 메인 레포지토리에서 관리합니다.
✔️ 서브 레포지토리의 독립성이 유지되므로 다른 프로젝트에서도 재사용이 용이합니다.
✔️ `--squash` 옵션 없이 사용하면 히스토리 전체를 유지할 수 있습니다.
