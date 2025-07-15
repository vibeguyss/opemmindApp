class MyWriteModel {
  final int dailyId;
  final String title;
  final String content;

  MyWriteModel({
    required this.dailyId,
    required this.title,
    required this.content
  });

  factory MyWriteModel.fromJson(Map<String, dynamic> json) {
    return MyWriteModel(
      dailyId: json['dailyId'],
      title: json['title'],
      content: json['content'],
    );
  }
}
