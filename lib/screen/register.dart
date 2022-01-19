import 'package:checklist_app/services/login_service.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  AuthRepository _repository = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Text('Email'),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Container(
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Text('Username'),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Container(
                      child: TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Text('Password'),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Container(
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                child: Container(
                  height: 50,
                  width: 100,
                  child: Center(child: Text('Register')),
                ),
                onPressed: () async {
                  try {
                    var response = await _repository.register(
                        emailController.text,
                        usernameController.text,
                        passwordController.text);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Register Berhasil',
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    Navigator.of(context).pop();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Register gagal',
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
