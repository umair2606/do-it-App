import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ENTITY MODEL CLASSES/Task_Entity.dart';
import 'create_task_page.dart';

class CompleteTasks extends StatelessWidget {
  CompleteTasks({super.key});

  final String uid = FirebaseAuth.instance.currentUser?.uid ?? "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E3C6E),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .collection('Tasks')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Colors.white));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("No Tasks Found", style: TextStyle(color: Colors.white)),
              );
            }

            // Map data to TaskEntity list
            final tasks = snapshot.data!.docs.map((doc) {
              return TaskEntity.fromJson({
                ...doc.data() as Map<String, dynamic>,
                'id': doc.id,
              });
            }).toList();

            // Filter tasks
            final incomplete = tasks.where((t) => t.isComplete != true).toList();
            final complete = tasks.where((t) => t.isComplete == true).toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _profileHeader(),
                  const SizedBox(height: 30),

                  /// 📌 INCOMPLETE TASKS SECTION
                  const Text(
                    "Incomplete Tasks",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  if (incomplete.isEmpty)
                    const Text("No pending tasks", style: TextStyle(color: Colors.white70))
                  else
                    ...incomplete.map((task) => _taskTile(context, task, false)),

                  const SizedBox(height: 30),

                  /// ✅ COMPLETED TASKS SECTION
                  const Text(
                    "Completed Tasks",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  if (complete.isEmpty)
                    const Text("No completed tasks", style: TextStyle(color: Colors.white70))
                  else
                    ...complete.map((task) => _taskTile(context, task, true)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// PROFILE HEADER
  Widget _profileHeader() {
    final user = FirebaseAuth.instance.currentUser;
    return Row(
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage("assets/images/Photo.jpg"), // Ensure this exists
          backgroundColor: Colors.white12,
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user?.displayName ?? "User Name",
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                user?.email ?? "email@example.com",
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
        const Icon(Icons.notifications, color: Colors.white),
      ],
    );
  }

  /// TASK TILE
  Widget _taskTile(BuildContext context, TaskEntity task, bool isComplete) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CreateTaskPage(task: task)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white, // White cards as per your taskTile design
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              isComplete ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isComplete ? Colors.green : Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.task ?? "No Title",
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  Text(
                    "${task.date ?? ''} | ${task.time ?? ''}",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}