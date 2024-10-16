# MediaBox 

<br>

> ### 스크린샷

| 인기 컨텐츠 조회 | 상세 | 티저영상 | 
| --- | --- | --- |
| ![Simulator Screenshot - iPhone 15 - 2024-10-15 at 17 33 35](https://github.com/user-attachments/assets/ddbcb7cd-e659-46f2-92bd-c71ca2c74c00) | ![Simulator Screenshot - iPhone 15 - 2024-10-15 at 17 35 27](https://github.com/user-attachments/assets/a3cdb9f7-395d-4b3f-9cbe-e0b04024a3e0) | ![Simulator Screenshot - iPhone 15 - 2024-10-15 at 17 36 05](https://github.com/user-attachments/assets/06ba6a6b-42bf-46e2-8d5c-729ae669ee04) |

<br>

> ### 프로젝트 소개

- 지금 인기 있는 영화나 TV시리즈를 검색하고 상세정보를 조회할 수 있는 서비스

<br>

> ### 프로젝트 정보
- 개발기간: 2024.10.08 ~ 2024.10.14일
- 개발인원: 클라이언트 2명

<br>

## 주요기능

- 인기 영화 / TV 시리즈 조회
- 영화 / TV시리즈 상세 정보 조회
- 영화 / TV시리즈 티저 영상 WebView 조회

<br>

## 기술스택

- MVVM, Input/Output
- UIKit, SnapKit
- RxSwift, RxCocoa, RxDataSource
- Alamofire, KingFisher
- SwiftLint
- Toast

<br>

## 개발환경

<br>

> ### 최소버전
- iOS 15.0이상 

<br>

> ### 버전관리
- Github (git)

<br>

> ### 협업 툴
-  Notion (Kanban Board) 

<br>

> ### 코드 컨벤션
- SwiftLint
- 커스텀 Rule 설정

<br>

> ### 커밋 컨벤션
- Karma 컨벤션 중 브랜치 전략에 필요한 컨벤션 
- Feature 브랜치 내에서는 작동가능한 코드를 기준으로 커밋 단위 설정 

| Tag Name | Description |
| --- | --- |
| [Feat] | 새로운 기능을 추가 |
| [Fix] | 버그 수정 |
| [Design] | CSS 등 사용자 UI 디자인 변경 |
| [Style] | 코드 포맷 변경, 세미 콜론 누락, 코드 수정이 없는 경우 |
| [Refactor] | 프로덕션 코드 리팩토링 |
| [Comment] | 필요한 주석 추가 및 변경 |
| [Remove] | 파일을 삭제하는 작업만 수행한 경우 |
| [Add] | 파일을 추가하는 작업만 수행한 경우 |
| [Conflict] | Git Conflict 수정 커밋 |

<br>

> ### PR 템플릿
<div align="center">
 <img width="823" alt="스크린샷 2024-10-15 오후 4 14 08" src="https://github.com/user-attachments/assets/6ea1c200-47ad-4da5-85b2-f5fdb22c8a4a">   
</div>

<br>

## 브랜치 전략

- Git-flow 전략 기반으로 main, develope, feature로 나누어 개발
- Feature 브랜치 명을 Notion Kanban Board의 티켓과 일치시키도록 Rule 수립  

<br>

## 역할분담

> ### 조규연
- 페이지: 인기 영화 / TV시리즈 조회 화면, 티저 영상 WebView
- 공통 컴포넌트: CustomButton, PosterContent, PosterCell

<br>

> ### 유철원
- 페이지: 상세화면
- 공통 컴포넌트: PosterImageView

<br>

 ## 구현사항

> ### 네트워킹
 - NetworkManager, Router Pattern, TargetType 을 이용해 여러 API 호출 함수들을 모듈화

<br>

> ### protocol 기반의 UI용 모델 인터페이스 구현  
<img width="311" alt="스크린샷 2024-10-16 오후 3 01 07" src="https://github.com/user-attachments/assets/c75f9c15-474e-4cc4-ba32-e242783c8a46">

<br>

> ### RxdataSource + CompositionalLayout
- AnimatableSectionModel: 데이터 개수 변경에 따른 자연스러운 애니메이션 동작

<br>

## 트러블 슈팅

<br>

> ### pbxproj Conflict

<br>

**문제상황**

- gitignore 설정한 파일을 프로젝트에 생성한 상태로 push. pbxproj에 해당 파일의 경로가 남아 pull 받은 쪽에서 프로젝트가 파일의 참조만 갖는 상태로 빌드되지 않음.
 <img width="270" alt="스크린샷 2024-10-15 오후 5 54 10" src="https://github.com/user-attachments/assets/229bfbd5-8f8c-4172-899d-f5167fea4578">

- pull받은 쪽의 로컬에서 문제가 되는 파일을 동일경로에 생성한 후 빌드에 성공하더라도 리모트에 추가 변경사항 발생시 pbxproj 파일에서 반복적으로 conflict 발생.
 <img width="1080" alt="스크린샷 2024-10-16 오후 3 53 30" src="https://github.com/user-attachments/assets/e7902560-d2f8-45e6-9582-3a368c5ff788">

<br>

**원인추론**

  1. gitignore 설정한 파일을 프로젝트에 생성한 후 remote에 push
     - remote의 pbxproj 파일에는 해당 파일의 identifier와 경로가 추가됨
     - git에서는 관리되지 않으므로 해당 파일은 업로드 되지 않음
  2. 첫 번째 문제를 해결하기 위해 로컬에서 생성한 파일은 pbxproj의 파일과 경로가 동일하더라도 다른 identifier(Hash)를 가짐

<br>

**해결방법**

최초 프로젝트 설정 시 gitignore 파일만 팀에 공유한 후 각자 로컬에서 gitignore 처리된 파일을 협의된 경로에 동일한 내용으로 생성

<br>

## 회고

> ### 성취점
- 공통된 UI 컴포넌트와 View용 모델의 인터페이스를 협의를 통해 설계한 점
- 코드 컨벤션, 브랜치 전략, Git 컨벤션, PR 템플릿에 기반한 상호 코드 Review를 통해 일관된 Rule기반의 프로젝트 관리를 수행한 점 

<br>

> ### 개선사항
- 이미지 다운샘플링을 통한 성능개선
- 네트워크 매니저의 모듈화



