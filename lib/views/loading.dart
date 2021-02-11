import 'package:flutter/material.dart';
import 'package:smsApp/styles/styles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:smsApp/providers/auth.dart';
import 'package:smsApp/providers/services.dart';
class Loading extends StatelessWidget {
  initAuthProvider(context) async {
    Provider.of<AuthProvider>(context).initAuthProvider();
  }

  @override
  Widget build(BuildContext context) {
    initAuthProvider(context);

    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          // decoration: BoxDecoration(color: Colors.redAccent),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Services.appName,
              textAlign: TextAlign.center,
              style: Styles.h1,
            ),
            SizedBox(
              height: 25,
            ),
            SpinKitFadingCircle(
              color: Colors.blue,
              size: 50,
            ),
          ],
        ),
      ],
    ));
  }
}
