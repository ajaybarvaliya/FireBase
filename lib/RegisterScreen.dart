import 'package:firebase/SigninScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                constraints: BoxConstraints(maxWidth: 300, maxHeight: 50),
                hintText: "Email",
              ),
            ),
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: passwordcontroller,
              decoration: InputDecoration(
                constraints: BoxConstraints(maxWidth: 300, maxHeight: 50),
                hintText: "Password",
              ),
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () async {
                setState(() {});
                UserCredential credential =
                    await auth.createUserWithEmailAndPassword(
                        email: emailcontroller.text,
                        password: passwordcontroller.text);

                print("UID ${credential.user?.uid}");

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SigninScreen(),
                  ),
                );
              },
              child: Container(
                width: 200,
                height: 40,
                color: Colors.brown,
                child: Center(
                  child: Text(
                    "Register",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
