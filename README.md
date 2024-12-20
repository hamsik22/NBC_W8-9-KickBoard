# NBC_W8-9 TeamProject

![QuickKickThumnail](https://github.com/user-attachments/assets/e180aaf2-c8e3-46bc-98c9-6a7a6c7c4c02)

## <img src="https://github.com/user-attachments/assets/69395a63-42be-4b6b-a85f-dbebaaceb7ac" width="30"> QuickKick

### Quick + KickBoard = QuickKick
**빠르게 킥보드를 찾아타는 앱!**

### 와이어프레임 & 브레인스토밍
- 🔗[와이어프레임](https://www.figma.com/design/JTTqG16POU5bwqaHtHvPcT/NBC_8-9_Design?node-id=0-1&t=x16GFIJlzrqpyz03-1)
- 🔗[브레인스토밍](https://www.figma.com/board/QEBn7ce3IFbRMrLfYlQJXD/NBC_8-9_Figjam?node-id=0-1&t=9y1MCvMFogiRjEb4-1)

## 👥 팀원 소개 및 역할
| 🎯Leader | 💻Development | 💻Development | 💻Development | 💻Development |
| :-: | :-: | :-: | :-: | :-: |
| **황석현** | **장상경** | **전지혜** | **이명지** | **반성준**
| 로그인 화면 | 킥보드 상세 페이지 | 킥보드 등록 페이지 | 킥보드 찾기 페이지 | 마이 페이지 |
| 회원가입 화면 | 메인 탭 바 |  | | 코어 데이터 관리 |

## 🔥 프로젝트 목표

### 팀 핵심 목표
- 필수 구현 사항을 모두 완료하기
- 각자 최소 1개 이상의 기능, UI 구현
- 협업을 위한 활발한 소통
- 마일스톤 준수하기
- 코드리뷰를 통한 협업 능력치 상승

### 기대 효과
- 협업을 통한 팀워크 향상
- 개인 역량 강화
- 데이터 구조 학습
- API 이해도 증가

## 💿 프로젝트 기술 스택

### 데이터 구조
- **아키텍처 패턴**: `MVC` 패턴
- **데이터 저장 방식**: `UserDefaults`, `CoreData`
- **데이터 전달 방식**: `Delegate` 패턴

### 프로젝트 구조도

<img width="800" alt="NBC_8-9_Figjam (2)" src="https://github.com/user-attachments/assets/e5368aca-e1bc-4c7c-8c6e-10b91fc031b5" />


### 프로젝트 흐름도

<img width="800" alt="NBC_8-9_Figjam (3)" src="https://github.com/user-attachments/assets/0a8dffe1-7f64-40d9-ab02-eba8e66cab03" />

## ⏰ 프로젝트 진행 일정

### 진행 기간
- **시작**: 12.13(금) 17:00
- **종료**: 12.20(금) 12:00 까지

### 스프린트
- **Sprint 1** : ~ 12.18(**수요일 오전**)
- **Sprint 2** : ~ 12.19(**목요일 오후**)

### 스크럼
- **오전 11시** 튜터님과 스크럼: 마일스톤 진척도 확인, 피드백
- **오후 5시** 팀원들과 스크럼: 금일 작업 내용, 진행도, 이슈 등 공유

## 📓 Git 컨벤션

### 커밋 컨벤션

| 커밋 유형 | 의미 |
| --- | --- |
| feat: | 새로운 기능  추가 |
| add: | Feat 의외의 부수적인 코드 추가 |
| file: | 새로운 파일 및 폴더 추가 |
| fix: | 버그, 오류 해결 |
| del: | 파일을 삭제하는 작업만 수행한 경우 |
| mod: | UI 수정 |
| comment: | 필요한 주석 추가 및 변경 |
| rename: | 파일 또는 폴더 명을 수정 |
| move:  | 프로젝트 내 파일이나 코드의 이동 |
| docs:  | README나 WIKI 등의 문서 개정 |
| proj: | 프로젝트 관련 설정 변경 |

### Git Flow

<img width="800" alt="NBC_8-9_Figjam (4)" src="https://github.com/user-attachments/assets/322d7cba-7074-4bfd-8591-f9a46becabac" />

### 브랜치 룰

1. **main 브랜치에 프로젝트 기본 세팅**
    - README 작성
    - .gitignore 파일 작성
    - 프로젝트 파일 생성(Xcode)
    - 코드베이스 기본 세팅(스토리보드 삭제, info 설정 등)
    - 프로젝트 Asset 추가(이미지, 컬러세트 등)
    - 프로젝트 디렉토리 분리(각 역할 별로 분리)
    - 코어 데이터 추가
    
2. **dev 브랜치 생성(main 브랜치를 기준으로)**
    - 메인 브랜치에 만들어진 내용을 복제
    - 작업 브랜치(Default)를 dev 브랜치로 설정
    
3. **팀원별 원격 브랜치 분리**
    - dev 브랜치를 기준으로 원격 브랜치를 분리
    - 세부적인 작업 내용은 로컬 브랜치로 분리
  
4. **PR-Merge 전략**
    - PR을 작성할 때는 신규 내용, 변경 내용, 문제점 등을 상세히 작성
    - 팀원 모두는 PR에 대해 코멘트를 작성
    - **2**명의 **`approve`** 필요

5. **모든 작업 완료 후 test 브랜치를 생성**
    - dev 브랜치의 내용을 test 브랜치로 복제
    - test 브랜치에서 프로젝트 버그 확인 및 수정
    - 필요에 따라 hotFix 브랜치를 생성하여 운영

6. **완성된 프로젝트를 main에 전달**
    - `test`브랜치의 작업 내용을 `main` 브랜치에 **스쿼시 머지**
    - 불필요한 브랜치 삭제
    - README 수정

## 🚨 트러블 슈팅


## 🛠️ 1. Core Data Fetch 문제
### 문제
`MyPageViewController`에서 Core Data Fetch 이후 데이터가 `KickboardSectionView`와 `HistorySectionView`에 표시되지 않는 문제 발생.

### 원인
- Core Data Fetch 후 UI 갱신 로직이 누락됨.
- Fetch한 데이터를 뷰로 전달하지 않음.

### 해결
Core Data에서 데이터를 Fetch한 후 `configureSections()` 메서드를 호출하여 데이터를 UI에 전달하고 갱신하도록 수정하였습니다.

```swift
private func loadKickboards() {
    do {
        kickboardData = try CoreDataManager.shared.context.fetch(Kickboard.fetchRequest())
        configureSections() // Fetch 후 UI 갱신
    } catch {
        print("킥보드 데이터를 불러오는 데 실패했습니다: \(error)")
    }
}
```
## 🛠️ 2. UIButton offset 문제
### 문제
![Screenshot 2024-12-16 at 17 36 05](https://github.com/user-attachments/assets/deaa3c29-4a08-4040-98f6-03cb3f06ae77)
`systemImage`로 구성한 `UIButton`에 `backgroundColor`를 지정했을 때 자동으로 `Baseline offset`이 생겨 원치 않는 흰 테두리가 생기는 문제
### 원인
`Baseline offset`이 `UIButton`의 default임
### 해결
```swift
button.imageView?.contentMode = .center
```
![Screenshot 2024-12-19 at 21 18 44](https://github.com/user-attachments/assets/1fc1c21e-800c-4178-b645-0a93e4395a2a)
<br>버튼 내 이미지 뷰가 `button`의 `bounds`의 중앙에 있겠다는 명령으로, `baseline offset`을 무시하게 됨.
## 3. addressLabel font 문제
### 문제
![Screenshot 2024-12-19 at 21 13 00](https://github.com/user-attachments/assets/850b4e6d-d689-4f3c-ae9a-58cb8713296a)
<br>주소가 길어질 경우 `label.text`가 컨테이너 밖으로 벗어나는 문제
### 원인
- `label.font`가 정적인 값을 가짐
- `label`의 `leading`과 `trailing`에 대한 제약조건이 걸려있지 않음
### 해결
```swift
label.adjustsFontSizeToFitWidth = true
```
```swift
addressLabel.snp.makeConstraints {
    $0.leading.equalToSuperview().offset(8)
	$0.trailing.equalToSuperview().offset(-8)
}
```
![Screenshot 2024-12-19 at 21 20 28](https://github.com/user-attachments/assets/e1ef323e-1579-4f88-b063-b7a73f6a6e48)
