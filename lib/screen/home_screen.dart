import 'package:end_of_a_day/component/diary_card.dart';
import 'package:end_of_a_day/component/main_calendar.dart';
import 'package:end_of_a_day/component/phrases.dart';
import 'package:end_of_a_day/const/colors.dart';
import 'package:end_of_a_day/screen/writing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
          child: Column(
            children: [
              /* 타이틀 */
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '하루의 끝',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontFamily: 'MaruBuriBold',
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const WritingScreen(),
                        ),
                      ),
                      icon: const Icon(
                        Icons.edit_note_rounded,
                      ),
                    ),
                  ],
                ),
              ),
              /* 소개글 */
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '하루를 마무리하며 간단한 일기를 작성해 보세요.',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w100,
                        fontFamily: 'MaruBuriLight',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              /* 달력 */
              MainCalendar(
                selectedDate: selectedDate,
                onDaySelected: onDaySelected,
              ),
              SizedBox(
                height: 10.h,
              ),
              /* 글귀 카드 */
              const DiaryCard(),
              SizedBox(
                height: 10.h,
              ),
              /* 일기 리스트 */
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Phrases(
                          title: '제목',
                          writedDate: '2024.11.18 오후 3:40',
                        ),
                        Phrases(
                          title: '제목',
                          writedDate: '2024.11.18 오후 3:40',
                        ),
                        Phrases(
                          title: '제목',
                          writedDate: '2024.11.18 오후 3:40',
                        ),
                      ],
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

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}
