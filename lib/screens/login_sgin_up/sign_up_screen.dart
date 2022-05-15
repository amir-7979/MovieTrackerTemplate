import 'package:app04/screens/login_sgin_up/login_screen.dart';
import 'package:app04/screens/start/start_screen.dart';
import 'package:app04/utilities/http_helper.dart';
import 'package:app04/utilities/login_sginUp_helper.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signUp-screen';

  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  bool _passwordVisible2 = true;
  String _message = '';
  final _passwordController = TextEditingController();
  final _passwordController2 = TextEditingController();
  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  bool load = false;

  void _toggle() => setState(() => _passwordVisible = !_passwordVisible);

  void _toggle2() => setState(() => _passwordVisible2 = !_passwordVisible2);

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordController2.dispose();
    _emailController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text('Welcome! SignUp and enjoy',
                  style: TextStyle(color: Colors.white, fontSize: 25)),
              const SizedBox(
                height: 40,
              ),
              Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  buildTextField(
                      context,
                      _userNameController,
                      TextInputType.name,
                      () => checkUsername(_userNameController.text),
                      'username'),
                  const SizedBox(
                    height: 15,
                  ),
                  buildTextField(
                      context,
                      _emailController,
                      TextInputType.emailAddress,
                      () => checkEmail(_emailController.text),
                      'email'),
                  const SizedBox(
                    height: 15,
                  ),
                  buildTextField2(
                      context,
                      _passwordVisible,
                      _passwordController,
                      TextInputType.visiblePassword,
                      () => checkPasswordSignUp(_passwordController.text,
                          _passwordController2.text, _userNameController.text),
                      () => _toggle,
                      'password'),
                  const SizedBox(
                    height: 15,
                  ),
                  buildTextField2(
                      context,
                      _passwordVisible2,
                      _passwordController2,
                      TextInputType.visiblePassword,
                      () => checkPasswordSignUp(_passwordController2.text,
                          _passwordController.text, _userNameController.text),
                      () => _toggle2,
                      'confirm password'),
                  const SizedBox(
                    height: 15,
                  ),
                ]),
              ),
              if (_message.isNotEmpty)
                Text(
                  _message,
                  style: const TextStyle(color: Colors.red),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    },
                    child: const Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      setState(() => load = true);
                      if (_formKey.currentState!.validate()) {
                        _message = await signUpUser(
                            _userNameController.text,
                            _emailController.text,
                            _passwordController.text,
                            _passwordController2.text);
                        if (_message == 'signUp') {
                          Navigator.of(context)
                              .pushReplacementNamed(StartScreen.routeName);
                        }
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
                        : const Text('SignUp'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
