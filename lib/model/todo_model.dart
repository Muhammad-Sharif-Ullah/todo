import 'dart:convert';

import 'package:flutter/foundation.dart';

enum TaskPriority {
  normal,
  urgent,
  optional,
}



class TodoModel {
  final String uid;
  String title;
  List<String?> tasks;
  bool isCompleted;
  DateTime startTime;
  DateTime endTime;
  TaskPriority priority;
  TodoModel({
    required this.uid,
    required this.title,
    required this.tasks,
    required this.isCompleted,
    required this.startTime,
    required this.endTime,
    required this.priority,
  });

  TodoModel copyWith({
    String? uid,
    String? title,
    List<String?>? task,
    bool? isCompleted,
    DateTime? startTime,
    DateTime? endTime,
    TaskPriority? priority,
  }) {
    return TodoModel(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      tasks: task ?? this.tasks,
      isCompleted: isCompleted ?? this.isCompleted,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      priority: priority ?? this.priority,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': title,
      'task': tasks,
      'isCompleted': isCompleted,
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime.millisecondsSinceEpoch,
      'priority': priority,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      uid: map['uid'] ?? '',
      title: map['title'] ?? '',
      tasks: List<String?>.from(map['task']),
      isCompleted: map['isCompleted'] ?? false,
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime']),
      priority: map['priority'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TodoModel(uid: $uid, title: $title, task: $tasks, isCompleted: $isCompleted, startTime: $startTime, endTime: $endTime, priority: $priority)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodoModel &&
        other.uid == uid &&
        other.title == title &&
        listEquals(other.tasks, tasks) &&
        other.isCompleted == isCompleted &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.priority == priority;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        title.hashCode ^
        tasks.hashCode ^
        isCompleted.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        priority.hashCode;
  }
}
