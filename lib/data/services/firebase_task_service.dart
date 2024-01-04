import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_hub/data/models/task_model.dart';

class FirebaseTaskService {
  final CollectionReference _taskReference =
      FirebaseFirestore.instance.collection("tasks");

  String currentTimeString = Timestamp.now().toDate().toString();

  Future<void> createTask({
    required String title,
    required String description,
  }) async {
    try {
      await _taskReference.add({
        "title": title,
        "description": description,
        "createdAt": currentTimeString,
        "updatedAt": currentTimeString,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<TaskModel> getTaskById(String id) async {
    try {
      DocumentSnapshot taskSnapshot = await _taskReference.doc(id).get();

      if (taskSnapshot.exists) {
        Map<String, dynamic> taskData =
            taskSnapshot.data() as Map<String, dynamic>;

        return TaskModel.fromJson(id, taskData);
      } else {
        throw Exception("Task with ID $id does not exist");
      }
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<TaskModel>> getTask() {
    try {
      return _taskReference
          .orderBy("createdAt", descending: true)
          .snapshots()
          .map((querySnapshot) {
        return querySnapshot.docs
            .map((e) =>
                TaskModel.fromJson(e.id, e.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTask({
    required String id,
    required String title,
    required String description,
  }) async {
    try {
      await _taskReference.doc(id).update({
        "title": title,
        "description": description,
        "updatedAt": currentTimeString,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _taskReference.doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }
}
