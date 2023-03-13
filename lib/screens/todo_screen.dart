import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/todo_service.dart';

class TodoScreen extends StatelessWidget {
  final TodoService _todoService = TodoService();
  TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _todoService.todoStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          var docs = snapshot.data?.docs ?? [];

          if (docs.isEmpty) {
            return const Center(child: Text('No Todos found'));
          }

          return ListView.separated(
            itemCount: docs.length,
            itemBuilder: (context, i) {
              String id = docs[i].id;
              Map<String, dynamic> data =
                  docs[i].data() as Map<String, dynamic>;
              return CheckboxListTile(
                title: Text(data['title']),
                onChanged: (isDone) => _todoService.updateTodo(id, isDone!),
                value: data['isDone'],
                secondary: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                              title: const Text('Are you sure?'),
                              content:
                                  const Text('Do yo want to delete this todo'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _todoService.deleteTodo(id);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Yes'),
                                ),
                              ],
                            ));
                  },
                  icon: const Icon(Icons.delete),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                checkboxShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          );
        });
  }
}
