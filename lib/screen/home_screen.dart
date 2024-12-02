import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:end_of_a_day/component/diary_card.dart';
import 'package:end_of_a_day/component/main_calendar.dart';
import 'package:end_of_a_day/component/phrases.dart';
import 'package:end_of_a_day/const/colors.dart';
import 'package:end_of_a_day/model/diary.dart';
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
                          builder: (_) => WritingScreen(
                            selectedDate: selectedDate,
                          ),
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
                onDaySelected: (selectedDate, focusedDate) =>
                    onDaySelected(selectedDate, focusedDate, context),
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
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection(
                            'diary',
                          )
                          .where(
                            'date',
                            isEqualTo:
                                '${selectedDate.year}${selectedDate.month.toString().padLeft(2, "0")}${selectedDate.day.toString().padLeft(2, "0")}',
                          )
                          .snapshots(),
                      builder: (context, snapshot) {
                        // Stream을 가져오는 동안 에러가 났을 때
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('정보를 가져오지 못했습니다.'),
                          );
                        }

                        // 로딩 중일 때
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container();
                        }

                        // Diary Model로 데이터 매핑
                        final diarys = snapshot.data!.docs
                            .map(
                              (QueryDocumentSnapshot e) => Diary.fromJson(
                                  json: (e.data() as Map<String, dynamic>)),
                            )
                            .toList();

                        return ListView.builder(
                          itemCount: diarys.length,
                          itemBuilder: (context, index) {
                            final diary = diarys[index];

                            return Dismissible(
                              key: ObjectKey(diary.id),
                              direction: DismissDirection.endToStart,
                              onDismissed: (DismissDirection direction) {
                                FirebaseFirestore.instance
                                    .collection('diary')
                                    .doc(diary.id)
                                    .delete();
                              },
                              child: Phrases(
                                title: diary.title,
                                writedDate: diary.date.toString(),
                              ),
                            );
                          },
                        );
                      },
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

  void onDaySelected(
    DateTime selectedDate,
    DateTime focusedDate,
    BuildContext context,
  ) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}
