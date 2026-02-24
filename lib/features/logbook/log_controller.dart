import 'package:flutter/material.dart';
import 'models/log_model.dart';

class LogController {
  // Reactive list
  final ValueNotifier<List<LogModel>> logsNotifier =
      ValueNotifier<List<LogModel>>([]);

  // Tambah
  void addLog(String title, String description) {
    final updatedList = List<LogModel>.from(logsNotifier.value);

    updatedList.add(
      LogModel(
        title: title,
        description: description,
        timestamp: DateTime.now(),
      ),
    );

    logsNotifier.value = updatedList;
  }

  // Edit
  void updateLog(int index, String title, String description) {
    final updatedList = List<LogModel>.from(logsNotifier.value);

    updatedList[index] = LogModel(
      title: title,
      description: description,
      timestamp: DateTime.now(),
    );

    logsNotifier.value = updatedList;
  }

  // Delete
  void removeLog(int index) {
    final updatedList = List<LogModel>.from(logsNotifier.value);
    updatedList.removeAt(index);

    logsNotifier.value = updatedList;
  }
}