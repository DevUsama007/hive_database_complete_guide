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
          box.put('Coding_languages', {
            'Language 1': 'Dart',
            'Language 2': 'Python',
            'Language 3': 'C++',
            'Language 4': 'Java',
            'Language 5': 'C',
          });
          setState(() {
            name = box.get('name');
          });
          print(box.get('Coding_languages'));
          print(box.get('Coding_languages')['Language 1']);
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder(
              future: Hive.openBox('intro'),
              builder: (context, snapshot) {
                // 1. Check if the asynchronous connection is still waiting
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.deepPurple),
                  );
                }

                // 2. Check if an error occurred while opening the box
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      child: Text(
                        snapshot.data!.get('name').toString() ?? 'searching',
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
