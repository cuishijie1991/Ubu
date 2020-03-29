class HResponse {
  int code;
  dynamic error;

  HResponse(this.code, this.data, this.error);

  Map<String, dynamic> data;

  bool isSuccess() => code == 0;
}
