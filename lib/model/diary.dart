class Diary {
  final String id;
  final String title;
  final String content;
  final DateTime date;

  Diary({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  // JSON으로부터 모델을 만들어내는 생성자
  Diary.fromJson({
    required Map<String, dynamic> json,
  })  : id = json['id'],
        title = json['title'],
        content = json['content'],
        date = DateTime.parse(json['date']);

  // 모델을 다시 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date':
          '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}',
    };
  }

  // 현재 모델을 특정 속성만 변환해서 새로 생성
  Diary copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? date,
  }) {
    return Diary(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
    );
  }
}
