import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:websoket/widgets/Custom_button.dart';
import 'package:websoket/widgets/custom_text_fild.dart';
import '../../../controller/auth_controller.dart';
import '../../../utils/colors.dart';
import '../../homeScreen/homeScreen.dart';
import '../registerScreen/registerScreen.dart';

class Loginscreen extends StatelessWidget {
  Loginscreen({super.key});

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .center,
                children: [
                  Image.asset("assets/images/logo.png", width: 150),
                  const SizedBox(height: 10),
                  Text(
                    "Sign In",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Please enter your details to continue with your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black.withOpacity(.5)),
                  ),
                  const SizedBox(height: 30),
                  CustomField(
                    label: "Email Address",
                    hintText: "Enter your email address",
                    onChanged: (value) {
                      controller.userModel.value.email = value;
                    },
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => CustomField(
                      label: "Password",
                      hintText: "Enter your password",
                      onChanged: (value) {
                        controller.userModel.value.password = value;
                      },
                      isSecured: controller.isObscure.value,
                      trailing: IconButton(
                        onPressed: () {
                          controller.isObscure.value =
                              !controller.isObscure.value;
                        },
                        icon: Icon(
                          controller.isObscure.value == true
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Obx(
                    () => CustomButton(
                      label: controller.isLoading.value
                          ? "Loading..."
                          : "Log In",
                      onTap: () {
                        Get.to(() => Homescreen());
                        // controller.login();
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Get.to(() => Registerscreen());
                    },
                    child: Text(
                      'CREATE A NEW ACCOUNT',
                      style: TextStyle(
                        color: AppColors.primary.withOpacity(.5),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
