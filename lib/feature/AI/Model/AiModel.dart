class AiModel {
  final String prompt;

  AiModel({required this.prompt});

  factory AiModel.fromJson(Map<String, dynamic> json) {
    return AiModel(prompt: json['prompt']);
  }
}
