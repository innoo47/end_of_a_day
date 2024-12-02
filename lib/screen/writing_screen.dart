import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:end_of_a_day/component/customtextfield.dart';
import 'package:end_of_a_day/const/colors.dart';
import 'package:end_of_a_day/model/diary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

class WritingScreen extends StatefulWidget {
  final DateTime selectedDate;

  const WritingScreen({
    super.key,
    required this.selectedDate,
  });

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();

  String? title;
  String? content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: BACKGROUND_COLOR,
        title: Text(
          '일기 쓰기',
          style: TextStyle(
            fontSize: 15.sp,
            fontFamily: 'MaruBuriRegular',
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
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
                    onSaved: (String? val) {
                      content = val;
                    },
                    validator: validator,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => onSavePressed(context),
                    child: const Text(
                      '완료',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'MaruBuriRegular',
                      ),
                    ),
                  ),
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

      // 일기 모델 생성
      final diary = Diary(
        id: Uuid().v4(),
        title: title!,
        content: content!,
        date: widget.selectedDate,
      );

      // 일기 모델 파이어스토어에 삽입
      await FirebaseFirestore.instance
          .collection(
            'diary',
          )
          .doc(diary.id)
          .set(diary.toJson());

      Navigator.pop(context);
    }
  }

  /* 텍스트 필드 값 검증 */
  String? validator(String? val) {
    if (val == null || val.isEmpty) {
      return '을 입력해주세요';
    }

    return null;
  }
}
