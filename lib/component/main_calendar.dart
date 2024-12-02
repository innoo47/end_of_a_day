import 'package:end_of_a_day/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      child: TableCalendar(
        locale: "ko_kr",
        onDaySelected: onDaySelected,
        selectedDayPredicate: (date) {
          return isSameDay(selectedDate, date);
        },
        focusedDay: DateTime.now(),
        firstDay: DateTime(1800, 1, 1),
        lastDay: DateTime(3000, 1, 1),
        rowHeight: 33.h,
        daysOfWeekHeight: 16.h,
        // 헤더 스타일
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13.sp,
            fontFamily: 'MaruBuriSemiBold',
          ),
        ),
        // 요일 스타일
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            fontFamily: 'MaruBuriSemiBold',
            fontSize: 11.sp,
          ),
          weekendStyle: TextStyle(
            fontFamily: 'MaruBuriSemiBold',
            fontSize: 11.sp,
            color: Colors.red,
          ),
        ),
        // 달력 스타일
        calendarStyle: CalendarStyle(
          defaultTextStyle: TextStyle(
            fontFamily: 'MaruBuriRegular',
            fontSize: 11.sp,
          ),
          todayTextStyle: TextStyle(
            fontFamily: 'MaruBuriRegular',
            fontSize: 11.sp,
            color: Colors.white,
          ),
          weekendTextStyle: TextStyle(
            fontFamily: 'MaruBuriRegular',
            fontSize: 11.sp,
            color: Colors.red,
          ),
          selectedTextStyle: TextStyle(
            fontFamily: 'MaruBuriRegular',
            fontSize: 11.sp,
            color: Colors.white,
          ),
          outsideTextStyle: TextStyle(
            fontFamily: 'MaruBuriRegular',
            fontSize: 11.sp,
            color: TEXT_FIELD_FILL_COLOR,
          ),
          withinRangeTextStyle: TextStyle(
            fontFamily: 'MaruBuriRegular',
            fontSize: 11.sp,
          ),
          rangeStartTextStyle: TextStyle(
            fontFamily: 'MaruBuriRegular',
            fontSize: 11.sp,
          ),
        ),
      ),
    );
  }
}
