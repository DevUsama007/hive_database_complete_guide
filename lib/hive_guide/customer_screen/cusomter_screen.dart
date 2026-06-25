import 'package:flutter/material.dart';
import 'package:hive_database_guide/hive_guide/boxes/boxes.dart';
import 'package:hive_database_guide/hive_guide/customer_screen/custom_widgets/add_customer_widget.dart';
import 'package:hive_database_guide/hive_guide/customer_screen/custom_widgets/customer_box.dart';
import 'package:hive_database_guide/hive_guide/customer_screen/edit_customer_widget.dart';
import 'package:hive_database_guide/hive_guide/models/customer_model.dart';
import 'package:hive_flutter/adapters.dart';

class CustomScreen extends StatefulWidget {
  const CustomScreen({super.key});

  @override
  State<CustomScreen> createState() => _CustomScreenState();
}

class _CustomScreenState extends State<CustomScreen> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addCustomerDialogue(
            context: context,
            nameController: nameController,
            addressController: addressController,
            onAdd: () {
              print(nameController.text);
              print(addressController.text);
              final data = CustomerModel(
                name: nameController.text,
                address: addressController.text,
              );
              final box = Boxes.getCustomer();
              box.add(data);
              data.save();
              Navigator.pop(context);
            },
          );
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Customer List',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ValueListenableBuilder<Box<CustomerModel>>(
        valueListenable: Boxes.getCustomer().listenable(),
        builder: (context, box, child) {
          if (box.values.isEmpty) {
            return const Center(child: Text('No Customer Added'));
          }
          var data = box.values
              .toList()
              .cast<CustomerModel>()
              .reversed
              .toList();
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),

                child: CustomerWidget(
                  context: context,
                  onEditTap: () {
                    editCustomerDialogue(
                      name: data[index].name.toString(),
                      addressm: data[index].address.toString(),
                      context: context,
                      nameController: nameController,
                      addressController: addressController,
                      onEdit: () {
                        data[index].name = nameController.text;
                        data[index].address = addressController.text;
                        data[index].save();
                        Navigator.pop(context);
                      },
                    );
                  },
                  onDeleteTap: () async {
                    await data[index].delete();
                  },
                  CustomerName: data[index].name.toString(),
                  CustomerLocation: data[index].address.toString(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
