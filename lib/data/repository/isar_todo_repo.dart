/*
DATABASE REPO

This implements the todo repo and handles storing, retrieving, updating, 
deleting in the isar db.

*/

import 'package:isar/isar.dart';
import 'package:todo_mini_app/data/models/isar_todo.dart';
import 'package:todo_mini_app/domain/models/todo_model.dart';
import 'package:todo_mini_app/domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo {
  // database
  final Isar db;
  IsarTodoRepo(this.db);

  // get todos
  @override
  Future<List<Todo>> getTodos() async {
    // fetch from db
    final todos = await db.todoIsars.where().findAll();

    // return as todo list and give to domain layer
    return todos.map((todoIsar) => todoIsar.toDomain()).toList();
  }

  // add todo
  @override
  Future<void> addTodo(Todo newTodo) {
    // convert todo into isar todo
    final isarTodo = TodoIsar.fromDomain(newTodo);

    // add converted isarTodo to isar db
    return db.writeTxn(() => db.todoIsars.put(isarTodo));
  }

  // update todo
  @override
  Future<void> updateTodo(Todo todo) {
    // convert todo into isar todo
    final isarTodo = TodoIsar.fromDomain(todo);

    // add converted isarTodo to isar db
    return db.writeTxn(() => db.todoIsars.put(isarTodo));
  }

  // delete todo
  @override
  Future<void> deleteTodo(Todo todo) async {
    await db.writeTxn(() => db.todoIsars.delete(todo.id));
  }
}
