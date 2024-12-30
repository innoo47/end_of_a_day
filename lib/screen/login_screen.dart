import 'package:end_of_a_day/const/colors.dart';
import 'package:end_of_a_day/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';

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
                width: 200.w,
                height: 300.h,
                fit: BoxFit.cover,
              ),
              /* 간편 로그인 버튼 */
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /* Google 로그인 버튼 */
                    ElevatedButton.icon(
                      onPressed: () => onGoogleLoginPress(context),
                      label: Text(
                        'Google로 시작하기',
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 13.sp,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: Image(
                        width: 13.w,
                        height: 13.h,
                        image: AssetImage('assets/icon/google.png'),
                        fit: BoxFit.scaleDown,
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xffffffff),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    /* Kakao 로그인 버튼 */
                    ElevatedButton.icon(
                      onPressed: () => onGoogleLoginPress(context),
                      label: Text(
                        '카카오로 시작하기',
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 13.sp,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: Image(
                        width: 13.w,
                        height: 13.h,
                        image: AssetImage('assets/icon/kakao.png'),
                        fit: BoxFit.scaleDown,
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xfffee500),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    /* Naver 로그인 버튼 */
                    ElevatedButton.icon(
                      onPressed: () => onGoogleLoginPress(context),
                      label: Text(
                        '네이버로 시작하기',
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 13.sp,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: Image(
                        width: 13.w,
                        height: 13.h,
                        image: AssetImage('assets/icon/naver.png'),
                        fit: BoxFit.scaleDown,
                        color: Color(0xffffffff),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xff03c75a),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
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

  /* Google 로그인 버튼을 누를 시 */
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
