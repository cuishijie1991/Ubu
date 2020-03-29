//内部网络相关异常，以httpError形式返回
class InnerHttpException {
  //处理异常
  static const int DATA_HANDLE_EXCEPTION = -1;

  //网络状态异常
  static const int RESPONSE_STATUS_CODE_ERROR = -2;

  static const int RESPONSE_DIO_E_ERROR = -3;

  int code;

  InnerHttpException(this.code, this.e);

  Exception e;
}
