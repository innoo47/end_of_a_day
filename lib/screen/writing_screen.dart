import 'package:end_of_a_day/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WritingScreen extends StatelessWidget {
  const WritingScreen({super.key});

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: Column(
            children: [
              TextFormField(
                cursorColor: Colors.grey,
                maxLength: 30,
                maxLines: 1,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontFamily: 'MaruBuriRegular',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: '제목',
                  labelStyle: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w100,
                    fontFamily: 'MaruBuriRegular',
                  ),
                  floatingLabelStyle: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w100,
                    fontFamily: 'MaruBuriRegular',
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  cursorColor: Colors.grey,
                  keyboardType: TextInputType.text,
                  maxLength: 500,
                  maxLines: null,
                  expands: false,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black,
                    fontFamily: 'MaruBuriRegular',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: '내용을 입력하세요',
                    labelStyle: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w100,
                      fontFamily: 'MaruBuriRegular',
                    ),
                    floatingLabelStyle: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w100,
                      fontFamily: 'MaruBuriRegular',
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: onSavePressed,
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
    );
  }

  void onSavePressed() {}
}
