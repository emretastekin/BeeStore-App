import 'package:bee_store/pages/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _loading = false;
  var _errorMessage = "";
  var _email = "";
  var _password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Page")),
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_errorMessage.isNotEmpty)
              Text(
                "An error occurred: $_errorMessage",
                style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
            TextField(
              decoration:
                  const InputDecoration(hintText: "Enter the email adress"),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                _email = value;

                if (_errorMessage.isNotEmpty) {
                  _errorMessage = "";
                  setState(() {});
                }
              },
            ),
            const SizedBox(height: 24),
            TextField(
              decoration: const InputDecoration(hintText: "Enter the password"),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              onChanged: (value) {
                _password = value;

                if (_errorMessage.isNotEmpty) {
                  _errorMessage = "";
                  setState(() {});
                }
              },
            ),
            const SizedBox(height: 32),
            if (_loading)
              const CircularProgressIndicator()
            else
              TextButton(
                  onPressed: () {
                    if (_email.isNotEmpty && _password.isNotEmpty) {
                      _loading = true;
                      setState(() {});
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _email, password: _password)
                          .catchError((errorMessage) {
                        _errorMessage = errorMessage.toString();
                        _loading = false;
                        setState(() {});
                      });
                    } else {
                      _errorMessage =
                          "Email address and password field cannot be empty!";
                      setState(() {});
                    }
                  },
                  child: const Text("Login")),
            const Divider(height: 64),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return const SignUpPage();
                    }),
                  );
                },
                child: const Text("Sign Up")),
          ],
        ),
      ),
    );
  }
}
