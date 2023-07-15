import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../Task/BottomNavigationBar.dart';
import 'HomeScreen.dart';
import 'RegisterScreen.dart';

class LoginScreenDemo extends StatefulWidget {
  const LoginScreenDemo({Key? key}) : super(key: key);

  @override
  State<LoginScreenDemo> createState() => _LoginScreenDemoState();
}

class _LoginScreenDemoState extends State<LoginScreenDemo> {
  TextEditingController passcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  final box = GetStorage();

  bool hide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
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
                        HomeScreenDemo(id: "${credential.user!.uid}"),
                  ),
                );
              },
              color: Colors.brown,
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
                    builder: (context) => RegisterScreenDemo(),
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

//import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
//
// import '../Task/Register_data_show.dart';
//
// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   TextEditingController email = TextEditingController();
//   TextEditingController Password = TextEditingController();
//
//   final box = GetStorage();
//
//   FirebaseAuth auth = FirebaseAuth.instance;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Icon(Icons.arrow_back),
//                 ),
//               ),
//               SizedBox(
//                 height: 60,
//               ),
//               Center(
//                 child: Text(
//                   "Login",
//                   style: TextStyle(fontSize: 25),
//                 ),
//               ),
//               SizedBox(
//                 height: 100,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: TextField(
//                   controller: email,
//                   decoration: InputDecoration(
//                       hintText: "Email",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(10),
//                         ),
//                       )),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: TextField(
//                   controller: Password,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                       hintText: "Password",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(10),
//                         ),
//                       )),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Center(
//                 child: Container(
//                   height: 50,
//                   width: 160,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       try {
//                         UserCredential credential =
//                             await auth.signInWithEmailAndPassword(
//                                 email: "${email.text}",
//                                 password: "${Password.text}");
//
//                         box.write("uid", "${credential.user!.uid}");
//
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => Registerdatashow(
//                               id: '${credential.user!.uid}',
//                             ),
//                           ),
//                         );
//                       } on FirebaseAuthException catch (error) {
//                         print('Error ${error.message} ${error.code}');
//
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('${error.message}'),
//                           ),
//                         );
//                       }
//                       ;
//                     },
//                     child: Text("Login"),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
