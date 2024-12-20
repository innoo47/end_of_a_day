import 'package:end_of_a_day/const/colors.dart';
import 'package:end_of_a_day/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_DARK_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /* 하루의 끝 로고 */
              Image(
                image: AssetImage('assets/images/main_image.png'),
                width: 160.w,
                height: 160.h,
              ),
              /* 로그인 버튼 */
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /* Google 로그인 버튼 */
                  ElevatedButton.icon(
                    onPressed: () => onGoogleLoginPress(context),
                    label: Text('Google로 시작하기'),
                    icon: Image(
                      width: 20.w,
                      height: 20.h,
                      image: NetworkImage(
                          'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png'),
                      fit: BoxFit.scaleDown,
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: BUTTON_DARK_COLOR,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  /* Apple 로그인 버튼 */
                  ElevatedButton.icon(
                    onPressed: () => onGoogleLoginPress(context),
                    label: Text(' Apple로 시작하기'),
                    icon: Image(
                      width: 20.w,
                      height: 20.h,
                      image: NetworkImage(
                          'https://cdn.icon-icons.com/icons2/1488/PNG/512/5315-apple_102578.png'),
                      fit: BoxFit.scaleDown,
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: BUTTON_DARK_COLOR,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onGoogleLoginPress(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email'],
    );

    try {
      GoogleSignInAccount? account = await googleSignIn.signIn();

      // AccessToken과 idToken을 가져올 수 있는 GoogleSignInAuthentication 객체를 불러옴
      final GoogleSignInAuthentication? googleAuth =
          await account?.authentication;

      // AuthCredential 객체를 상속받는 GoogleAuthProvider 객체를 생성
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // signInWithCredential() 함수를 이용하여 파이어베이스 인증
      await FirebaseAuth.instance.signInWithCredential(credential);

      // 인증이 완료되면 HomeScreen으로 이동
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => HomeScreen(),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('로그인 실패'),
        ),
      );
    }
  }
}
