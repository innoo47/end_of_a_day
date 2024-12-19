import 'package:end_of_a_day/const/colors.dart';
import 'package:end_of_a_day/main.dart';
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
      backgroundColor: BACKGROUND_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /* 하루의 끝 타이틀 */
              Image(
                image: AssetImage('assets/images/main_image.png'),
                width: 160.w,
                height: 160.h,
              ),
              /* Google 로그인 버튼 */
              OutlinedButton(
                onPressed: () => onGoogleLoginPress(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      width: 20.w,
                      height: 20.h,
                      image: NetworkImage(
                          'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png'),
                      fit: BoxFit.scaleDown,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      'Google로 시작하기',
                      style: TextStyle(
                        fontFamily: 'MaruBuriSemiBold',
                        fontSize: 11.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
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
      Navigator.of(context).push(
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
