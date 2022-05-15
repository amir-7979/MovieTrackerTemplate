import 'package:flutter/material.dart';

String? checkUsername(String txt) {
  if (txt.isEmpty) return 'Please enter username';
  if (txt.length < 7) return "Username Length Must Be More Than 6";
  if (txt.contains(' ')) return "Allowing all character except 'whitespace'";
  return null;
}

String? checkEmail(String txt) {
  if (txt.isEmpty) return 'Please enter email';
  return null;
}

String? checkPasswordSignUp(String txt1, String txt2, String txt3) {
  if (txt1.isEmpty) return 'Please enter password';
  if (!txt1.contains(RegExp(r'[0-9]'))) return "Password Must Contain A Number";
  if (!txt1.contains(RegExp(r'[A-Z]'))) return "Password Must Contain An Uppercase";
  if (txt1.length < 8) return "Password Length Must Be More Than 8, ";
  if (txt1 == txt3) return "Password couldn't Equal With Username ";
  if (txt1 != txt2) return "Passwords Don't Match, ";
  if (txt1.contains(' ')) return "Allowing all character except 'whitespace', ";
  return null;
}

String? checkPasswordLogin(String txt1) {
  if (txt1.isEmpty) return 'Please enter password';
  if (!txt1.contains(RegExp(r'[0-9]'))) return "Password Must Contain A Number";
  if (!txt1.contains(RegExp(r'[A-Z]'))) return "Password Must Contain An Uppercase";
  if (txt1.length < 8) return "Password Length Must Be More Than 8, ";
  if (txt1.contains(' ')) return "Allowing all character except 'whitespace', ";
  return null;
}


TextFormField buildTextField(BuildContext context, TextEditingController controller, TextInputType inputType, Function function, String text) {
  return TextFormField(
    style: const TextStyle(color: Colors.white),
    controller: controller,
    keyboardType: inputType,
    onEditingComplete: () => FocusScope.of(context).nextFocus(),
    decoration: InputDecoration(
      labelText: text,
      labelStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    validator: (txt) => function(),
    //onSubmitted: (txt) => function(controller.text),
  );
}

TextFormField buildTextField2(BuildContext context, bool passwordVisible,
    TextEditingController controller, TextInputType inputType, Function function, Function toggle, String text) {
  return  TextFormField(
    obscureText: passwordVisible,
    style: const TextStyle(color: Colors.white),
    controller: controller,
    onEditingComplete: () => FocusScope.of(context).nextFocus(),
    keyboardType: inputType,
    validator: (txt) => function(),
    decoration: InputDecoration(
      labelText: text,
      labelStyle: const TextStyle(color: Colors.grey),
      suffixIcon: IconButton(
        icon: Icon(
          passwordVisible
              ? Icons.visibility_off
              : Icons.visibility,
          color: Colors.white,
        ),
        onPressed: toggle(),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
  );
}



TextField buildTextField3(BuildContext context, bool passwordVisible,
    TextEditingController controller, TextInputType inputType, Function function, Function toggle,
    bool bol, String? msg, String text) {
  return  TextField(
    obscureText: passwordVisible,
    style: const TextStyle(color: Colors.white),
    controller: controller,
    onEditingComplete: () {FocusScope.of(context).nextFocus();
      //checkPasswordLogin2(_loginUserNameController.text);
    },
    keyboardType: inputType,
    onSubmitted: (txt) => function(controller.text),
    decoration: InputDecoration(
      errorText: bol ? null : msg,
      labelText: text,
      labelStyle: const TextStyle(color: Colors.grey),
      suffixIcon: IconButton(
        icon: Icon(
          passwordVisible
              ? Icons.visibility_off
              : Icons.visibility,
          color: Colors.white,
        ),
        onPressed: toggle(),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
  );
}