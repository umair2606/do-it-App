import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it_app/ENTITY%20MODEL%20CLASSES/Task_Entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:do_it_app/UI/home.dart';
import 'package:do_it_app/UI/my_calender.dart';
import 'package:do_it_app/UI/my_setting.dart';
import 'package:do_it_app/UI/tasks_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndexValue = 0;

  final TextEditingController taskController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  final List<Widget> screenList = [
    const Home(),
    const TasksPage(),
    const MyCalender(),
    const MySetting(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF05243E),
      body: screenList[currentIndexValue],
      // 2. FIX: Properly structured BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndexValue,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF5243EE),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        onTap: (index) {
          setState(() {
            currentIndexValue = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
      floatingActionButton: currentIndexValue == 1
          ? FloatingActionButton(
        backgroundColor: const Color(0xFF03A9F4),
        onPressed: _showAddTaskSheet,
        child: const Icon(Icons.add, color: Colors.white),
      )
          : null,
    );
  }

  void _showAddTaskSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0A1D2E), // Exact background color
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 30,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Add New Task",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 25),
                _buildTextField(
                  controller: taskController,
                  label: "task",
                  icon: Icons.check_box_outlined,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: descriptionController,
                  label: "Description",
                  icon: Icons.notes,
                  maxLines: 4,
                ),
                const SizedBox(height: 15),
                // 3. UI MATCH: Side-by-side Date and Time
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: dateController,
                        label: "Date",
                        icon: Icons.calendar_today,
                        readOnly: true,
                        onTap: _selectDate,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _buildTextField(
                        controller: timeController,
                        label: "Time",
                        icon: Icons.access_time,
                        readOnly: true,
                        onTap: _selectTime,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // 4. UI MATCH: Outlined Cancel and Filled Create buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF03A9F4)),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("cancel", style: TextStyle(color: Color(0xFF03A9F4), fontSize: 16)),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _createTask,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF03A9F4),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        child: const Text("create", style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 5. UI MATCH: Deep navy input fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool readOnly = false,
    VoidCallback? onTap,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF051E36),
        prefixIcon: Icon(icon, color: Colors.white70, size: 20),
        hintText: label,
        hintStyle: const TextStyle(color: Colors.white54, fontSize: 15),
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Future<void> _createTask() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    if (taskController.text.isEmpty) return;

    try {
      final documentId = FirebaseFirestore.instance.collection('users').doc().id;
      final task = TaskEntity(
        task: taskController.text.trim(),
        description: descriptionController.text.trim(),
        date: dateController.text.trim(),
        time: timeController.text.trim(),
        isComplete: false,
        documentId: documentId,
        isPinned: false,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('Tasks')
          .doc(documentId)
          .set(task.toJson());

      Navigator.pop(context);
      _clearForm();
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void _clearForm() {
    taskController.clear();
    descriptionController.clear();
    dateController.clear();
    timeController.clear();
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (pickedDate != null) {
      setState(() => dateController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}");
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedTime != null) {
      setState(() => timeController.text = pickedTime.format(context));
    }
  }

  @override
  void dispose() {
    taskController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }
}