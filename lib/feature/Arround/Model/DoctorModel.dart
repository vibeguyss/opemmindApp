class DoctorModel {
  final int userId;

  final String name;

  final String imageUrl;

  DoctorModel({
    required this.userId,
    required this.name,
    required this.imageUrl,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      userId: json['userId'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}
