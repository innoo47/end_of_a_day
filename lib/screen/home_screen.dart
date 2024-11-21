import 'package:end_of_a_day/component/diary_card.dart';
import 'package:end_of_a_day/component/main_calendar.dart';
import 'package:end_of_a_day/component/phrases.dart';
import 'package:end_of_a_day/const/colors.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        backgroundColor: BACKGROUND_COLOR,
        centerTitle: true,
        title: Text(
          '하루의 끝',
          style: TextStyle(
            fontSize: 26,
            fontFamily: 'MaruBuriBold',
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () => {},
              icon: const Icon(
                Icons.add,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
              child: Text(
                '하루를 마무리하며 간단한 일기를 작성해보세요.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w100,
                  fontFamily: 'MaruBuriLight',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
              child: MainCalendar(
                selectedDate: selectedDate,
                onDaySelected: onDaySelected,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
              child: DiaryCard(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Phrases(
                    title: '제목',
                    writedDate: '2024.11.18 오후 3:40',
                  ),
                ),
              ),
            ),
          ],
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
