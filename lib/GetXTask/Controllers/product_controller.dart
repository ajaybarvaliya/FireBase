import 'package:get/get.dart';

class ProductController extends GetxController {
  List<Map<String, dynamic>> listCart = [];

  void addCart(product) {
    if (listCart.contains(product)) {
      listCart.remove(product);
      update();
    } else {
      listCart.add(product);
      update();
    }
  }
}
