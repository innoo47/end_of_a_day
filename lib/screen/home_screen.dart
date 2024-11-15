import 'package:end_of_a_day/component/main_calendar.dart';
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
        title: const Text(
          '하루의 끝',
          style: TextStyle(
            fontSize: 28,
            fontFamily: 'MaruBuriBold',
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 18),
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
