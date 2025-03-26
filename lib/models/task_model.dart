class Task {
  int? id;
  String? title;
  String? description;
  String? dueDate;
  String? priority;
  String? status;

  Task({
    this.id,
    this.title,
    this.description,
    this.dueDate,
    this.priority,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'priority': priority,
      'status': status,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: map['dueDate'],
      priority: map['priority'],
      status: map['status'],
    );
  }
}
