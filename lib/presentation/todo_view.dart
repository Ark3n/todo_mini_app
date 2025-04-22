/*
TO DO VIEW -responsible for UI
 - use Bloc Builder

*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_mini_app/domain/models/todo_model.dart';
import 'package:todo_mini_app/presentation/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  // show dialog box for user to type todo
  void _showTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          // Cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),

          // Save button
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                todoCubit.addTodo(textController.text);
              },
              child: Text('Save'))
        ],
      ),
    );
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // TodoCubit
    final todoCubit = context.read<TodoCubit>();

    // SCAFFOLD
    return Scaffold(
      // FAB
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showTodoBox(context),
      ),

      // BLOC BUILDER
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          // List view
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              // individual todo
              final todo = todos[index];
              return ListTile(
                // text
                title: Text(todo.text),
                // checkbox
                leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (value) => todoCubit.toggleCompletion(todo)),

                // delete button
                trailing: IconButton(
                    onPressed: () => todoCubit.deleteTodo(todo),
                    icon: Icon(Icons.cancel)),
              );
            },
          );
        },
      ),
    );
  }
}
