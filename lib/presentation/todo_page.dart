/*

TO DO PAGE - responsible for providing cubit to view (UI)

- use BLOC provider

*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_mini_app/domain/repository/todo_repo.dart';
import 'package:todo_mini_app/presentation/todo_cubit.dart';
import 'package:todo_mini_app/presentation/todo_view.dart';

class TodoPage extends StatelessWidget {
  final TodoRepo todoRepo;
  const TodoPage({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(todoRepo),
      child: TodoView(),
    );
  }
}
