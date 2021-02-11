import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:smsApp/providers/auth.dart';
import 'package:smsApp/providers/todo.dart';

import 'package:smsApp/views/loading.dart';
import 'package:smsApp/views/login.dart';
import 'package:smsApp/views/register.dart';
import 'package:smsApp/views/password_reset.dart';
import 'package:smsApp/views/todos.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  runApp(
    ChangeNotifierProvider(
      builder: (context) => AuthProvider(),
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        theme:
            ThemeData(primaryColor: Colors.blueAccent, accentColor: Color(0x17202a),fontFamily: 'Raleway'),

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
