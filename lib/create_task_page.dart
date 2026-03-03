// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:do_it_app/UI/home.dart';
// import 'package:do_it_app/complete_tasks.dart';
// import 'package:flutter/material.dart';
//
// import 'ENTITY MODEL CLASSES/Task_Entity.dart';
//
// class CreateTaskPage extends StatefulWidget {
//   CreateTaskPage({super.key, required this.task});
//
//   TaskEntity? task;
//
//   @override
//   State<CreateTaskPage> createState() => _Task_DetailState();
// }
//
// class _Task_DetailState extends State<CreateTaskPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color(0xFF1253AA), Color(0xFF05243E)],
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 60),
//
//               Padding(
//                 padding: const EdgeInsets.only(left: 50),
//                 child: Text(
//                   "Task Details",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 22,
//                     fontWeight: FontWeight.w500,
//                     letterSpacing: 2,
//                     fontFamily: "Poppins",
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 80),
//
//               Padding(
//                 padding: const EdgeInsets.only(left: 50),
//                 child: Text(
//                   widget.task!.task.toString(),
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500,
//                     letterSpacing: 2,
//                     fontFamily: "Poppins",
//                   ),
//                 ),
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.only(left: 30),
//                 child: Icon(
//                   Icons.calendar_month,
//                   color: Colors.white,
//                   size: 12,
//                 ),
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.only(left: 50),
//                 child: Text(
//                   "${widget.task!.date} | ${widget.task!.time}",
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.white,
//                     fontFamily: "Poppins",
//                     fontWeight: FontWeight.w300,
//                     letterSpacing: 2,
//                   ),
//                 ),
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.only(top: 267, left: 37),
//                 child: Text(
//                   widget.task!.description.toString(),
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.white,
//                     fontFamily: "Poppins",
//                     fontWeight: FontWeight.w300,
//                     letterSpacing: 2,
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 50),
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                     ),
//                     onPressed: () async {
//                       try {
//                         await FirebaseFirestore.instance
//                             .collection("Tasks")
//                             .doc(widget.task!.documentId)
//                             .update({"isComplete": true});
//                       } catch (e) {}
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Home()),
//                       );
//                     },
//                     child: const Text("Done"),
//                   ),
//                   const SizedBox(width: 10),
//
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                     ),
//                     onPressed: () async {
//                       try {
//                         await FirebaseFirestore.instance
//                             .collection("Tasks")
//                             .doc(widget.task!.documentId)
//                             .delete();
//                       } catch (e) {}
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => CompleteTasks()),
//                       );
//                     },
//                     child: const Text("Delete"),
//                   ),
//                   const SizedBox(width: 10),
//
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.yellow,
//                     ),
//                     onPressed: () async {
//                       try {
//                         await FirebaseFirestore.instance
//                             .collection("Tasks")
//                             .doc(widget.task!.documentId)
//                             .update({"isPinned": true});
//                       } catch (e) {}
//                     },
//                     child: const Text("Pin"),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ENTITY MODEL CLASSES/Task_Entity.dart';

class CreateTaskPage extends StatefulWidget {
  final TaskEntity? task;

  const CreateTaskPage({super.key, this.task});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  bool isComplete = false;

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      taskController.text = widget.task!.task ?? '';
      dateController.text = widget.task!.date ?? '';
      timeController.text = widget.task!.time ?? '';
      isComplete = widget.task!.isComplete!;
    }
  }

  Future<void> saveTask() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    if (widget.task == null) {
      // ADD
      await FirebaseFirestore.instance.collection('Tasks').add({
        'task': taskController.text,
        'date': dateController.text,
        'time': timeController.text,
        'isComplete': false,
        'userId': userId,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } else {
      // UPDATE
      await FirebaseFirestore.instance
          .collection('Tasks')
          .doc(widget.task!.id)
          .update({
        'task': taskController.text,
        'date': dateController.text,
        'time': timeController.text,
        'isComplete': isComplete,
      });
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? "Create Task" : "Edit Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: const InputDecoration(labelText: "Task"),
            ),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(labelText: "Date"),
            ),
            TextField(
              controller: timeController,
              decoration: const InputDecoration(labelText: "Time"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveTask,
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}