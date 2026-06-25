import 'package:flutter/material.dart';

Future editCustomerDialogue({
  required String name,
  required String addressm,
  required BuildContext context,
  required TextEditingController nameController,
  required TextEditingController addressController,
  required VoidCallback onEdit,
}) async {
  nameController.text = name;
  addressController.text = addressm;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add Customer'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: 'Name'),
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(hintText: 'Address'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: onEdit, child: const Text('Edit Customer')),
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
