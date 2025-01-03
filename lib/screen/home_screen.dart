import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:end_of_a_day/component/diary_card.dart';
import 'package:end_of_a_day/component/main_calendar.dart';
import 'package:end_of_a_day/component/phrases.dart';
import 'package:end_of_a_day/const/colors.dart';
import 'package:end_of_a_day/model/diary.dart';
import 'package:end_of_a_day/screen/detail_screen.dart';
import 'package:end_of_a_day/screen/writing_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  DateTime focusedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_DARK_COLOR,
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
                      // Title
                      '하루의 끝',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontFamily: 'MaruBuriBold',
                      ),
                    ),
                    IconButton(
                      // 일기 작성 버튼
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WritingScreen(
                            selectedDate: DateTime.now(),
                          ),
                        ),
                      ),
                      icon: const Icon(
                        Icons.edit_note_rounded,
                        color: Colors.white,
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
                        color: Colors.white,
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
                focusedDate: focusedDate,
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
                    color: COMPONENT_DARK_COLOR,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: StreamBuilder<QuerySnapshot>(
                      // 날짜와 author가 모두 같아야 리스트 출력
                      stream: FirebaseFirestore.instance
                          .collection(
                            'diary',
                          )
                          .where(
                            'date',
                            isEqualTo:
                                '${selectedDate.year}${selectedDate.month.toString().padLeft(2, "0")}${selectedDate.day.toString().padLeft(2, "0")}',
                          )
                          .where('author',
                              isEqualTo:
                                  FirebaseAuth.instance.currentUser!.email)
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
                          return Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          );
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
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                              confirmDismiss: (direction) async {
                                return await showCupertinoDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      title: Text('일기 삭제'),
                                      content: Text('정말로 삭제하시겠습니까?'),
                                      actions: [
                                        CupertinoDialogAction(
                                          isDefaultAction: true,
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: Text('취소'),
                                        ),
                                        CupertinoDialogAction(
                                          isDestructiveAction: true,
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: Text('삭제'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              onDismissed: (DismissDirection direction) {
                                setState(() {
                                  FirebaseFirestore.instance
                                      .collection('diary')
                                      .doc(diary.id)
                                      .delete();
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('일기가 삭제되었습니다')),
                                );
                              },
                              child: GestureDetector(
                                onTap: () async {
                                  final deleteSnack = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => DetailScreen(
                                        selectedDate: selectedDate,
                                        diary: diary,
                                      ),
                                    ),
                                  );

                                  if (deleteSnack) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('일기가 삭제되었습니다')),
                                    );
                                  }
                                },
                                child: Phrases(
                                  // 일기
                                  title: diary.title,
                                  // writedDate: diary.date.toString(),
                                  // 필요한 정보만 제공 (년, 월, 일)
                                  writedDate:
                                      '${diary.date.year}-${diary.date.month.toString().padLeft(2, '0')}-${diary.date.day.toString().padLeft(2, '0')}',
                                ),
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

  /* 날짜 선택 시 */
  void onDaySelected(
    DateTime selectedDate,
    DateTime focusedDate,
    BuildContext context,
  ) {
    setState(() {
      this.selectedDate = selectedDate;
      this.focusedDate = focusedDate;
    });
  }
}
