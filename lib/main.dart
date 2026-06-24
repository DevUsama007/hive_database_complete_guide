import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_database_guide/hive_guide/cusomter_screen.dart';
import 'package:hive_database_guide/hive_guide/hive_crud_oprations.dart';
import 'package:hive_database_guide/hive_guide/homepage.dart';
import 'package:hive_database_guide/hive_guide/models/customer_model.dart';
import 'package:hive_database_guide/hive_guide/models/notes_model.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var path = await getApplicationDocumentsDirectory();
  Hive.init(path.path);
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>('notes');
  Hive.registerAdapter(CustomerModelAdapter());
  await Hive.openBox<CustomerModel>('customer_data');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive database Guide',
      debugShowCheckedModeBanner: false,
      home: CustomScreen(),
    );
  }
}
