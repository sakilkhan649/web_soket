import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import '../../controller/home_controller.dart';
import '../../controller/message_controller.dart';
import '../messages/message.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  final controller = Get.put(HomeController());
  final messageController = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.logout))],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemBuilder: (_, index) {
              final user = controller.users[index];

              return ListTile(
                onTap: () {
                  messageController.user.value = user;
                  Get.to(() => MessageScreen(user: user));
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.profilePicture!),
                ),
                title: Text(user.name!),
                subtitle: Text(user.email!),
              );
            },
            itemCount: controller.users.length,
          );
        }
      }),
    );
  }
}
