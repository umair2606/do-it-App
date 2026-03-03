import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it_app/create_task_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../ENTITY MODEL CLASSES/Task_Entity.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // We keep this dynamic to react to auth changes
  User? get user => FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1253AA), Color(0xFF05243E)],
            ),
          ),
        ),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage("assets/images/Photo.jpg"),
              backgroundColor: Colors.white12,
              radius: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    user?.displayName ?? 'User Name',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: "Poppins",
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    user?.email ?? 'user@gmail.com',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      fontFamily: "Poppins",
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            _buildNotificationIcon("2"),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1253AA), Color(0xFF05243E)],
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          // 2. Use user?.uid with a fallback to avoid the crash
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(user?.uid ?? 'unknown')
              .collection('Tasks')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Colors.white));
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No tasks found", style: TextStyle(color: Colors.white)));
            }

            // Convert docs to TaskEntity list
            List<TaskEntity> allTasks = snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              data['documentId'] = doc.id; // Match your Entity field name
              return TaskEntity.fromJson(data);
            }).toList();

            List<TaskEntity> incompleteTasks = allTasks.where((t) => t.isComplete == false).toList();
            List<TaskEntity> completeTasks = allTasks.where((t) => t.isComplete == true).toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('Incomplete Tasks'),
                  const SizedBox(height: 12),
                  _buildTaskList(incompleteTasks, "No pending tasks!"),

                  const SizedBox(height: 30),

                  _buildSectionHeader('Complete Tasks'),
                  const SizedBox(height: 12),
                  _buildTaskList(completeTasks, "No completed tasks yet."),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildTaskList(List<TaskEntity> tasks, String emptyMsg) {
    if (tasks.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(emptyMsg, style: const TextStyle(color: Colors.white54, fontSize: 14)),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) => _buildTaskCard(context, tasks[index]),
    );
  }

  Widget _buildTaskCard(BuildContext context, TaskEntity taskItem) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateTaskPage(task: taskItem)),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF1E4E87).withOpacity(0.4),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              taskItem.task ?? 'Untitled Task',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.white54, size: 12),
                const SizedBox(width: 5),
                Text(
                  "${taskItem.date} | ${taskItem.time}",
                  style: const TextStyle(color: Colors.white60, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationIcon(String count) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(Icons.notifications, size: 28, color: Colors.white),
        Positioned(
          right: -2,
          top: -2,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            child: Text(count, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}