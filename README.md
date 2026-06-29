<!--- # hive_database_guide

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
 these packages must be added at these specific possitions




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
<!-- build runner command
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
 --->
# Hive Database Guide for Flutter

This guide explains how to set up and use **Hive Database** in a Flutter project for storing data using model classes and lists.

---

# Required Dependencies

Add the following packages to your **`pubspec.yaml`** file.

```yaml
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
```

> **Note:** These packages must be added under their respective `dependencies` and `dev_dependencies` sections.

---

# Step 1: Create the Model

Create a model class and annotate it with `@HiveType`.

```dart
import 'package:hive/hive.dart';

part 'customer_model.g.dart';

@HiveType(typeId: 2)
class CustomerModel extends HiveObject {
}
```

### Important Notes

* Every model must have a unique `typeId`.
* The generated file must be imported using:

```dart
part 'customer_model.g.dart';
```

* The model class must extend `HiveObject`.

```dart
class CustomerModel extends HiveObject {}
```

---

# Step 2: Add Model Fields

Create the required variables and assign each one a unique `@HiveField()` ID.

Example:

```dart
@HiveField(0)
String name;

@HiveField(1)
String address;
```

### Rules

* Every field **must have a unique `HiveField` ID**.
* Never use the same field ID twice inside a model.

---

# Step 3: Generate the Adapter

After creating the model, run the following command in the terminal:

```bash
flutter packages pub run build_runner build
```

This command will:

* Generate the `*.g.dart` file.
* Create the Hive adapter automatically.
* Add the required generated code (do not modify this generated file).

---

# Step 4: Create a Box Helper Class

Create a helper class to access your Hive boxes.

Example:

```dart
class Boxes {
  static Box<NotesModel> getNotes() =>
      Hive.box<NotesModel>('notes');
}
```

This makes it easier to access the Hive box from anywhere in your project.

---

# Step 5: Initialize Hive

Inside the `main()` function:

* Initialize Hive.
* Register every model adapter.
* Open every required box.

Example:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var path = await getApplicationDocumentsDirectory();

  Hive.init(path.path);

  // Notes Model
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>('notes');

  // Customer Model
  Hive.registerAdapter(CustomerModelAdapter());
  await Hive.openBox<CustomerModel>('customer_data');

  runApp(const MyApp());
}
```

---

# Complete Setup Checklist

* ✅ Add all required dependencies.
* ✅ Create the model class.
* ✅ Annotate the model with `@HiveType`.
* ✅ Extend the model with `HiveObject`.
* ✅ Add `@HiveField()` to every variable.
* ✅ Add the `part 'model_name.g.dart';` statement.
* ✅ Run the Build Runner command.
* ✅ Create a Box helper class.
* ✅ Register every adapter.
* ✅ Open every Hive box in `main()` before using it.

---

# Build Runner Command

```bash
flutter packages pub run build_runner build
```

If the generated file already exists and you want to regenerate it, use:

```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

---

# Notes

* Each model must have a unique `typeId`.
* Each field inside a model must have a unique `HiveField` ID.
* Never edit the generated `*.g.dart` file manually.
* Always register adapters before opening their corresponding boxes.
* Always open the Hive boxes before trying to read or write data.
