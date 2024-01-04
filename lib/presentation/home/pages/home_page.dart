import 'package:flutter/material.dart';

import '../../../core/constants/font_weight.dart';
import '../../../data/models/task_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/firebase_task_service.dart';
import '../widgets/card_task.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
                child: Text(
                  user.role == "admin"
                      ? "Welcome, Admin ${user.name}"
                      : "Welcome, ${user.name}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
              ),
              StreamBuilder<List<TaskModel>>(
                stream: FirebaseTaskService().getTask(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else {
                    List<TaskModel> tasks = snapshot.data ?? [];

                    if (tasks.isEmpty) {
                      return const Center(child: Text("No tasks available"));
                    } else {
                      return ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return CardTask(
                            task: tasks[index],
                            user: user,
                          );
                        },
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
