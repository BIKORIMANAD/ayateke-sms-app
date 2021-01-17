import 'package:flutter/material.dart';

import 'package:AyatekeApp/providers/auth.dart';
import 'package:AyatekeApp/utils/exceptions.dart';


class TodoProvider with ChangeNotifier {
  // bool _initialized = false;

  // AuthProvier
  AuthProvider authProvider;

  // // Stores separate lists for open and closed todos.
  // List<Todo> _openTodos = List<Todo>();
  // List<Todo> _closedTodos = List<Todo>();

  // // The API is paginated. If there are more results we store
  // // the API url in order to lazily load them later.
  // String _openTodosApiMore;
  // String _closedTodosApiMore;

  // // API Service
  // ApiService apiService;

  // // Provides access to private variables.
  // bool get initialized => _initialized;
  // List<Todo> get openTodos => _openTodos;
  // List<Todo> get closedTodos => _closedTodos;
  // String get openTodosApiMore => _openTodosApiMore;
  // String get closedTodosApiMore => _closedTodosApiMore;

  // // AuthProvider is required to instaniate our ApiService.
  // // This gives the service access to the user token and provider methods.
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