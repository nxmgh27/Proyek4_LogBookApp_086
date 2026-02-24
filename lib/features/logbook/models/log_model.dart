class LogModel {
  String title;
  String description;
  DateTime timestamp;

  LogModel({
    required this.title,
    required this.description,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory LogModel.fromJson(Map<String, dynamic> json) {
    return LogModel(
      title: json['title'],
      description: json['description'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
