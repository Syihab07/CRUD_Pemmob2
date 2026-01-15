import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final bool completed;
  final String priority;
  final DateTime createdAt;
  final DateTime? dueDate;

  Task({
    required this.id,
    required this.title,
    this.description = '',
    this.completed = false,
    this.priority = 'medium',
    required this.createdAt,
    this.dueDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'completed': completed,
      'priority': priority,
      'createdAt': Timestamp.fromDate(createdAt),
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
    };
  }

  factory Task.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Task(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      completed: data['completed'] ?? false,
      priority: data['priority'] ?? 'medium',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      dueDate: data['dueDate'] != null
          ? (data['dueDate'] as Timestamp).toDate()
          : null,
    );
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    bool? completed,
    String? priority,
    DateTime? createdAt,
    DateTime? dueDate,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}
