import 'package:flutter/material.dart';

getPriorityColor(int value) {
  switch (value) {
    case 1:
      return Colors.green;
    case 2:
      return Colors.yellow;
    case 3:
      return Colors.orange;
    case 4:
      return Colors.red;
    default:
      return Colors.green;
  }
}

getPriorityText(int value) {
  switch (value) {
    case 1:
      return "Normal";
    case 2:
      return "Medium";
    case 3:
      return "High";
    case 4:
      return "Urgent";
    default:
      return "Normal";
  }
}
