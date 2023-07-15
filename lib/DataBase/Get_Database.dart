import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataBasedemo extends StatefulWidget {
  const DataBasedemo({Key? key}) : super(key: key);

  @override
  State<DataBasedemo> createState() => _DataBasedemoState();
}

class _DataBasedemoState extends State<DataBasedemo> {
  CollectionReference users = FirebaseFirestore.instance.collection("Users");

  /// single user
  DocumentReference user = FirebaseFirestore.instance
      .collection('Users')
      .doc('ftYHD8Y4d87tQ37zw0Hm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await users.add({"name": "ertyui", "email": "ertyuiop"});
          // await user.update({"name": "ertyui", "email": "ertyuiop"});
          // user.delete();

          await user.set({
            "name": "abc",
          });
        },
      ),
      body: FutureBuilder(
        future: users.get(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                return Center(
                  child: Column(
                    children: [
                      Text(' email :${data['email']}'),
                      Text(' name :${data['name']}'),
                      Text('${data}'),
                    ],
                  ),
                );
              },
            );
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
