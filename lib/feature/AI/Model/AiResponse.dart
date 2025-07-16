class AiResponse {
  final String response;

  AiResponse({required this.response});

  factory AiResponse.fromJson(Map<String, dynamic> json) {
    return AiResponse(response: json['response'] as String);
  }
}
