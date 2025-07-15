import 'package:openmind_app/feature/Auth/Model/RoleEnum.dart';

class LoginModel {
  final String email;
  final String password;
  final RoleEnum userRole;
  final String name;

  LoginModel({
    required this.email,
    required this.password,
    required this.userRole,
    required this.name
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email'],
      password: json['password'],
      userRole: RoleEnum.values.firstWhere(
            (e) => e.value == json['userRole'].toString().toUpperCase().trim(),
        orElse: () => RoleEnum.user,
      ),
      name: json['name']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'userRole': userRole.value,
      'name': name
    };
  }
}
