import 'package:end_of_a_day/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MainCalendar extends StatelessWidget {
  final OnDaySelected onDaySelected;
  final DateTime selectedDate;

  const MainCalendar({
    super.key,
    required this.selectedDate,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TableCalendar(
          locale: "ko_kr",
          onDaySelected: onDaySelected,
          selectedDayPredicate: (date) =>
              date.year == selectedDate.year &&
              date.month == selectedDate.month &&
              date.day == selectedDate.day,
          focusedDay: DateTime.now(),
          firstDay: DateTime(1800, 1, 1),
          lastDay: DateTime(3000, 1, 1),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              fontFamily: 'MaruBuriRegular',
            ),
          ),
          calendarStyle: CalendarStyle(
            defaultTextStyle: const TextStyle(
              fontFamily: 'MaruBuriRegular',
            ),
            todayTextStyle: const TextStyle(
              fontFamily: 'MaruBuriRegular',
              color: Colors.white,
            ),
            weekendTextStyle: const TextStyle(
              fontFamily: 'MaruBuriRegular',
              color: Colors.red,
            ),
            selectedTextStyle: const TextStyle(
              fontFamily: 'MaruBuriRegular',
              color: Colors.white,
            ),
            outsideTextStyle: TextStyle(
              fontFamily: 'MaruBuriRegular',
              color: TEXT_FIELD_FILL_COLOR,
            ),
          ),
        ),
      ),
    );
  }
}
