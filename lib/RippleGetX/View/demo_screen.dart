import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///   snackbar
            MaterialButton(
              onPressed: () {
                Get.snackbar(
                  "GeeksforGeeks",
                  "Hello everyone",
                  icon: Icon(Icons.person, color: Colors.white),
                  snackPosition: SnackPosition.TOP,
                  colorText: Colors.white,
                  backgroundColor: Colors.deepPurpleAccent.withOpacity(0.4),
                );
              },
              color: Colors.deepPurpleAccent.withOpacity(0.6),
              child: Text(
                "Snackbar",
                style: TextStyle(color: Colors.white),
              ),
            ),

            ///  defaultDialog
            MaterialButton(
              onPressed: () {
                Get.defaultDialog(
                  title: "GeeksforGeeks",
                  middleText: "Hello world!",
                  backgroundColor: Colors.deepPurpleAccent.withOpacity(0.4),
                  titleStyle: TextStyle(color: Colors.white),
                  middleTextStyle: TextStyle(color: Colors.white),
                );
              },
              color: Colors.deepPurpleAccent.withOpacity(0.6),
              child: Text(
                "defaultDialog",
                style: TextStyle(color: Colors.white),
              ),
            ),

            ///  bottomSheet
            MaterialButton(
              onPressed: () {
                Get.bottomSheet(
                  Container(
                    height: 150,
                    color: Colors.deepPurpleAccent.withOpacity(0.4),
                    child: Wrap(
                      children: [
                        ListTile(
                          leading: Icon(Icons.light_mode_outlined,
                              color: Colors.white),
                          title: Text(
                            "Light Mode",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            Get.changeTheme(
                              ThemeData.light(),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.light_mode, color: Colors.white),
                          title: Text(
                            "Dark Mode",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            Get.changeTheme(
                              ThemeData.dark(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  barrierColor: Colors.deepPurpleAccent.withOpacity(0.1),
                  backgroundColor: Colors.deepPurpleAccent.withOpacity(0.1),
                  enableDrag: false,
                  isDismissible: false,
                );
              },
              color: Colors.deepPurpleAccent.withOpacity(0.6),
              child: Text(
                "bottomSheet",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
