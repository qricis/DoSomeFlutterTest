class Memo {
  late int id;
  late String title;
  late String content;
  late DateTime createTime;
  late DateTime modifiedTime;

  Memo({
    required this.id,
    required this.title,
    required this.content,
    required this.createTime,
    required this.modifiedTime
  });

  Map<String, dynamic> toMap() {
    // 因为SQLite的时间戳只能存储整数(自1970-01-01以来的秒数) 因此需要整除1000
    var createTimestamp = createTime.millisecondsSinceEpoch ~/ 1000;
    var modifiedTimestamp = modifiedTime.millisecondsSinceEpoch ~/ 1000;

    return {
      'id': id,
      'title': title,
      'content': content,
      'created_time': createTimestamp,
      'modified_time': modifiedTimestamp
    };
  }

  factory Memo.fromMap(Map<String,dynamic> map) {
    var createTimestamp = map['created_time'] as int;
    var modifiedTimestamp = map['modified_time'] as int;

    // 返回的时间戳是毫秒数
    return Memo(
      id: map['id'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
      createTime: DateTime.fromMillisecondsSinceEpoch(createTimestamp * 1000),
      modifiedTime: DateTime.fromMillisecondsSinceEpoch(modifiedTimestamp * 1000)
    );
  }
}