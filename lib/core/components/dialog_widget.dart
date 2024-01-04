import 'package:flutter/material.dart';

import '../../data/services/firebase_task_service.dart';

class DialogWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  void createTask() async {
    await FirebaseTaskService().createTask(
        title: titleController.text, description: descController.text);
  }

  void updateTask(String id) async {
    await FirebaseTaskService().updateTask(
        id: id, title: titleController.text, description: descController.text);
  }

  Future<void> showDialogWidget(BuildContext context, String? id) async {
    String titleDialog = "Create Task";
    String buttonTextDialog = "Create";

    if (id != null) {
      titleDialog = "Update Task";
      buttonTextDialog = "Update";

      final updateTask = await FirebaseTaskService().getTaskById(id);

      titleController.text = updateTask.title;
      descController.text = updateTask.description;
    }

    Future.microtask(() {
      return showDialog(
        barrierDismissible: false,
        context: context,
        useSafeArea: true,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 5,
            title: Text(titleDialog),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: "Title",
                  ),
                ),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(
                    hintText: "Description",
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  titleController.clear();
                  descController.clear();
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  id != null ? updateTask(id) : createTask();

                  titleController.clear();
                  descController.clear();
                  Navigator.pop(context);
                },
                child: Text(buttonTextDialog),
              ),
            ],
          );
        },
      );
    });
  }
}
