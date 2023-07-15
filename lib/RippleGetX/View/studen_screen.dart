import 'package:flutter/material.dart';

import '../Controller/my_controller.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({Key? key}) : super(key: key);

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  bool upperLower = false;
  var student = Student();

  final student1 = Student(Age: 25, Name: "AJAY");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("My Name ${student.name.value}",
                style: TextStyle(fontSize: 25)),
            MaterialButton(
              onPressed: () {
                student.name.value = student.name.value.toUpperCase();
              },
              color: Colors.yellow,
              child: Text("uppercase"),
            )
          ],
        ),
      ),
    );
  }
}
