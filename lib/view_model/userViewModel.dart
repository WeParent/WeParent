import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weparent/utils/consts.dart';

class UserProfileViewModel {
  final String accessToken;

  UserProfileViewModel({required this.accessToken});

  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      final response = await http.get(
        Uri.parse('$BASE_URL/user/showProfile'),
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

  Future<void> updateUserProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String profilePhoto,
  }) async {
    final response = await http.put(
      Uri.parse('$BASE_URL/user/update'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'FirstName': firstName,
        'LastName': lastName,
        'Email': email,
        'ProfilePhoto': profilePhoto,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update profile');
    }
  }
}
