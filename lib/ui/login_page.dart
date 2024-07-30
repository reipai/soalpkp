import 'package:flutter/material.dart';
import '../main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      // if (_usernameController.text == 'user' && _passwordController.text == 'Password1!') {
      //
      // } else {
      //
      // }
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 8) {
      return 'Password harus minimal 8 karakter';
    }
    if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)){
      return 'Password harus memiliki minimal 1 huruf kapital';
    }
    if (!RegExp(r'^(?=.*[0-9])').hasMatch(value)){
      return 'Password harus memiliki minimal 1 angka';
    }
    if (!RegExp(r'^(?=.*[!@#\$&*~])').hasMatch(value)){
      return 'Password harus memiliki minimal 1 karakter spesial';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: _validatePassword,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: _login,
                  child: Text('Login')
              ),
            ],
          ),
        ),
      ),
    );
  }
}