import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:AyatekeApp/providers/auth.dart';
import 'package:AyatekeApp/providers/todo.dart';

import 'package:AyatekeApp/views/loading.dart';
import 'package:AyatekeApp/views/login.dart';
import 'package:AyatekeApp/views/register.dart';
import 'package:AyatekeApp/views/password_reset.dart';
import 'package:AyatekeApp/views/todos.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      builder: (context) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData(primaryColor: Colors.indigo[900], accentColor: Color(0x17202a)),
        // darkTheme: ThemeData.dark(),
        initialRoute: '/',
        routes: {
          '/': (context) => Router(),
          '/login': (context) => LogIn(),
          '/register': (context) => Register(),
          '/password-reset': (context) => PasswordReset(),
        },
      ),
    ),
  );
}

class Router extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Consumer<AuthProvider>(
      builder: (context, user, child) {
        switch (user.status) {
          case Status.Uninitialized:
            return Loading();
          case Status.Unauthenticated:
            return LogIn();
          case Status.Authenticated:
            return ChangeNotifierProvider(
              builder: (context) => TodoProvider(authProvider),
              child: Todos(),
            );
          default:
            return LogIn();
        }
      },
    );
  }
}
