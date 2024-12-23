import 'package:end_of_a_day/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class MainCalendar extends StatefulWidget {
  final OnDaySelected onDaySelected;
  final DateTime selectedDate;
  final DateTime focusedDate;

  const MainCalendar({
    super.key,
    required this.selectedDate,
    required this.onDaySelected,
    required this.focusedDate,
  });

  @override
  State<MainCalendar> createState() => _MainCalendarState();
}

class _MainCalendarState extends State<MainCalendar> {
  DateTime? selectedDay;
  DateTime? focusedDay;

  @override
  void initState() {
    super.initState();
    selectedDay = widget.selectedDate;
    focusedDay = widget.focusedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: COMPONENT_DARK_COLOR,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 5,
        ),
        child: TableCalendar(
          locale: "ko_kr",
          onDaySelected: widget.onDaySelected,
          selectedDayPredicate: (DateTime date) {
            return isSameDay(widget.selectedDate, date);
          },
          focusedDay: widget.focusedDate,
          firstDay: DateTime(1800, 1, 1),
          lastDay: DateTime(3000, 1, 1),
          rowHeight: 33.h,
          daysOfWeekHeight: 15.h,
          // 헤더 스타일
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
              fontFamily: 'MaruBuriSemiBold',
            ),
          ),
          // 헤더 길게 눌렀을 때 => 오늘 날짜로 이동
          onHeaderLongPressed: (_) {
            setState(() {
              focusedDay = DateTime.now();
              selectedDay = DateTime.now();
              widget.onDaySelected(DateTime.now(), DateTime.now());
            });
          },
          // 요일 스타일
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'MaruBuriSemiBold',
              fontSize: 12.sp,
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
              color: Colors.white,
              fontFamily: 'MaruBuriRegular',
              fontSize: 11.sp,
            ),
            todayTextStyle: TextStyle(
              fontFamily: 'MaruBuriRegular',
              fontSize: 11.sp,
              color: Colors.black,
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
              color: DARK_GREY_COLOR,
            ),
            withinRangeTextStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'MaruBuriRegular',
              fontSize: 11.sp,
            ),
            rangeStartTextStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'MaruBuriRegular',
              fontSize: 11.sp,
            ),
          ),
        ),
      ),
    );
  }
}
