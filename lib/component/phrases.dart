import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Phrases extends StatelessWidget {
  final String title;
  final String writedDate;

  const Phrases({super.key, required this.title, required this.writedDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      width: MediaQuery.of(context).size.width,
      height: 45.h,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Title(title: title),
            _Date(writedDate: writedDate),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;

  const _Title({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 12.sp,
        fontFamily: 'MaruBuriSemiBold',
      ),
    );
  }
}

class _Date extends StatelessWidget {
  final String writedDate;

  const _Date({super.key, required this.writedDate});

  @override
  Widget build(BuildContext context) {
    return Text(
      writedDate,
      style: TextStyle(
        fontSize: 10.sp,
        fontFamily: 'MaruBuriLight',
        fontWeight: FontWeight.w100,
      ),
    );
  }
}
