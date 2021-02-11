import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:smsApp/providers/auth.dart';
import 'package:smsApp/utils/validate.dart';
import 'package:smsApp/styles/styles.dart';
import 'package:smsApp/widgets/notification_text.dart';
import 'package:smsApp/widgets/styled_flat_button.dart';
import 'package:smsApp/providers/services.dart';

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // backgroundColor: Colors.cyan,
      // backgroundColorEnd: Colors.indigo,
      // backgroundColor: Color(0xFF444152),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
            child: LogInForm(),
          ),
        ),
      ),
    );
  }
}

class LogInForm extends StatefulWidget {
  const LogInForm({Key key}) : super(key: key);

  @override
  LogInFormState createState() => LogInFormState();
}

class LogInFormState extends State<LogInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email;
  String password;
  String message = '';

  Future<void> submit() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      await Provider.of<AuthProvider>(context).login(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(

      key: _formKey,
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 70.0,
            child: Image.asset('assets/images/logo.png'),
          ),
          SizedBox(height: 10.0),
          Consumer<AuthProvider>(
            builder: (context, provider, child) =>
                provider.notification ?? NotificationText(''),
          ),
          SizedBox(height: 10.0),
          TextFormField(
              decoration: Styles.input.copyWith(
                icon: Icon(Icons.email),
                // hintText: 'Type username',
                labelText: 'Enter username *',

              ),
              validator: (value) {
                email = value.trim();
                // return Validate.requiredField(value, 'Username is required.');
                return Validate.validateEmail(value);
              },style: Styles.h1),
          SizedBox(height: 15.0),
          TextFormField(
              obscureText: true,
              decoration: Styles.input.copyWith(
                icon: Icon(Icons.lock_rounded),
                labelText: 'Type password',
              ),
              validator: (value) {
                password = value.trim();
                return Validate.requiredField(value, 'Password is required.');
              },style: Styles.h1),
          SizedBox(height: 15.0),
          FlatButton(
            textColor: Colors.white,
            height: 45.0,
            color: Colors.blue[500],
            splashColor: Colors.blue[200],
            onPressed: submit,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('SIGN IN', ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Icon(Icons.login, color: Colors.white,),
                ),
            ],
            ),
          ),
          // SizedBox(height: 20.0),
          // Center(
          //   child: RichText(
          //     text: TextSpan(
          //         text: 'Forgot Your Password?',
          //         style: Styles.p.copyWith(color: Colors.blue[500]),
          //         recognizer: TapGestureRecognizer()
          //           ..onTap = () => {
          //                 Navigator.pushNamed(context, '/password-reset'),
          //               }),
          //   ),
          // ),
          SizedBox(height: 70.0),
          Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: Services.powered, style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
