<img src="https://github.com/user-attachments/assets/36ad1e48-97ad-4c70-94be-a0d604922c9a" width="200" height="200"/>
<br/>

# 🌙 하루의 끝

## 📱 프로젝트 소개
하루를 마무리하며 간단하게 작성하는 일기 앱

## 🕙 프로젝트 기간
2024.11.15 ~ 2024.12.27

## 🛠️ 개발 환경
|  |  |
|:----|:---------|
| 프로그래밍 언어 | Dart 3.5.4 |
| 프레임워크 | Flutter 3.24.5 |
| 개발 툴 | Visual Studio Code, Android Studio IDE |
| 데이터베이스 | Cloud Firestore |
| 사용자 인증 관리 | Firebase Auth |

## 🧑🏻‍💻 기능 설명
<img src="https://github.com/user-attachments/assets/0d4a0f00-8159-479b-8306-5bda8bb06761" width="200"/>
<img src="https://github.com/user-attachments/assets/482b7574-a024-4429-8795-4f66b390dc70" width="200"/>
<img src="https://github.com/user-attachments/assets/1cd4c612-361f-45eb-a646-54247fd7dc52" width="200"/>
로그인 페이지에서는 Firebase Auth를 활용하여 Google 간편 로그인을 적용시켰으며, 로그인 성공 시 Navigator.of(context).pushReplacement()를 통해 화면을 메인 홈 페이지로 전환시킵니다. 이는 push()로 인해 뒤로가기 제스쳐가 가능하게 되어 로그아웃을 하지 않아도 로그인 페이지로 이동하는 것을 막는다.
<br/>
<img src="https://github.com/user-attachments/assets/f9179d12-ee83-440e-87f1-9ff93bbc283c" width="200"/>
<img src="https://github.com/user-attachments/assets/6a4c403b-4148-456c-b7ea-5d241110a3e4" width="200"/>
<img src="https://github.com/user-attachments/assets/40218190-4e30-4054-ac56-8fe945c64967" width="200"/>
메인 홈 페이지에서는 우측 상단에 글쓰기 버튼이 존재하고, 컴포넌트로 Table_Calendar가 존재한다.  날짜를 클릭 시 해당 날짜에 맞는 일기가 아래에 리스트로 나타나며, 상단의 월을 길게 누를 시 현재 날짜로 돌아오게 된다. 그 아래에는 animated_text_kit 라이브러리의 타자치는 애니메이션을 활용하여 앱을 사용하는 사용자에게 동기부여의 목적으로 명언을 제공한다. 그 옆에는 로그아웃 버튼으로 버튼을 누를 시 CupertinoAlertDialog를 통해 한번 더 체크를 하고 로그아웃이 확정된다면 FirebaseAuth와 GoogleSignIn을 모두 signOut()하여 로그인 페이지로 전환시킨다.
<br/>
<img src="https://github.com/user-attachments/assets/4f7d55ed-4987-4400-ae06-fdd426ce9d28" width="200"/>
<img src="https://github.com/user-attachments/assets/b98fecae-fa5c-4305-8740-c778d92903e5" width="200"/>
<img src="https://github.com/user-attachments/assets/27e3a3b7-da2f-4329-bd41-c9257ac0f98f" width="200"/>
<img src="https://github.com/user-attachments/assets/181b44ea-fe41-4b2b-be81-c86a1ea455ff" width="200"/>
<img width="325" alt="스크린샷 2025-01-13 오후 3 14 56" src="https://github.com/user-attachments/assets/e70cb8ba-04d9-4f0e-9a1d-77a4ad0d2341" />
<br/>
글쓰기 버튼을 누르면 작성 스크린으로 라우팅되며 Form 위젯과 TextFormField 위젯을 사용하여 작성 스크린을 구성하였다. onSaved와 validator 속성으로 필드 값을 저장하고 검증하며, 작성 후 완료 버튼을 누르게 되면 키를 검증 후 일기 모델을 생성하고, FirebaseAuth.instance.currentUser.email을 통해 현재 로그인 되어있는 사용자의 정보 중에 email을 가져와 ‘author’로 필드명을 정하여 Firestore에 추가한 후 Navigator.pop(context)를 통해 메인 홈 스크린으로 돌아간다.
홈스크린에서는 StreamBuilder를 통해 선택한 날짜에 해당하는 일기를 비동기로 계속 가져오게 된다. StreamBuilder에서는 에러가 발생하거나 로딩중일 때의 이벤트도 나타낸다. 일기들은 ListView.builder()로 리스트 형태로 나타내며, 각각의 일기는 터치 이벤트와 밀어서 삭제 이벤트를 제공한다. 
<br/>
<img src="https://github.com/user-attachments/assets/66323eb0-8dfb-4edc-932a-64c3ae3db1c7" width="150"/>
<img src="https://github.com/user-attachments/assets/23e83e00-d0c5-42ec-b49c-9d6583c6025f" width="150"/>
<img src="https://github.com/user-attachments/assets/5d1c024a-2c25-45ac-baef-dd400f7729cb" width="150"/>
<img src="https://github.com/user-attachments/assets/d4891396-93a7-4da1-a1f1-ae518b5669d0" width="150"/>
<br/>
일기를 터치하게 되면 상세 스크린으로 이동하며, 이 때 해당 일기 모델(diary)을 넘겨준다. 상세 스크린에서는 넘겨받은 diary의 제목, 내용, 날짜를 가져와 나타내게 된다. 해당 상세 스크린에서는 뒤로가기, 일기 삭제, 일기 수정의 기능을 할 수 있는 이벤트를 제공하며, 수정 이벤트를 실행하게 되면 작성 스크린으로 이동하게 된다. 수정 스크린을 만들지 않고 작성 스크린으로 이동한 이유는 수정 이벤트로 작성 스크린으로 이동 시 diary를 넘겨주게 되며, 작성 스크린에서는 final Diary? diary처럼 nullable 타입으로 받게 된다. diary가 null이 아니라면 수정 모드가 되며, diary를 .copyWith하여 updatedDiary를 만들어 Firestore에 update하고 updatedDiary를 반환하며 상세 스크린으로 돌아간다. 상세 스크린으로 돌아가는 동시에 해당 diary의 제목, 내용을 setState 상태관리를 통해 업데이트 해주게 된다.
<br/>

## 🎬 시연 영상
https://drive.google.com/file/d/1xdlu7Wdv4HiEN09ZpapfQesACZytbDd2/view?usp=sharing

