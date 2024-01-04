import 'package:flutter/material.dart';

import '../../../core/components/dialog_widget.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/task_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/firebase_task_service.dart';

class CardTask extends StatelessWidget {
  const CardTask({super.key, required this.task, required this.user});

  final TaskModel task;
  final UserModel user;

  void delete(String id) async {
    await FirebaseTaskService().deleteTask(id);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20, left: 22, right: 22),
      elevation: 5,
      child: ListTile(
        title: Text(
          task.title,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            // Text("Created ${task.createdAt}"),
            // Visibility(
            //   visible: task.updatedAt != task.createdAt,
            //   child: Text("Updated ${task.updatedAt}"),
            // ),
          ],
        ),
        trailing: Wrap(
          spacing: -2,
          children: [
            IconButton(
              onPressed: () {
                DialogWidget().showDialogWidget(context, task.id);
              },
              icon: const Icon(
                Icons.edit,
                size: 28,
                color: AppColors.kGreenColor,
              ),
            ),
            IconButton(
              onPressed: () {
                user.role == "admin"
                    ? delete(task.id)
                    : ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColors.kRedColor,
                          content: Text(
                              "${user.name}, Hubungi admin\njika ingin menghapus task: ${task.title}"),
                        ),
                      );
              },
              icon: const Icon(
                Icons.delete,
                size: 28,
                color: AppColors.kRedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
