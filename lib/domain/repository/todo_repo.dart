/*

TO DO REPOSITORY

Here you define what the app can do.

*/

import 'package:todo_mini_app/domain/models/todo_model.dart';

abstract class TodoRepo {
  // get list of todos
  Future<List<Todo>> getTodos();

  // add new a todo
  Future<void> addTodo(Todo newTodo);

  // update an existing todo
  Future<void> updateTodo(Todo todo);

  // delete todo
  Future<void> deleteTodo(Todo todo);
}

/*
Notes:
- the repo in the domain layer outlines what operations the app can do, 
but doesn't worry about specific implementation details. That's for the 
data Layer.

- technology agnostic: independent of any technology or framework

*/
