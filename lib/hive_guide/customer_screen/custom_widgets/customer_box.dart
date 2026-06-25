import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget CustomerWidget({
  required BuildContext context,
  required VoidCallback onEditTap,
  required VoidCallback onDeleteTap,
  required String CustomerName,
  required String CustomerLocation,
}) {
  return Card(
    child: Container(
      width: MediaQuery.sizeOf(context).width * 0.45,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: onEditTap,
                  child: Icon(Icons.edit, color: Colors.purple),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: onDeleteTap,
                  child: Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
            SizedBox(height: 10),
            CircleAvatar(radius: 55, child: Icon(Icons.person, size: 60)),
            SizedBox(height: 10),
            Text(
              CustomerName,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              CustomerLocation,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ),
  );
}
