import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'BottomNavigationBar.dart';

import 'HomePage.dart';
import 'HomeScreen1.dart';

class UpdateProducts extends StatefulWidget {
  const UpdateProducts(
      {Key? key, required this.products, required this.productid})
      : super(key: key);
  final Map<String, dynamic> products;
  final String productid;

  @override
  State<UpdateProducts> createState() => _UpdateProductsState();
}

class _UpdateProductsState extends State<UpdateProducts> {
  final box = GetStorage();

  var user = FirebaseFirestore.instance.collection('Person');

  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController descontroller = TextEditingController();
  TextEditingController ratcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: user
            .doc("${box.read("uid")}")
            .collection("Products")
            .doc("${widget.productid}")
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;

                namecontroller = TextEditingController(text: data["Name"]);
                pricecontroller = TextEditingController(text: data["Price"]);
                descontroller =
                    TextEditingController(text: data["Description"]);
                ratcontroller = TextEditingController(text: data["Rating"]);

                return Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    TextField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                        hintText: "Name",
                        constraints: BoxConstraints(maxWidth: 300),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: pricecontroller,
                      decoration: InputDecoration(
                        hintText: "Price",
                        constraints: BoxConstraints(maxWidth: 300),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: descontroller,
                      decoration: InputDecoration(
                        hintText: "Description",
                        constraints: BoxConstraints(maxWidth: 300),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: ratcontroller,
                      decoration: InputDecoration(
                        hintText: "Rating",
                        constraints: BoxConstraints(maxWidth: 300),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        user
                            .doc(box.read("uid"))
                            .collection("Products")
                            .doc(widget.productid)
                            .update(
                          {
                            "Name": namecontroller.text,
                            "Price": pricecontroller.text,
                            "Description": descontroller.text,
                            "Rating": ratcontroller.text
                          },
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomNavBraDemo(),
                          ),
                        );
                      },
                      child: Text("update"),
                    )
                  ],
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
