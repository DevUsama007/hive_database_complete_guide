import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_database_guide/hive_guide/boxes/boxes.dart';
import 'package:hive_database_guide/hive_guide/models/notes_model.dart';
import 'package:hive_flutter/adapters.dart';

class HiveCrudOpration extends StatefulWidget {
  const HiveCrudOpration({super.key});

  @override
  State<HiveCrudOpration> createState() => _HiveCrudOprationState();
}

class _HiveCrudOprationState extends State<HiveCrudOpration> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

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
        onPressed: () {
          _showmydialog();
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: Boxes.getNotes().listenable(),
        builder: (context, box, child) {
          if (box.values.isEmpty) {
            return const Center(child: Text('No Notes Added'));
          }
          var data = box.values.toList().cast<NotesModel>().reversed.toList();
          return ListView.builder(
            // reverse: true,
            itemCount: box.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.note_alt_outlined,
                      color: Colors.deepPurple,
                    ),
                    title: Text(
                      data[index].title.toString(),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      data[index].description.toString(),
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Container(
                      width: 110,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit, color: Colors.purple),
                          ),
                          IconButton(
                            onPressed: () {
                              deleteNotes(data[index]);
                            },
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future _showmydialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Notes'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(hintText: 'Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(hintText: 'Description'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final data = NotesModel(
                  title: titleController.text,
                  description: descriptionController.text,
                );
                final box = Boxes.getNotes();
                box.add(data);
                data.save();
                Navigator.pop(context);
              },
              child: const Text('Add Notes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void deleteNotes(NotesModel notesModel) async {
    await notesModel.delete();
  }
}
