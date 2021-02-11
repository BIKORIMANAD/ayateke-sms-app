import 'package:flutter/material.dart';

import 'package:smsApp/providers/auth.dart';
import 'package:smsApp/utils/exceptions.dart';


class TodoProvider with ChangeNotifier {
  AuthProvider authProvider;

  TodoProvider(AuthProvider authProvider) {
    // this.apiService = ApiService(authProvider);
  //   this.authProvider = authProvider;

    init();
  }

  void init() async {
    try {
      notifyListeners();
    } on AuthException {
      // API returned a AuthException, so user is logged out.
      await authProvider.logOut(true);
    } catch (Exception) {
      print(Exception);
    }
  }

  Future<void> addTodo(String text) async {
  //   try {
  //     // Posts the new item to our API.
  //     int id = await apiService.addTodo(text);

  //     // If no exceptions were thrown by API Service,
  //     // we add the item to _openTodos.
  //     Todo todo = new Todo();
  //     todo.value = text;
  //     todo.id = id;
  //     todo.status = 'open';

  //     List<Todo> openTodosModified = _openTodos;
  //     openTodosModified.insert(0, todo);

  //     _openTodos = openTodosModified;
  //     notifyListeners();
  //   } on AuthException {
  //     // API returned a AuthException, so user is logged out.
  //     await authProvider.logOut(true);
  //   } catch (Exception) {
  //     print(Exception);
  //   }
  // }
}
}