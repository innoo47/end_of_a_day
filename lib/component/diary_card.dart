import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:end_of_a_day/const/colors.dart';
import 'package:end_of_a_day/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DiaryCard extends StatelessWidget {
  const DiaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: COMPONENT_DARK_COLOR,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.centerLeft,
            height: 60,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 28, right: 8, top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /* 명언 */
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          '오늘이라는 날은 두 번 다시\n오지 않는다는 것을 잊지마라 - 단테',
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp,
                            fontFamily: 'MaruBuriSemiBold',
                          ),
                          speed: const Duration(milliseconds: 80),
                        ),
                      ],
                      pause: const Duration(milliseconds: 1000),
                      isRepeatingAnimation: true,
                      repeatForever: true,
                    ),
                    /* 로그아웃 버튼 */
                    IconButton(
                      onPressed: () async {
                        final dialog = await showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: Text('로그아웃'),
                              content: Text('정말로 로그아웃 하시겠습니까?'),
                              actions: [
                                CupertinoDialogAction(
                                  isDefaultAction: true,
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text('취소'),
                                ),
                                CupertinoDialogAction(
                                  isDestructiveAction: true,
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: Text('로그아웃'),
                                ),
                              ],
                            );
                          },
                        );

                        if (dialog) {
                          // 로그아웃
                          await FirebaseAuth.instance.signOut();
                          await GoogleSignIn().signOut();

                          // 로그인 화면으로 이동
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => LoginScreen(),
                            ),
                          );
                        }
                      },
                      icon: Icon(Icons.logout_rounded),
                      color: Colors.white,
                      iconSize: 16.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
