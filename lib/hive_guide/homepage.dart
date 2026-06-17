import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
      body: const Center(child: Text('Welcome to Hive Database Guide!')),
    );
  }
}
