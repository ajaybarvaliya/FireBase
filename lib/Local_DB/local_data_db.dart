import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DemoLocalDb extends StatefulWidget {
  const DemoLocalDb({super.key});

  @override
  State<DemoLocalDb> createState() => _DemoLocalDbState();
}

class _DemoLocalDbState extends State<DemoLocalDb> {
  Database? database;
  Future<void> createDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER)');
    });
  }

  Future<void> insertData() async {
    await database!.insert('Test', {
      "id": 0,
      "name": "abc",
      "value": 100,
    });
  }

  Future<void> getData() async {
    List<Map<String, dynamic>> data = await database!.query('Test');
    print('DATATAT $data');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
