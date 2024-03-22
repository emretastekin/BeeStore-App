import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  var _loading = false;
  var _errorMessage = "";
  var _nameSurname = "";
  var _email = "";
  var _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SignUp Page")),
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
                  const InputDecoration(hintText: "Enter the name and surname"),
              keyboardType: TextInputType.name,
              onChanged: (value) {
                _nameSurname = value;

                if (_errorMessage.isNotEmpty) {
                  _errorMessage = "";
                  setState(() {});
                }
              },
            ),
            const SizedBox(height: 24),
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
            if (_loading)
              const CircularProgressIndicator()
            else
              TextButton(
                  onPressed: () {
                    if (_email.isNotEmpty &&
                        _password.isNotEmpty &&
                        _nameSurname.isNotEmpty) {
                      _loading = true;
                      setState(() {});
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _email, password: _password)
                          .catchError(
                        (errorMessage) {
                          _errorMessage = errorMessage.toString();
                          _loading = false;
                          setState(() {});
                        },
                      ).then((value) async {
                        final uid = value.user?.uid;
                        final user = {
                          'name': _nameSurname,
                          'email': _email,
                          'signupDate': FieldValue.serverTimestamp(),
                        };
                        if (uid == null) {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .add(user);
                        } else {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(uid)
                              .set(user);
                        }
                        if (mounted) Navigator.of(context).pop();
                      });
                    } else {
                      _errorMessage =
                          "Email address, password and name surname field cannot be empty!";
                      setState(() {});
                    }
                  },
                  child: const Text("Sign Up")),
          ],
        ),
      ),
    );
  }
}
