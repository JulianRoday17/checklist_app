import 'package:checklist_app/screen/checklist.dart';
import 'package:checklist_app/services/login_service.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class Login extends StatelessWidget {
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
                  child: Center(child: Text('Login')),
                ),
                onPressed: () async {
                  try {
                    var response = await _repository.login(
                        usernameController.text, passwordController.text);

                    var parsedResponse = json.decode(response);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Login Berhasil',
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );

                    var response2 = await _repository
                        .getAllData(parsedResponse['data']['token']);

                    var parsedResponse2 = json.decode(response2);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChecklistPage(
                            parsedResponse['data']['token'],
                            parsedResponse2['data'])));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Login gagal',
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
