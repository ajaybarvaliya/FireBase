import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoggleSignin extends StatefulWidget {
  const GoggleSignin({Key? key}) : super(key: key);

  @override
  State<GoggleSignin> createState() => _GoggleSigninState();
}

class _GoggleSigninState extends State<GoggleSignin> {
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              GoogleSignInAccount? account = await googleSignIn.signIn();

              GoogleSignInAuthentication authentication =
                  await account!.authentication;

              OAuthCredential credential = GoogleAuthProvider.credential(
                  accessToken: authentication.accessToken,
                  idToken: authentication.idToken);

              UserCredential userCredential =
                  await auth.signInWithCredential(credential);

              print('${userCredential.user!.email}');
              print('${userCredential.user!.uid}');
              print('${userCredential.user!.displayName}');
              print('${userCredential.user!.photoURL}');
            },
            child: Text('GOOGLE'),
          ),
          ElevatedButton(
            onPressed: () async {
              await googleSignIn.signOut();
            },
            child: Text('LOGOUT'),
          ),
        ],
      )),
    );
    ;
  }
}
