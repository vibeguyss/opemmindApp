class UserModel {
  final int userId;
  final String imageUrl;
  final String name;
  final String email;

  UserModel({required this.userId, required this.imageUrl, required this.name, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userId: json['userId'],
        imageUrl: json['imageUrl'],
        name: json['name'],
        email: json['email']
    );
  }
}