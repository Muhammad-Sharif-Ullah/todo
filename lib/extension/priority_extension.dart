import 'package:flutter/material.dart';
import 'package:todo/model/todo_model.dart';

extension PriorityColor on TaskPriority {
  static const Map<TaskPriority, Color> pColor = {
    TaskPriority.normal: Colors.greenAccent,
    TaskPriority.urgent: Colors.pinkAccent,
    TaskPriority.optional: Colors.yellowAccent,
  };
}
