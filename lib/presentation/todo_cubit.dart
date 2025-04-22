/*

TO DO CUBIT -simple state management

Each cubit is a list of todos.
dependents:
- flutter pub add flutter_bloc

*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_mini_app/domain/models/todo_model.dart';
import 'package:todo_mini_app/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  // reference todo repo
  final TodoRepo todoRepo;

  // Constructor initialize cubit with empty list
  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  // LOAD
  Future<void> loadTodos() async {
    // fetch list of todo from repo
    final todoList = await todoRepo.getTodos();

    // emit the fetched list as the new state
    emit(todoList);
  }

  // ADD
  Future<void> addTodo(String text) async {
    // create new todo with uniq id
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      text: text,
    );

    // save new todo to the repo
    await todoRepo.addTodo(newTodo);

    // re-load
    loadTodos();
  }

  // DELETE
  Future<void> deleteTodo(Todo todo) async {
    // delete todo
    await todoRepo.deleteTodo(todo);

    // re-load
    loadTodos();
  }

  // TOGGLE
  Future<void> toggleCompletion(Todo todo) async {
    // toggle the completion status of provided todo
    final updatedTodo = todo.toggleCompletion();

    // update the todo in repo with new completion status.
    await todoRepo.updateTodo(updatedTodo);

    // re-load
    loadTodos();
  }
}
