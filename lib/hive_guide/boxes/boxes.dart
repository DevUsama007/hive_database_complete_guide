import 'package:hive/hive.dart';
import 'package:hive_database_guide/hive_guide/models/customer_model.dart';
import 'package:hive_database_guide/hive_guide/models/notes_model.dart';

class Boxes {
  static Box<NotesModel> getNotes() => Hive.box<NotesModel>('notes');
  static Box<CustomerModel> getCustomer() =>
      Hive.box<CustomerModel>('customer_data');
}
