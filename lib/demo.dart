import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            UserCredential credential =
                await auth.createUserWithEmailAndPassword(
                    email: "ajay@gmail.com", password: "123456");

            print("UID ${credential.user!.uid}");
          },
          child: Text("Register"),
        ),
      ),
    );
  }
}
