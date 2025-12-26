import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../core/services/api_services.dart';
import '../core/services/shared_services.dart';
import '../models/user_models.dart';
import '../view/homeScreen/homeScreen.dart';

class AuthController extends GetxController {
  RxBool isObscure = RxBool(true);
  RxBool isLoading = RxBool(false);

  var userModel = UserModel().obs;

  var selectedImage = File('').obs;

  pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      selectedImage.value = File(pickedImage.path);
      update();
      userModel.value.profilePicture = selectedImage.value.path;
    }
  }

  register() async {
    isLoading.value = true;
    update();
    final response = await ApiServices.register(userModel.value);
    print(await response.stream.bytesToString());

    isLoading.value = false;
    if (response.statusCode != 200) {
      Get.snackbar('Error', response.reasonPhrase!);
      return;
    }
    final decoded = jsonDecode(await response.stream.bytesToString());
    print(decoded);
    await SharedServices.setData(SetType.string, 'token', decoded['token']!);
    Get.offAll(() => Homescreen());

    update();
  }

  login() async {
    isLoading.value=true;
    update();
    final response=await ApiServices.login(userModel.value);
    isLoading.value=false;
    final decoded=jsonDecode(response.body);
    print(decoded);
    if(response.statusCode!=200){
      Get.snackbar('Error', decoded['message']);
      return;
    }
    await SharedServices.setData(SetType.string, 'token', decoded['token']);
    Get.offAll(()=>Homescreen());
    update();


  }



}
