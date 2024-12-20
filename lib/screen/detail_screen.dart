import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:end_of_a_day/const/colors.dart';
import 'package:end_of_a_day/model/diary.dart';
import 'package:end_of_a_day/screen/writing_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  String? title;
  String? content;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.diary.title;
    content = widget.diary.content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_DARK_COLOR,
      appBar: AppBar(
        backgroundColor: BACKGROUND_DARK_COLOR,
        leading: IconButton(
          onPressed: () => Navigator.pop(context, false),
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
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
                title!,
                style: TextStyle(
                  color: Colors.white,
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
                  color: TEXT_FIELD_FILL_COLOR,
                  fontSize: 11.sp,
                  fontFamily: 'MaruBuriExtraLight',
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              /* 내용 */
              Text(
                content!,
                style: TextStyle(
                  color: Colors.white,
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
              // 삭제
              GestureDetector(
                onTap: () async {
                  final dialog = await showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Text('일기 삭제'),
                        content: Text('정말로 삭제하시겠습니까?'),
                        actions: [
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text('취소'),
                          ),
                          CupertinoDialogAction(
                            isDestructiveAction: true,
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text('삭제'),
                          ),
                        ],
                      );
                    },
                  );

                  if (dialog) {
                    setState(() {
                      FirebaseFirestore.instance
                          .collection('diary')
                          .doc(widget.diary.id)
                          .delete();
                    });

                    Navigator.pop(context, true);
                  }
                },
                child: Text(
                  '삭제',
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'MaruBuriSemiBold',
                    fontSize: 12.sp,
                  ),
                ),
              ),
              // 수정
              GestureDetector(
                onTap: () async {
                  final updatedDiary = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WritingScreen(
                        selectedDate: widget.selectedDate,
                        diary: widget.diary,
                      ),
                    ),
                  );

                  if (updatedDiary != null) {
                    setState(() {
                      title = updatedDiary.title;
                      content = updatedDiary.content;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('일기가 수정되었습니다')),
                      );
                    });
                  }
                },
                child: Text(
                  '수정',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'MaruBuriSemiBold',
                    fontSize: 12.sp,
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
