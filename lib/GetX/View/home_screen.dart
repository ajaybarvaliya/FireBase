import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../RippleGetX/View/demo_screen.dart';
import '../Controller/counter_controller.dart';

class DemoState extends StatefulWidget {
  const DemoState({super.key});

  @override
  State<DemoState> createState() => _DemoStateState();
}

class _DemoStateState extends State<DemoState> {
  CounterController counterController = Get.put(CounterController());
  CounterController counterController1 = Get.find();

  Future<int> getData() async {
    await Future.delayed(const Duration(seconds: 3));

    return 100;
  }

  @override
  Widget build(BuildContext context) {
    print('HELLO');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text('${snapshot.data}');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            GetBuilder<CounterController>(
              builder: (controller) => Text('${controller.counter}'),
            ),
            ElevatedButton(
              onPressed: () {
                counterController.increment();
              },
              child: const Text('Add'),
            ),
            MaterialButton(
              onPressed: () {
                Get.snackbar(
                  "GeeksforGeeks",
                  "Hello everyone",
                  icon: Icon(Icons.person, color: Colors.white),
                  snackPosition: SnackPosition.TOP,
                  colorText: Colors.black,
                  backgroundColor: Colors.deepPurpleAccent.withOpacity(0.2),
                );
              },
              color: Colors.brown,
              child: Text("press"),
            ),
          ],
        ),
      ),
    );
  }
}
