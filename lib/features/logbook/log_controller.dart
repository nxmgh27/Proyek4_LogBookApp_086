import 'models/log_model.dart';

class LogController {
  final List<LogModel> logs = [];

  // Tambah
  void addLog(String title, String description) {
    logs.add(
      LogModel(
        title: title,
        description: description,
        timestamp: DateTime.now(),
      ),
    );
  }

  // Edit
  void updateLog(int index, String title, String description) {
    logs[index] = LogModel(
      title: title,
      description: description,
      timestamp: DateTime.now(),
    );
  }

  // Delete
  void removeLog(int index) {
    logs.removeAt(index);
  }
}