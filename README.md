## 프로젝트 정보

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

| 버전관리
- Github (git)

| 협업 툴
-  Notion (Kanban Board) 

| 코드 컨벤션
- SwiftLint
- 커스텀 Rule 설정

| 커밋 컨벤션
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

| PR 템플릿
<div align="center">
 <img width="823" alt="스크린샷 2024-10-15 오후 4 14 08" src="https://github.com/user-attachments/assets/6ea1c200-47ad-4da5-85b2-f5fdb22c8a4a">   
</div>

<br>

## 브랜치 전략

- Git-flow 전략 기반으로 main, develope, feature로 나누어 개발
- Feature 브랜치 명을 Notion Kanban Board의 티켓과 일치시키도록 Rule 수립  

<br>

## 역할분담

| 조규연
- 페이지: 인기 영화 / TV시리즈 조회 화면, 티저 영상 WebView
- 공통 컴포넌트: CustomButton, PosterContent, PosterCell

| 유철원
- 페이지: 상세화면
- 공통 컴포넌트: PosterImageView


 ## 구현사항

| 네트워킹
 - NetworkManager
 - Router
 - TargetType

| protocol 기반의 UI용 모델 인터페이스 구현  

| RxdataSource + CompositaionlLayout
- AnitableSectionModel 


<br>

## 트러블 슈팅

| pbxproj Conflict 

| RxDatasSource Configure

<br>

## 회고

| 성취점
- 

| 개선사항
- 



