import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'LoginPage.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key, this.id}) : super(key: key);
  final id;

  @override
  State<Homepage> createState() => _HomepageState();
}

final box = GetStorage();

var user = FirebaseFirestore.instance.collection('Person');

class _HomepageState extends State<Homepage> {
  TextEditingController ftname = TextEditingController();
  TextEditingController lstname = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController gmail = TextEditingController();
  int select = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.red, Colors.orange, Colors.indigo]),
          ),
        ),
      ),
      body: FutureBuilder(
        future: user.doc(widget.id).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;

                ftname = TextEditingController(text: data["Firstname"]);
                lstname = TextEditingController(text: data["Lastname"]);
                gender = TextEditingController(text: data["Gender"]);
                gmail = TextEditingController(text: data["email"]);

                return Center(
                  child: Column(
                    children: [
                      TextField(
                        controller: ftname,
                        decoration: InputDecoration(
                          hintText: "Firstname",
                          constraints: BoxConstraints(maxWidth: 300),
                        ),
                      ),
                      TextField(
                        controller: lstname,
                        decoration: InputDecoration(
                          hintText: "Lasttname",
                          constraints: BoxConstraints(maxWidth: 300),
                        ),
                      ),
                      TextField(
                        controller: gender,
                        decoration: InputDecoration(
                          hintText: "Gender",
                          constraints: BoxConstraints(maxWidth: 300),
                        ),
                      ),
                      TextField(
                        controller: gmail,
                        decoration: InputDecoration(
                          hintText: "Email",
                          constraints: BoxConstraints(maxWidth: 300),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          user.doc(widget.id).update(
                            {
                              "Firstname": ftname.text,
                              "Lastname": lstname.text,
                              "Gender": gender.text,
                              "email": gmail.text
                            },
                          );
                        },
                        child: Text('update'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await box.erase();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPageDemo(),
                            ),
                          );
                        },
                        child: Text('Logout'),
                      )
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
