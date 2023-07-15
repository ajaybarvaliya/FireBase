import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'BottomNavigationBar.dart';
import 'HomePage.dart';

class RegisterPageDemo extends StatefulWidget {
  const RegisterPageDemo({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterPageDemo> createState() => _RegisterPageDemoState();
}

class _RegisterPageDemoState extends State<RegisterPageDemo> {
  CollectionReference users = FirebaseFirestore.instance.collection("Person");

  // DocumentReference user = FirebaseFirestore.instance
  //     .collection('Details')
  //     .doc('liI49I9FR8xGoEbEjuhz');

  FirebaseAuth auth = FirebaseAuth.instance;

  final box = GetStorage();

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController gendercontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.black, Colors.blue],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            TextField(
              controller: firstnamecontroller,
              decoration: InputDecoration(
                hintText: "Firstname",
                constraints: BoxConstraints(maxWidth: 300),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: lastnamecontroller,
              decoration: InputDecoration(
                hintText: "Lastname",
                constraints: BoxConstraints(maxWidth: 300),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: gendercontroller,
              decoration: InputDecoration(
                hintText: "Gender",
                constraints: BoxConstraints(maxWidth: 300),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                hintText: "Email",
                constraints: BoxConstraints(maxWidth: 300),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: passcontroller,
              decoration: InputDecoration(
                hintText: "Password",
                constraints: BoxConstraints(maxWidth: 300),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            MaterialButton(
              onPressed: () async {
                UserCredential credential =
                    await auth.createUserWithEmailAndPassword(
                        email: emailcontroller.text,
                        password: passcontroller.text);

                box.write("uid", credential.user!.uid);

                var data = await users.doc(credential.user!.uid).set(
                  {
                    "Firstname": firstnamecontroller.text,
                    "Lastname": lastnamecontroller.text,
                    "Gender": gendercontroller.text,
                    "email": emailcontroller.text,
                  },
                );

                //await user.delete();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BottomNavBraDemo(id: "${credential.user!.uid}"),
                  ),
                );
              },
              child: Text(
                "Register",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
