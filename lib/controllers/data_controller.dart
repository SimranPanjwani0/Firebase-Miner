import 'package:chat_app/helpers/todo_helper.dart';
import 'package:chat_app/modals/todo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataController extends ChangeNotifier {
  List<Todo> allTodo = [];

  DataController() {
    getAllTodo();
  }

  Future<void> getAllTodo() async {
    allTodo = await TodoHelper.tHelper.getAllTodo();
    notifyListeners();
  }

  void addTodo({required Todo todo}) {
    TodoHelper.tHelper.addTodo(todo: todo);
    getAllTodo();
    notifyListeners();
  }

  void deleteTodo({required Todo todo}) {
    allTodo.remove(todo);
    getAllTodo();
    notifyListeners();
  }

  void updateTodo({required Todo todo}) {
    TodoHelper.tHelper.updateTodo(
      todo: todo,
    );
    getAllTodo();
    notifyListeners();
  }
}
