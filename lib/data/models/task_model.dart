import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String createdAt;
  final String updatedAt;

  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, title, description, createdAt, updatedAt];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    Timestamp createdAtTimestamp = map['createdAt'] as Timestamp;
    Timestamp updatedAtTimestamp = map['updatedAt'] as Timestamp;
    return TaskModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      createdAt: createdAtTimestamp.toDate().toString(),
      updatedAt: updatedAtTimestamp.toDate().toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String id, Map<String, dynamic> json) => TaskModel(
        id: id,
        title: json["title"] as String? ?? "",
        description: json["description"] as String? ?? "",
        createdAt: json["createdAt"] as String? ?? "",
        updatedAt: json["updatedAt"] as String? ?? "",
      );
}
