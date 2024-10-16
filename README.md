# MediaBox 

<br>

> ### 스크린샷

| 인기 컨텐츠 조회 | 상세 | 티저영샹 | 
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

1. A 개발자가 APIKey파일을 .gitignore 설정 후, remote에 push
   
2. remote의 변경을 알게 된 B 개발자가 remote를 pull하면 아래와 같이 프로젝트가 빌드되지 않음 
<img width="270" alt="스크린샷 2024-10-15 오후 5 54 10" src="https://github.com/user-attachments/assets/229bfbd5-8f8c-4172-899d-f5167fea4578">

4. B 개발자의 pbxproj 파일은 remote와 동일한 버전이지만 APIKey 파일은 git에서 관리되지 않아 B개발자의 프로젝트에서는 APIKey파일의 참조만 갖고 있는 상태인 것이 원인

5. 4.를 알게된 B 개발자는 사전에 협의한 내용과 동일한 APIKey 파일을 동일한 경로에 추가한 후 빌드하여 개별 작업 진행

6. A 개발자는 3.의 사실을 모르고 새로운 파일을 프로젝트에 추가한 뒤 다시 remote에 push

7. remote가 변경된 것을 확인한 B 개발자가 pull을 수행하면 아래와 같이 pbxproj 파일에서 conflict가 발생

테스트 

<img width="1148" alt="스크린샷 2024-10-15 오후 6 45 08" src="https://github.com/user-attachments/assets/a5ac32da-f8ed-47f2-99d2-2d79318868aa">

<br>

> ### RxDataSource Configure

<br>

## 회고

> ### 성취점
- 공통된 UI 컴포넌트와 View용 모델의 인터페이스를 협의를 통해 설계한 점
- 코드 컨벤션, 브랜치 전략, Git 컨벤션, PR 템플릿에 기반한 상호 코드 Review를 통해 일관된 Rule기반의 프로젝트 관리를 수행한 점 

<br>

> ### 개선사항
- 이미지 다운샘플링을 통한 성능개선
- 네트워크 매니저의 모듈화



