import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';

import '../controllers/google_controller.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GoogleController googleController = Get.put(GoogleController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 55,
              backgroundImage: NetworkImage(googleController.googleSignIn.currentUser?.photoUrl??"https://img.lovepik.com/free-png/20210923/lovepik-cute-girl-avatar-png-image_401231841_wh1200.png"),
            ),
            Text("${googleController.googleSignIn.currentUser?.displayName}"),
            Text("${googleController.googleSignIn.currentUser?.email}"),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: ElevatedButton(
              onPressed: () {
                googleController.googleLogOut();
                Get.back();
              },
              child:const Text("LogOut"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
