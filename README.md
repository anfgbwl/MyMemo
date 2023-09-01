# nbcamp-Project-MyMemo
[내일배움캠프 iOS트랙] 4~5주차 개인과제 - 메모앱(My Todo List) 만들기<br>

[내일배움캠프 iOS트랙] 7~8주차 개인과제 - 메모앱(My Todo List) 심화
<br><br><br><br>

## 🧑🏻‍💻 프로젝트 소개
"메모앱(My Todo List)" 프로그램<p>
이 프로젝트는 Swift 언어를 사용하여 Xcode에서 개발한 애플리케이션입니다. <br>
사용자들은 이 앱을 통해 일상 생활에서 필요한 메모를 효율적으로 관리할 수 있습니다. <br>
메모를 작성하고 편집하며, 중요도, 카테고리, 목표일 등을 설정하여 메모를 조직할 수 있습니다. 또한 스와이프 기능을 통해 완료된 메모를 간편하게 삭제하거나 관리할 수 있습니다.


<br><br>

## 🧠 MVC 구조
![‎MVC](https://github.com/anfgbwl/MyMemo/assets/53863005/fb03e31c-705d-4f44-bff3-c6a86677d825)
#### 1. View
- Main 스토리보드: 앱의 화면 구조와 각각의 뷰 컨트롤러들이 어떻게 연결되어 있는지 정의하는 역할을 합니다.
- Launch Screen: 앱을 실행할 때 보이는 초기 화면으로, 앱을 빠르게 로딩하기 위해 사용되는 이미지 또는 인터페이스를 포함합니다.
#### 2. View Controllers
- ViewController: 주로 앱의 초기 화면이나 기본적인 UI 구성을 다루는 뷰 컨트롤러입니다.
- TableViewController: 테이블 뷰를 사용하는 화면을 다루는 뷰 컨트롤러로, 테이블 뷰의 데이터 소스 및 델리게이트 역할을 수행할 수 있습니다.
- DetailViewController: 특정 항목의 상세 정보를 보여주는 화면을 다루는 뷰 컨트롤러입니다.
- CompleteViewController: 완료된 작업 목록 등을 보여주는 화면을 다루는 뷰 컨트롤러입니다.
- PetViewController: 애완동물 정보 등을 보여주는 화면을 다루는 뷰 컨트롤러입니다.
- TableViewCell: 테이블 뷰에서 각 셀의 디자인과 내용을 정의하는 역할을 하는 커스텀 테이블 뷰 셀입니다.
#### 3. Model
- Todo: 할 일 정보를 담고 있는 데이터 모델 클래스로, 제목이나 내용과 같은 필요한 정보를 저장하고 관리합니다.
- TodoManager: 할 일 목록을 관리하고 조작하는 로직을 담당하는 클래스입니다. 할 일의 추가, 수정, 삭제 등을 다룹니다.
- RandomImage: 랜덤 이미지를 가져오는데 관련된 로직을 다루는 클래스로, 이미지 URL을 생성하거나 이미지를 가져오는 작업을 처리합니다.
<br>
  
> **View Controller Lifecycle**
> <br>
>- ViewController: 메인 이미지 호출 _(viewDidLoad)_
>- TableViewController: Todo data 호출 _(viewWillAppear)_, Todo 추가 시 Alert 내에서 호출
>- DetailViewController: Todo data 내 filter를 통해 isCompleted가 false인 Todo를 화면에 노출 _(viewWillAppear)_
>- PetViewController: 스켈레톤뷰 호출 _(viewWillAppear)_, 랜덤 이미지뷰 호출 _(viewDidLoad)_

<br><br>

## 🛠️ 사용한 기술 스택 (Tech Stack)
<img src="https://img.shields.io/badge/Swift-F05138?style=for-the-badge&logo=Swift&logoColor=white"><img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white">


<br><br>

## 🗓️ 개발 기간
* 2023-07-31(월) ~ 2023-08-10(목), 9일간
* 2023-08-23(수) ~ 2023-08-29(화), 5일간

<br><br>

## 📌 주요 기능(update_230831)
#### 할 일 추가
- 텍스트 편집기를 통해 할 일 추가
- 할 일 생성은 간단하게 내용만 작성
- 작성일자 자동 저장
#### 할 일 목록
- 추가한 모든 할 일을 카테고리별로 확인
- 내용과 작성 일자, 완료 여부, 완료 및 미완료 건수 확인
- 스와이프 제스처를 통해 삭제하거나, 스위치 토글을 통해 상태를 변경할 수 있음
#### 할 일 수정 및 상세 설정
- 할 일 목록에서 선택한 메모의 상세 정보 확인 및 편집 기능
- 내용을 수정할 수 있을 뿐만 아니라 목표 일자, 중요도, 카테고리, 진행율 등을 변경할 수 있음
#### 중요도 및 카테고리 설정
- 사용자는 메모 작성 및 편집 과정에서 중요도와 카테고리를 설정할 수 있음
- 각 항목을 선택하거나 변경할 수 있는 인터페이스를 제공하며, 선택된 항목은 할 일에 반영됨
#### 진행율 설정
- 진행 상황을 나타내는 슬라이더가 있음
- 할 일의 진행 상황을 조정하고 업데이트할 수 있음
#### 완료된 목록
- 완료된 할 일을 확인할 수 있으며, 스위치를 작동하여 할 일 목록으로 이동할 수 있음
- 완료된 목록을 전체 삭제할 수 있는 기능
#### 랜덤 고양이 사진 보기
- the Cat API의 고양이 사진을 랜덤으로 보여줌
- 하단 꾹꾹이 버튼을 누르면 고양이 사진 랜덤으로 변경
- api 로드될 때 스켈레톤뷰를 이용하여 로드됨을 사용자에게 보여줌


<br><br>

## 🧐 앱 실행 및 사용 방법
#### Version 1
![앱실행화면](https://github.com/anfgbwl/MyMemo/assets/53863005/9cce8f32-20f9-43b6-a950-14b8d9010260)
#### Version 2
![APP IMAGE](https://github.com/anfgbwl/MyMemo/assets/53863005/738c4f98-fbe5-4482-bea3-d38cdb97ebd2)



<br><br>

## 💡 추가할 기능

1. 메인화면<br>
- 버튼 대신 Tool Bar 사용

2. 할 일 목록<br>
- 검색 기능(기본: 타이틀, 카테고리/중요도 필터 처리)
- '중요도 높음' 할 일에 대한 추가 UI 구성
- 작성일자 기준 위로 목록 추가
- 스위치 작동 시 n초 후 목록에서 제거(타이머 기능 추가)

3. 할 일 수정<br>
- 목표일자: 현재기준 이전 날짜 선택 불가
- 메모 박스 추가
- 이미지 추가

<br><br>

## 🚨 현재 오류
- 중요도 및 카테고리 버튼 클릭 시 설정 후 저장했는데도 다시 로드하면 기본값으로 체크표시 되어 있음(화면에 표시되는 내용 및 데이터는 정상)
- ~~진행율 Slider thumb 크기 조정 실패(수치값 표현이 안되어 확인이 어려움, 보완 예정)~~
  ➡️ Slider thumb 이미지 설정하여 사이즈 조정 완료

<br><br>

## 💥 트러블 슈팅
- 디테일페이지에서 수정 후 저장 누르고 이전 화면으로 돌아가지 않는 문제 발생(popViewController 작동안함)<br>
➡️ (원인) Alert가 dismiss 된 후 popVC이 실행될 시간이 없어 작동하지 않음<br>
➡️ <span style="color:red">(해결방안) DispatchQueue를 통해 popVC이 실행될 시간을 지정함</span>
- 테이블뷰의 섹션 및 헤더 Height 값을 지정했으나 시뮬레이터에 나오지 않는 문제 발생<br>
➡️ (원인) 테이블뷰의 스타일이 Plain로 설정되어 있음<br>
➡️ (해결방안) 테이블뷰 스타일을 Grouped로 설정
- memoList에 있는 카테고리를 Set을 통해 집합을 만들었으나 실행하니 순서가 뒤죽박죽이 되는 문제 발생<br>
➡️ (원인) set 함수는 순서가 없음<br>
➡️ (해결방안) let categories = Array(Set(MemoManager.shared.memoList.map { $0.category ?? "일반" })).sorted() 를 전역변수로 선언하여 사용
- 디테일페이지로 들어가면 섹션의 셀의 내용이 처음 추가한 셀의 내용과 동일하게 나오는 문제 발생<br>
➡️ (원인) set 함수는 순서가 없음! 따라서 sorted된 변수(상수)를 만들어서 사용해야 함<br>
➡️ (해결방안) 기존 tableView[indexPath.row]를 카테고리에 맞는 값으로 변경
