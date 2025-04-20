/*
ISAR TODO MODEL

Converts todo model to isar todo model that we can store in our isar db
pad dependents:
- flutter pub add isar isar_flutter_libs path_provider
_ flutter pub add -d isar_generator build_runner
*/

import 'package:isar/isar.dart';
import 'package:todo_mini_app/domain/models/todo_model.dart';

// to generate isar todo object, run:  dart run build_runner build
part 'isar_todo.g.dart';

@collection
class TodoIsar {
  Id id = Isar.autoIncrement;
  late String text;
  late bool isCompleted;

  // convert isar object -> pure todo object to use in our app
  Todo toDomain() {
    return Todo(
      id: id,
      text: text,
      isCompleted: isCompleted,
    );
  }

  // convert pure todo object -> isar object to store in isar db
  static TodoIsar fromDomain(Todo todo) {
    return TodoIsar()
      ..id = todo.id
      ..text = todo.text
      ..isCompleted = todo.isCompleted;
  }
}
