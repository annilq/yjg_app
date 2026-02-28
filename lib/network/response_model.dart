class ResponseModel<T> {
  final int code;
  final String info;
  final T? data;

  ResponseModel({required this.code, required this.info, this.data});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      code: json['code'] ?? 0,
      info: json['info'] ?? '',
      data: json['data'] ?? json['resp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'info': info, 'data': data};
  }
}
