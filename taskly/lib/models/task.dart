class Task {
  String content;
  DateTime timeStamp;
  bool done;

  Task({required this.content, required this.timeStamp, required this.done});
  factory Task.fromMap(Map task) {
    try {
      return Task(
        content: task["content"] ?? "No Content",
        timeStamp:
            task["timeStamp"] is DateTime
                ? task["timeStamp"]
                : DateTime.tryParse(task["timeStamp"] ?? "") ?? DateTime.now(),
        done: task["done"] ?? false,
      );
    } catch (e) {
      return Task(content: "Invalid", timeStamp: DateTime.now(), done: false);
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "content": content,
      "timeStamp": timeStamp.toIso8601String(),
      "done": done,
    };
  }
}
