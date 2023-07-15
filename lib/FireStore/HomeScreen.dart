import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreenDemo extends StatefulWidget {
  const HomeScreenDemo({Key? key, this.id}) : super(key: key);
  final id;

  @override
  State<HomeScreenDemo> createState() => _HomeScreenDemoState();
}

class _HomeScreenDemoState extends State<HomeScreenDemo> {
  final box = GetStorage();

  var user = FirebaseFirestore.instance.collection('Details');

  // DocumentReference user =
  //     FirebaseFirestore.instance.collection('Details').doc("09oKlbhqImUkYMVZIAI5");

  @override
  Widget build(BuildContext context) {
    TextEditingController ftname = TextEditingController();
    TextEditingController lstname = TextEditingController();
    TextEditingController gender = TextEditingController();
    TextEditingController gmail = TextEditingController();
    return Scaffold(
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
                          Navigator.pop(context);
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

// class Registerdatashow extends StatefulWidget {
//   const Registerdatashow({Key? key, required this.id}) : super(key: key);
//   final id;
//
//   @override
//   State<Registerdatashow> createState() => _RegisterdatashowState();
// }
//
// class _RegisterdatashowState extends State<Registerdatashow> {
//   CollectionReference User_details =
//       FirebaseFirestore.instance.collection('User_details');
//
//   var userdetail = FirebaseFirestore.instance.collection('User_details');
//   final box = GetStorage();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: userdetail.doc('${widget.id}').get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             Map<String, dynamic> data =
//                 snapshot.data!.data() as Map<String, dynamic>;
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     data['firstname'],
//                   ),
//                   Text(
//                     data['lastname'],
//                   ),
//                   Text(
//                     data['gender'],
//                   ),
//                   Text(
//                     data['email'],
//                   ),
//                   ElevatedButton(
//                       onPressed: () async {
//                         await box.erase();
//                         Navigator.pop(context);
//                       },
//                       child: Text('Logout'))
//                 ],
//               ),
//             );
//           } else {
//             return CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }
// }
