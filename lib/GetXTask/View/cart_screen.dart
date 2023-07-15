import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/product_controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ProductController productController1 = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: productController1.listCart.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  width: 250,
                  color: Colors.yellow,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Text(productController1.listCart[index]["Name"]),
                      Text(productController1.listCart[index]["Price"]),
                      Text(productController1.listCart[index]["Rating"]),
                      GetBuilder<ProductController>(
                        init: ProductController(),
                        builder: (controller) {
                          return GestureDetector(
                            onTap: () {
                              productController1
                                  .addCart(productController1.listCart[index]);
                            },
                            child: Icon(Icons.shopping_cart),
                          );
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
