import 'package:http/http.dart' as http;
import '../../helpers/token_helper.dart';
import '../../models/user_models.dart';
import '../../utils/enpoints.dart';

class ApiServices {
  static Future<http.StreamedResponse> register(UserModel data) async {
    final request = http.MultipartRequest('POST', ApiEnpoints.register);
    request.fields.addAll({
      'email': data.email!,
      'name': data.name!,
      'phone': data.phone!,
      'password': data.password!,
      'date_of_birth': data.dateOfBirth!,
    });
    request.files.add(
      await http.MultipartFile.fromPath(
        'profile_picture',
        data.profilePicture!,
      ),
    );
    request.headers.addAll({'Accept': 'application/json'});
    final response = await request.send();
    return response;
  }

  static Future<http.Response> login(UserModel data) async {
    return await http.post(
      ApiEnpoints.login,
      headers: {'Accept': 'application/json'},
      body: data.toLogin(),
    );
  }

  static Future<http.Response> getUsers() async {
    return await http.get(
      ApiEnpoints.users,
      headers: {
        'Accept': 'application/json',
        'Authorization': await authToken(),
      },
    );
  }

  static Future<http.Response> getMessages(String id) async {
    return await http.get(
      Uri.parse("${ApiEnpoints.messages}/$id"),
      headers: {
        'Accept': 'application/json',
        'Authorization': await authToken(),
      },
    );
  }

  static Future<http.Response> sendMessage(
    String receiverID,
    String message,
  ) async {
    return await http.post(
      ApiEnpoints.sendMessage,
      headers: {
        'Accept': 'application/json',
        'Authorization': await authToken(),
      },
      body: {'receiver_id': receiverID, 'message': message, 'type': 'text'},
    );
  }
}
