import 'dart:convert';
import 'package:http/http.dart' as http;
import '/utils/constants.dart' as constants;

class UserProfileViewModel {
  final String? accessToken;

  UserProfileViewModel({required this.accessToken});

  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      final response = await http.get(
        Uri.parse('${constants.SERVER_URL}/user/showProfile'),
        headers: {
          'Authorization': '$accessToken',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to get profile');
      }
    } catch (e) {
      throw Exception('Failed to connect to server');
    }
  }
}
