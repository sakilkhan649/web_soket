import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../core/services/api_services.dart';

import '../models/users_models.dart';

class HomeController extends GetxController {
  var users = <UsersModel>[].obs;

  RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    getUsers();
  }

  getUsers() async {
    isLoading.value = true;
    update();

    final response = await ApiServices.getUsers();
    isLoading.value = false;

    if (response.statusCode != 200) {
      print(response.body);
      Get.snackbar('Error', response.reasonPhrase!);
      return;
    }

    users.value = usersModelFromJson(response.body);
    update();
  }
}
