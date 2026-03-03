import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it_app/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<QuerySnapshot> responce;

  @override
  void initState() {
    super.initState();
    responce = FirebaseFirestore.instance.collection('student').get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1253AA), Color(0xFF05243E)],
          ),
        ),
        child: FutureBuilder<QuerySnapshot>(
          future: responce,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong"));
            }

            final docs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                Tasks tasks = Tasks.fromJson(
                  docs[index].data() as Map<String, dynamic>,
                );

                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tasks.name ?? "No name",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(tasks.email ?? "No email"),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(25.0),
        child: TextButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignUp()),
            );
          },
          child: const Text("Logout", style: TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}

class Tasks {
  final String? name;
  final String? email;
  final String? gender;

  Tasks({this.name, this.email, this.gender});

  factory Tasks.fromJson(Map<String, dynamic> json) {
    return Tasks(
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
    );
  }
}
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   var responce = FirebaseFirestore.instance.collection('Tasks').get();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//
//         decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Color(0xFF6A1B9A),
//                 Color(0xFFAB47BC),
//                 Color(0xFFEC407A),
//                 Color(0xFF26C6DA),
//               ],
//               stops: [0.1, 0.4, 0.7, 1.0],
//             )),
//         child: FutureBuilder(future: responce, builder: (context, snapshot) {
//           if(snapshot.connectionState==ConnectionState.waiting){
//             return Center(child: CircularProgressIndicator());
//           }
//           if(snapshot.hasError){
//             return Text("Something going wrong");
//           }
//           return ListView.builder(itemCount: snapshot.data!.docs.length,itemBuilder: (context, index) {
//           stuent s = Tasks.fromJson(snapshot.data!.docs[index].data() as Map<String, dynamic>,);
//             return Card(
//               child:Column(
//                 children: [
//                   Text(s.name.toString()),
//                   Text(s.email.toString()),
//                   Text(s.gender.toString()),
//                 ],
//               ),
//             );
//
//           },);
//         },),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(25.0),
//         child: TextButton(onPressed: ()async{
//           await FirebaseAuth.instance.signOut();
//           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn(),));
//         }, child: Text("Logout",style: TextStyle(color: Colors.black),)),
//       ),
//     );
//   }
// }
