import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:end_of_a_day/component/customtextfield.dart';
import 'package:end_of_a_day/const/colors.dart';
import 'package:end_of_a_day/model/diary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

class WritingScreen extends StatefulWidget {
  final DateTime selectedDate;
  final Diary? diary;

  const WritingScreen({
    super.key,
    required this.selectedDate,
    this.diary,
  });

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();

  String? title;
  String? content;

  @override
  void initState() {
    super.initState();

    // 수정모드일 경우 기존 데이터 초기화
    if (widget.diary != null) {
      title = widget.diary!.title;
      content = widget.diary!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_DARK_COLOR,
      appBar: AppBar(
        backgroundColor: BACKGROUND_DARK_COLOR,
        title: Text(
          widget.diary == null ? '일기 쓰기' : '일기 수정',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.sp,
            fontFamily: 'MaruBuriRegular',
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 15.sp,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: Column(
              children: [
                CustomTextField(
                  maxLength: 30,
                  maxLines: 1,
                  fontSize: 18,
                  labelText: '제목',
                  initialValue: title,
                  onSaved: (String? val) {
                    // 저장 하면 title 변수에 텍스트 필드 값 저장
                    title = val;
                  },
                  validator: validator,
                ),
                Expanded(
                  child: CustomTextField(
                    maxLength: 500,
                    maxLines: null,
                    fontSize: 13,
                    labelText: '내용을 입력하세요',
                    initialValue: content,
                    onSaved: (String? val) {
                      content = val;
                    },
                    validator: validator,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => onSavePressed(context),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: BUTTON_DARK_COLOR,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      widget.diary == null ? '완료' : '수정',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'MaruBuriRegular',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /* 저장 버튼을 누를 시 */
  void onSavePressed(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      // 작성 모드
      if (widget.diary == null) {
        // 일기 모델 생성
        final diary = Diary(
          id: Uuid().v4(),
          title: title!,
          content: content!,
          date: widget.selectedDate,
        );

        // 현재 로그인 되어있는 사용자 정보를 가져옴
        final user = FirebaseAuth.instance.currentUser;

        if (user == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('다시 로그인 해주세요'),
            ),
          );

          Navigator.of(context).pop();

          return;
        }

        // 일기 모델 파이어스토어에 삽입
        await FirebaseFirestore.instance
            .collection(
              'diary',
            )
            .doc(diary.id)
            .set(
          {
            ...diary.toJson(),
            'author': user.email,
          },
        );

        Navigator.pop(context);
      } else {
        // 수정 모드
        final updatedDiary = widget.diary!.copyWith(
          title: title!,
          content: content!,
        );

        await FirebaseFirestore.instance
            .collection('diary')
            .doc(updatedDiary.id)
            .update(updatedDiary.toJson());

        Navigator.pop(context, updatedDiary);
      }
    }
  }

  /* 텍스트 필드 값 검증 */
  String? validator(String? val) {
    if (val == null || val.isEmpty) {
      return '값을 입력해주세요';
    }

    return null;
  }
}
