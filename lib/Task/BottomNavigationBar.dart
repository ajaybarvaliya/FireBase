import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'HomeScreen1.dart';

class BottomNavBraDemo extends StatefulWidget {
  const BottomNavBraDemo({
    Key? key,
    this.id,
  }) : super(key: key);
  final id;

  @override
  State<BottomNavBraDemo> createState() => _BottomNavBraDemoState();
}

class _BottomNavBraDemoState extends State<BottomNavBraDemo> {
  List<Widget>? screen;

  @override
  void initState() {
    screen = [
      HomeScreen1(),
      Text("s"),
      Homepage(id: widget.id),
    ];
    // TODO: implement initState
    super.initState();
  }

  int select = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {});
          select = value;
        },
        currentIndex: select,
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_chart),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "",
          ),
        ],
      ),
      body: screen![select],
    );
  }
}
