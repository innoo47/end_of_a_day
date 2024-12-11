import 'package:end_of_a_day/model/diary.dart';
import 'package:end_of_a_day/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:end_of_a_day/screen/writing_screen.dart';

class DetailScreen extends StatefulWidget {
  final DateTime selectedDate;
  final Diary diary;

  const DetailScreen({
    super.key,
    required this.selectedDate,
    required this.diary,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: BACKGROUND_COLOR,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 38,
            vertical: 18,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* 제목 */
              Text(
                widget.diary.title,
                style: TextStyle(
                  fontSize: 19.sp,
                  fontFamily: 'MaruBuriSemiBold',
                ),
                softWrap: true,
              ),
              SizedBox(
                height: 10.h,
              ),
              /* 작성 일자 */
              Text(
                '${widget.selectedDate.year}년 ${widget.selectedDate.month.toString().padLeft(2, '0')}월 ${widget.selectedDate.day.toString().padLeft(2, '0')}일 작성',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontFamily: 'MaruBuriExtraLight',
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              /* 내용 */
              Text(
                widget.diary.content,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: 'MaruBuriRegular',
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  '삭제',
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'MaruBuriSemiBold',
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WritingScreen(
                        selectedDate: widget.selectedDate,
                        diary: widget.diary,
                      ),
                    ),
                  ).then((value) => setState(() {}));
                },
                child: Text(
                  '수정',
                  style: TextStyle(
                    fontFamily: 'MaruBuriSemiBold',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
