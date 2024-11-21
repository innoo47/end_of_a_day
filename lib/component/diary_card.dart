import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class DiaryCard extends StatelessWidget {
  const DiaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.centerLeft,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    '오늘 하루 이 시간은 당신의 것이다. 하루를 착한 행위로 장식하라. - 루즈벨트',
                    textStyle: const TextStyle(
                      fontSize: 13,
                      fontFamily: 'MaruBuriSemiBold',
                    ),
                    speed: const Duration(milliseconds: 80),
                  ),
                ],
                pause: const Duration(milliseconds: 1000),
                isRepeatingAnimation: true,
                repeatForever: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
