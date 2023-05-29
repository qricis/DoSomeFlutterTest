import 'package:flutter/material.dart';

class Memo {
  late int id;
  late String title;
  late String content;
  late DateTime createdTime;
  late DateTime modifiedTime;

  Memo({
    required this.id,
    required this.title,
    required this.content,
    required this.createdTime,
    required this.modifiedTime,
  });

  Map<String, dynamic> toMap() {
    var createdTimestamp = createdTime.millisecondsSinceEpoch ~/ 1000;
    var modifiedTimestamp = modifiedTime.millisecondsSinceEpoch ~/ 1000;
    return {
      'id': id,
      'title': title,
      'content': content,
      'created_time': createdTimestamp,
      'modified_time': modifiedTimestamp
    };
  }

  factory Memo.fromMap(Map<String, dynamic> map) {
    var createdTimestamp = map['created_time'] as int;
    var modifiedTimestamp = map['modified_time'] as int;
    return Memo(
      id: map['id'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
      createdTime: DateTime.fromMillisecondsSinceEpoch(createdTimestamp * 1000),
      modifiedTime:
          DateTime.fromMillisecondsSinceEpoch(modifiedTimestamp * 1000),
    );
  }
}
