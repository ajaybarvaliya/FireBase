import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class singleUsers extends StatefulWidget {
  const singleUsers({Key? key}) : super(key: key);

  @override
  State<singleUsers> createState() => _singleUsersState();
}

class _singleUsersState extends State<singleUsers> {
  /// single user
  DocumentReference user = FirebaseFirestore.instance
      .collection('Users')
      .doc('ftYHD8Y4d87tQ37zw0Hm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: user.get(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Center(child: Text("${data["email"]}"));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
