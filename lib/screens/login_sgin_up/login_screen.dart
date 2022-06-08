import 'package:app04/screens/login_sgin_up/sign_up_screen.dart';
import 'package:app04/screens/start/start_screen.dart';
import 'package:app04/utilities/http_helper.dart';
import 'package:flutter/material.dart';
import 'package:app04/utilities/login_sginUp_helper.dart';

import '../../utilities/consts.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginPasswordController = TextEditingController();
  final _loginUserNameController = TextEditingController();
  bool _passwordVisible = true;
  String message = '';
  bool load = false;

  void _toggle() => setState(() => _passwordVisible = !_passwordVisible);

  @override
  void dispose() {
    _loginPasswordController.dispose();
    _loginUserNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color4,
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text('Welcome! Login with your account and enjoy', style: TextStyle(color: Colors.white, fontSize: 25)),
              Container(height: 40),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildTextField(context, _loginUserNameController, TextInputType.name, () => checkUsername(_loginUserNameController.text), 'username or email'),
                      const SizedBox(height: 15),
                      buildTextField2(context, _passwordVisible, _loginPasswordController, TextInputType.visiblePassword, () => checkPasswordLogin(_loginPasswordController.text), () => _toggle, 'password'),
                      if (message.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            message,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      Container(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              setState(() => load = true);
                              if (_formKey.currentState!.validate()) {
                                message = await logInUser(_loginUserNameController.text, _loginPasswordController.text);
                                if (message == 'logIn') Navigator.of(context).pushReplacementNamed(StartScreen.routeName);
                              }
                              setState(() => load = false);
                            },
                            child: (load)
                                ? const SizedBox(
                              height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                                )
                                : const Text('Login'),
                            style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(SignUpScreen.routeName);
                            },
                            child: Text('SignUp', style: TextStyle(color: color3),)
                          )
                        ],
                      )
                    ],
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
