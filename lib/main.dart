import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_mini_app/data/models/isar_todo.dart';
import 'package:todo_mini_app/data/repository/isar_todo_repo.dart';
import 'package:todo_mini_app/domain/repository/todo_repo.dart';
import 'package:todo_mini_app/presentation/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // get directory path for sorting data
  final dir = await getApplicationDocumentsDirectory();

  // open isar data base
  final isar = await Isar.open([TodoIsarSchema], directory: dir.path);

  // initialize the repo with isar data base
  final isarTodoRepo = IsarTodoRepo(isar);

  // run app
  runApp(MyApp(
    todoRepo: isarTodoRepo,
  ));
}

class MyApp extends StatelessWidget {
  // data base injection through app
  final TodoRepo todoRepo;
  const MyApp({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(todoRepo: todoRepo),
    );
  }
}
