// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:myapp/services/logincheck.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 150, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius :  BorderRadius.all(Radius.circular(20.0)),
                    ),
                    prefixIcon:Icon(Icons.person),
                    hintText: 'UserName',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.key),
                    border: OutlineInputBorder(
                      borderRadius :  BorderRadius.all(Radius.circular(20.0)),
                    ),
                    hintText: 'Password'
                  ),
                ),
              ),
              Container(
                  height:50.0,
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () => loginCheck(usernameController.text, passwordController.text, context)

                  )
              )

            ],
          ),
        ),
      ),
    );
  }
}
