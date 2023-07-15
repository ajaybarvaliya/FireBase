import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../FireStore/RegisterScreen.dart';
import 'BottomNavigationBar.dart';
import 'HomePage.dart';
import 'RegisterPage.dart';

class LoginPageDemo extends StatefulWidget {
  const LoginPageDemo({Key? key}) : super(key: key);

  @override
  State<LoginPageDemo> createState() => _LoginPageDemoState();
}

class _LoginPageDemoState extends State<LoginPageDemo> {
  TextEditingController passcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  final box = GetStorage();

  bool hide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
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
            Text(
              "LoginScreen",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                hintText: "email",
                constraints: BoxConstraints(maxWidth: 300),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: passcontroller,
              obscureText: hide,
              decoration: InputDecoration(
                hintText: "Password",
                constraints: BoxConstraints(maxWidth: 300),
                suffixIcon: InkResponse(
                  onTap: () {
                    setState(
                      () {},
                    );
                    hide = !hide;
                  },
                  child: Icon(
                      hide == true ? Icons.visibility_off : Icons.visibility),
                ),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                UserCredential credential =
                    await auth.signInWithEmailAndPassword(
                        email: emailcontroller.text,
                        password: passcontroller.text);

                box.write("uid", "${credential.user!.uid}");

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BottomNavBraDemo(id: "${credential.user!.uid}"),
                  ),
                );
              },
              color: Colors.blue,
              child: Text(
                "Log in",
                style: TextStyle(color: Colors.white),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPageDemo(),
                  ),
                );
              },
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
