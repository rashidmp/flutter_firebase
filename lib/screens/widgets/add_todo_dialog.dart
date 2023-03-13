import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/todo_service.dart';

class AddTodoBottomSheet extends StatelessWidget {
  final TodoService _todoService = TodoService();
  final TextEditingController _todoController = TextEditingController();

  AddTodoBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _todoController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black12),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    String title = _todoController.text;
                    _todoService.addTodo(title);
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'submit',
                    style: TextStyle(fontSize: 18),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
