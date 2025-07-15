class BaseResponse<T> {
  final T data;
  final int status;

  BaseResponse({
    required this.data,
    required this.status,
  });

  factory BaseResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) {
    return BaseResponse(
      data: fromJsonT(json['data']),
      status: json['status'] as int,
    );
  }

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) {
    return {
      'data': toJsonT(data),
      'status': status,
    };
  }
}
