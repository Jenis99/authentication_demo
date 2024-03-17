import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'google_login/controllers/google_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  GoogleController googleController = Get.put(GoogleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () async {
              log("----------------");
              googleController.googleLogin();
            }, child: const Text("Sign Up With Google")),
          ],
        ),
      ),
    );
  }
}
