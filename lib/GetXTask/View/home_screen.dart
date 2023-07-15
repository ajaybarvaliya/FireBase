import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Controllers/product_controller.dart';

class HomeScreenProduct extends StatefulWidget {
  const HomeScreenProduct({Key? key}) : super(key: key);

  @override
  State<HomeScreenProduct> createState() => _HomeScreenProductState();
}

class _HomeScreenProductState extends State<HomeScreenProduct> {
  ProductController productController = Get.put(ProductController());

  List products = [
    {
      "Name": "Ring",
      "Price": "500",
      "Rating": "5",
    },
    {
      "Name": "Chair",
      "Price": "500",
      "Rating": "4.5",
    },
    {
      "Name": "pen",
      "Price": "500",
      "Rating": "5",
    },
    {
      "Name": "Box",
      "Price": "500",
      "Rating": "5",
    },
    {
      "Name": "Fan",
      "Price": "500",
      "Rating": "5",
    },
    {
      "Name": "Laptop",
      "Price": "500",
      "Rating": "5",
    },
    {
      "Name": "Mobile",
      "Price": "500",
      "Rating": "5",
    },
    {
      "Name": "Shoes",
      "Price": "500",
      "Rating": "5",
    },
    {
      "Name": "Ring",
      "Price": "500",
      "Rating": "5",
    },
    {
      "Name": "Table",
      "Price": "500",
      "Rating": "5",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: products.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            width: 250,
            color: Colors.yellow,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                Text(products[index]["Name"]),
                Text(products[index]["Price"]),
                Text(products[index]["Rating"]),
                GetBuilder<ProductController>(
                  init: ProductController(),
                  builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        productController.addCart(products[index]);
                        setState(() {});
                        print(
                          "jjjjjjjjjjjjjjj ${controller.listCart.contains(products[index])}",
                        );
                      },
                      child: controller.listCart.contains(products[index])
                          ? Icon(Icons.shopping_cart)
                          : Icon(Icons.shopping_cart_outlined),
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
