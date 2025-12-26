import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../controller/auth_controller.dart';
import '../../../utils/colors.dart';
import '../../../widgets/Custom_button.dart';
import '../../../widgets/custom_text_fild.dart';
import '../../homeScreen/homeScreen.dart';

class Registerscreen extends StatelessWidget {
  Registerscreen({super.key});
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: [
                Obx(
                  () => InkWell(
                    onTap: () => controller.pickImage(),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        image: controller.selectedImage.value.path == ''
                            ? null
                            : DecorationImage(
                                image: FileImage(
                                  controller.selectedImage.value,
                                ),
                                fit: BoxFit.cover,
                              ),
                      ),
                      child: const Center(
                        child: Icon(Icons.add, color: Colors.white, size: 30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                CustomField(
                  label: 'Name',
                  hintText: 'Enter your full name',
                  onChanged: (value) {
                    controller.userModel.value.name = value;
                  },
                ),
                const SizedBox(height: 15),
                CustomField(
                  label: 'Phone Number',
                  hintText: 'Enter your phone number',
                  onChanged: (value) {
                    controller.userModel.value.phone = value;
                  },
                ),
                const SizedBox(height: 15),
                CustomField(
                  label: 'Email Address',
                  hintText: 'Enter your email address',
                  onChanged: (value) {
                    controller.userModel.value.email = value;
                  },
                ),
                const SizedBox(height: 15),
                CustomField(
                  label: 'Date Of Birth',
                  hintText: 'yyyy-mm-dd',
                  onChanged: (value) {
                    controller.userModel.value.dateOfBirth = value;
                  },
                ),
                const SizedBox(height: 15),
                Obx(
                  () => CustomField(
                    label: "Password",
                    hintText: "Enter your password",
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
                    label: controller.isLoading.value ? "Loading..." : "Sign Up",
                    onTap: () {
                      Get.to(() => Homescreen());
                     // controller.register();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
