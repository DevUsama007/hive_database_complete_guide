import 'package:flutter/material.dart';

Future addCustomerDialogue({
  required BuildContext context,
  required TextEditingController nameController,
  required TextEditingController addressController,
  required VoidCallback onAdd,
}) async {
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
          TextButton(onPressed: onAdd, child: const Text('Add Notes')),
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
