import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Task/HomePage.dart';
import 'package:flutter/material.dart';

import 'AddProducts.dart';
import 'UpdateProducts.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  @override
  Widget build(BuildContext context) {
    var user = FirebaseFirestore.instance.collection('Person');

    TextEditingController namecontroller = TextEditingController();
    TextEditingController pricecontroller = TextEditingController();
    TextEditingController descontroller = TextEditingController();
    TextEditingController ratcontroller = TextEditingController();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductsDemo(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection("Person")
            .doc("${box.read("uid")}")
            .collection("Products")
            .get(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                return InkResponse(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateProducts(
                            products: data,
                            productid: snapshot.data!.docs[index].id),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      height: 150,
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 280),
                            child: PopupMenuButton(
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 1,
                                  child: Text("delete"),
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: Text("update"),
                                ),
                              ],
                              onSelected: (value) {
                                value == 1
                                    ? user
                                        .doc(box.read("uid"))
                                        .collection("Products")
                                        .doc(snapshot.data!.docs[index].id)
                                        .delete()
                                    : SizedBox();

                                value == 2
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UpdateProducts(
                                            products: data,
                                            productid:
                                                snapshot.data!.docs[index].id,
                                          ),
                                        ),
                                      )
                                    : SizedBox();

                                setState(() {});
                              },
                            ),
                          ),
                          Text("Name: ${data["Name"]}"),
                          Text("Price: ${data["Price"]}"),
                          Text("Description: ${data["Description"]}"),
                          Text("Rating: ${data["Rating"]}"),
                        ],
                      ),
                    ),
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

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({
//     Key? key,
//     required,
//     this.aa,
//   }) : super(key: key);
//   final aa;
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   TextEditingController name = TextEditingController();
//   TextEditingController price = TextEditingController();
//   TextEditingController description = TextEditingController();
//   TextEditingController rating = TextEditingController();
//   var Users = FirebaseFirestore.instance.collection("Users");
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: FloatingActionButton(
//           onPressed: () async {
//             // await Users.doc("uid").collection("product").get(
// //   {},            // );
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => AddProduct()));
//           },
//           child: Icon(Icons.add),
//         ),
//         body: FutureBuilder<QuerySnapshot>(
//           future: FirebaseFirestore.instance
//               .collection("Users")
//               .doc("JiQP0WSWHCe7NGX7LM0TMzEcEk33")
//               .collection("Products")
//               .get(),
//           builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               print('LENGTH ${snapshot.data!.docs}');
//               if (snapshot.data!.docs == []) {
//                 return const Center(child: Text('No Data'));
//               } else {
//                 Map<String, dynamic> data =
//                     snapshot.data!.docs[0].data() as Map<String, dynamic>;
//                 name = TextEditingController(
//                   text: data['name'],
//                 );
//                 price = TextEditingController(
//                   text: data['price'],
//                 );
//                 description = TextEditingController(
//                   text: data['description'],
//                 );
//                 rating = TextEditingController(
//                   text: data['rating'],
//                 );
//                 return ListView.builder(
//                   itemCount: data.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       height: 200,
//                       width: 300,
//                       child: Column(
//                         children: [
//                           Text(data['name']),
//                           Text(data['price']),
//                           Text(data['description']),
//                           Text(data['rating']),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               }
//             } else {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           },
//         ));
//   }
// }
