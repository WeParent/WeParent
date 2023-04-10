class User {
  String firstName;
  String lastName;
  String email;
  String password;
  String profilePhoto;
  String token;

  User(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.profilePhoto,
      required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['FirstName'] ?? '',
      lastName: json['LastName'] ?? '',
      email: json['Email'] ?? '',
      password: json['Password'] ?? '',
      profilePhoto: json['ProfilePhoto'] ?? '',
      token: json['Token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Email': email,
      'Password': password,
      'ProfilePhoto': profilePhoto,
      'Token': token,
    };
  }
}
