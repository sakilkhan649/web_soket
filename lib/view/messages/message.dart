import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:websoket/models/users_models.dart';
import '../../controller/message_controller.dart';

class MessageScreen extends StatefulWidget {
  final UsersModel user;
  MessageScreen({super.key, required this.user});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final controller = Get.put(MessageController());

  @override
  void initState() {
    super.initState();
    controller.getMessages();
    controller.websocket();
  }
  @override
  void dispose() {
    super.dispose();
    controller.channel.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.user.value.name!),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () => ListView.builder(
                      itemCount: controller.messages.length,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (_, index) {
                        final message = controller.messages[index];
                        return Align(
                          alignment: message.isMe == true
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Text(
                            message.message ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
                  ),
                  TextFormField(
                    controller: controller.message,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.sendMessage();
                        },
                        icon: Icon(Icons.send),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
