class BaseResponse<T> {
  final T data;
  final int status;

  BaseResponse({required this.data, required this.status});

  factory BaseResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) {
    return BaseResponse<T>(
      data: fromJsonT(json['data']),
      status: json['status'] as int,
    );
  }
}
