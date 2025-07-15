class WriteModel {
  final String title;
  final String content;

  WriteModel({
    required this.title,
    required this.content
  });

  factory WriteModel.fromJson(Map<String, dynamic> json) {
    return WriteModel(
        title: json['title'],
        content: json['content'],
    );
  }
}