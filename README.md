# hive_database_guide

Packages that are required and must be added in pubspec.yaml file
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  path_provider: ^2.1.6
dev_dependencies:
  build_runner: ^2.4.13
  hive_generator: ^2.0.1
<!-- these packages must be added at these specific possitions -->




steps to follow for using the hive with list 

model creation

create the model class and specify the hive type like this:
@HiveType(typeId: 2)
class CustomerModel{}

then create the required variable and specify the hivefield id 
@HiveField(0)
  String name;
  @HiveField(1)
  String address;
each variable must have unique hivefield id
after this after this import code line add part 'modelClassName.g.dart'; 
Also extend the model class with HiveObject like this

class NotesModel extends HiveObject {}

after doing this all run this build runner command in the terminal
<!-- build runner command -->
command:  flutter packages pub run build_runner build
this command will create the generated file and also add some unchangeable code 

Box class creation:
create the get method to get the data from each model like this
class Boxes {
  static Box<NotesModel> getNotes() => Hive.box<NotesModel>('notes');}


  hive initialization ,box creation and register adapter in main function 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var path = await getApplicationDocumentsDirectory();
  Hive.init(path.path);
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>('notes');
  Hive.registerAdapter(CustomerModelAdapter());
  await Hive.openBox<CustomerModel>('customer_data');}

