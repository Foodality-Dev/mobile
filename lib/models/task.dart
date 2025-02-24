import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  TaskModel({
    this.id,
    required this.goalId,
    required this.userId,
    required this.title,
    required this.createdAt,
    required this.completed,
  });

  String? id;
  String goalId;
  String? userId;
  String title;
  Timestamp createdAt;
  bool completed;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
      id: json["id"],
      goalId: json["goalId"],
      userId: json["userId"],
      title: json["title"],
      createdAt: Timestamp.fromDate(DateTime.parse(json["createdAt"])),
      completed: json["completed"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "goalId": goalId,
    "userId": userId,
    "title": title,
    "createdAt": createdAt.toDate().toString(),
    "completed": completed,
  };

  factory TaskModel.fromFirebase(Map<String, dynamic> json) => TaskModel(
    id: json["id"],
    goalId: json["goalId"],
    userId: json["userId"],
    title: json["title"],
    createdAt: json["createdAt"],
    completed: json["completed"],
  );

  Map<String, dynamic> toFirebase() => {
    "goalId": goalId,
    "userId": userId,
    "title": title,
    "createdAt": createdAt,
    "completed": completed,
  };
}