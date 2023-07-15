import 'package:firebase/RegisterScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool loading = false;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            loading
                ? const CircularProgressIndicator()
                : SizedBox(
                    width: 160,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        try {
                          UserCredential credential =
                              await auth.signInWithEmailAndPassword(
                                  email: "${emailcontroller.text}",
                                  password: "${passwordcontroller.text}");

                          setState(() {
                            loading = false;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          );
                        } on FirebaseAuthException catch (e) {
                          setState(() {
                            loading = false;
                          });
                          print('ERROR ${e.message} ${e.code}');

                          String message = '';

                          if (e.code == 'unknown') {
                            message = "Email and Password not be Empty";
                          } else if (e.code == 'invalid-email') {
                            message = "Please Enter Valid Email";
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${message}'),
                            ),
                          );
                        }
                      },
                      child: Text("log in"),
                    ),
                  ),
            // InkWell(
            //   onTap: () async {
            //     setState(() {
            //       loading = true;
            //     });
            //     try {
            //       UserCredential credential =
            //           await auth.signInWithEmailAndPassword(
            //               email: emailcontroller.text,
            //               password: passwordcontroller.text);
            //       print("UID ${credential.user?.uid}");
            //
            //       setState(() {
            //         loading = false;
            //       });
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => Center(
            //             child: Text("Done"),
            //           ),
            //         ),
            //       );
            //     } on FirebaseAuthException catch (e) {
            //       setState(() {
            //         loading = false;
            //       });
            //       print("ERROR ${e.message} ${e.code}");
            //
            //       String message = '';
            //
            //       if (e.code == 'unknown') {
            //         message = "Email and Password not be Empty";
            //       } else if (e.code == 'invalid-email') {
            //         message = "Please Enter Valid Email";
            //       }
            //
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(
            //           content: Text("${e.message}"),
            //         ),
            //       );
            //     }
            //   },
            //   child: Container(
            //     width: 200,
            //     height: 40,
            //     color: Colors.brown,
            //     child: Center(
            //       child: Text(
            //         "log in",
            //         style: TextStyle(color: Colors.white),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
