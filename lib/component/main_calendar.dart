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
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
