import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:AyatekeApp/providers/auth.dart';
import 'package:AyatekeApp/utils/validate.dart';
import 'package:AyatekeApp/styles/styles.dart';
import 'package:AyatekeApp/widgets/notification_text.dart';
import 'package:AyatekeApp/widgets/styled_flat_button.dart';

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text('Ayateke Star Co. Ltd'),
        leading: Container(),
      ),
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
          Text(
            'Log in to Ayateke Star ',
            textAlign: TextAlign.center,
            style: Styles.h1,
          ),
          SizedBox(height: 10.0),
          Consumer<AuthProvider>(
            builder: (context, provider, child) =>
                provider.notification ?? NotificationText(''),
          ),
          SizedBox(height: 30.0),
          TextFormField(
              decoration: Styles.input.copyWith(
                hintText: 'Phone',
              ),
              validator: (value) {
                email = value.trim();
                return Validate.validateEmail(value);
              }),
          SizedBox(height: 15.0),
          TextFormField(
              obscureText: true,
              decoration: Styles.input.copyWith(
                hintText: 'Password',
              ),
              validator: (value) {
                password = value.trim();
                return Validate.requiredField(value, 'Password is required.');
              }),
          SizedBox(height: 15.0),
          StyledFlatButton(
            'Sign In',
            onPressed: submit,
          ),
          SizedBox(height: 20.0),
          // Center(
          //   child: RichText(
          //     text: TextSpan(
          //       children: [
          //         TextSpan(
          //           text: "Don't have an account? ",
          //           style: Styles.p,
          //         ),
          //         TextSpan(
          //           text: 'Register.',
          //           style: Styles.p.copyWith(color: Colors.blue[500]),
          //           recognizer: TapGestureRecognizer()
          //             ..onTap = () => {
          //                   Navigator.pushNamed(context, '/register'),
          //                 },
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(height: 5.0),
          Center(
            child: RichText(
              text: TextSpan(
                  text: 'Forgot Your Password?',
                  style: Styles.p.copyWith(color: Colors.blue[500]),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => {
                          Navigator.pushNamed(context, '/password-reset'),
                        }),
            ),
          ),
        ],
      ),
    );
  }
}
