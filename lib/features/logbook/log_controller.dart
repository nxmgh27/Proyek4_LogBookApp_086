import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/log_model.dart';

class LogController {
  final ValueNotifier<List<LogModel>> logsNotifier =
      ValueNotifier<List<LogModel>>([]);

  static const String storageKey = 'log_data';

  LogController() {
    loadLogs();
  }

  Future<void> loadLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(storageKey);

    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);

      logsNotifier.value =
          decoded.map((item) => LogModel.fromJson(item)).toList();
    }
  }

  Future<void> saveLogs() async {
    final prefs = await SharedPreferences.getInstance();

    final List<Map<String, dynamic>> jsonList =
        logsNotifier.value.map((log) => log.toJson()).toList();

    final jsonString = jsonEncode(jsonList);

    await prefs.setString(storageKey, jsonString);
  }


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
    saveLogs();
  }

  void updateLog(int index, String title, String description) {
    final updatedList = List<LogModel>.from(logsNotifier.value);

    updatedList[index] = LogModel(
      title: title,
      description: description,
      timestamp: DateTime.now(),
    );

    logsNotifier.value = updatedList;
    saveLogs();
  }

  void removeLog(int index) {
    final updatedList = List<LogModel>.from(logsNotifier.value);
    updatedList.removeAt(index);

    logsNotifier.value = updatedList;
    saveLogs();
  }
}