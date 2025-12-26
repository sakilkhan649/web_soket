import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websoket/core/services/shared_services.dart';
import 'package:websoket/view/homeScreen/homeScreen.dart';

import '../auth/loginScreen/loginScreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    print(SharedServices.getData(SetType.string, 'token'));
    Timer(const Duration(seconds: 3), () {
      Get.offAll(() => Loginscreen());
    });
  }

  checkToken() async {
    final token = await SharedServices.getData(SetType.string, 'token');
    if (token != null) {
      Get.offAll(() => Homescreen());
    } else {
      Get.offAll(() => Loginscreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset("assets/images/logo.png", width: 150)),
    );
  }
}
