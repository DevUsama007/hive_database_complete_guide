import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Hive Database Guide',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box = await Hive.openBox('intro');
          box.put('name', "Dev Usama");
          setState(() {
            name = box.get('name');
          });
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Name is ${name ?? "Not set"}'),
            const Text('Welcome to Hive Database Guide!'),
          ],
        ),
      ),
    );
  }
}
