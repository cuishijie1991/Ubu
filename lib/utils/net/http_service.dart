import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_website/utils/net/http_exception.dart';
import 'package:flutter_website/utils/net/http_response.dart';

//基础网络请求组件
class HttpService {
  static Dio _dio;
  static HttpService _instance;
  static const String GET = 'GET';
  static const String POST = 'POST';

  HttpService._inner() {
    _dio = Dio(getDefOptions());
    _dio.interceptors.add(LogInterceptor(
        requestBody: true, requestHeader: false, responseBody: true));
  }

  factory HttpService.getInstance() {
    if (_instance == null) {
      _instance = HttpService._inner();
    }
    return _instance;
  }

  static BaseOptions getDefOptions() {
    //header
    Map<String, dynamic> headers = Map<String, dynamic>();
    headers['Accept'] = 'application/json';
    var options = BaseOptions()
      ..connectTimeout = 10 * 1000
      ..receiveTimeout = 20 * 1000
      ..headers = headers;
    return options;
  }

  Future<HResponse> _request(String path,
      {String method, data, Map params}) async {
    if (method == GET) {
      Response response = await _dio.get(path, queryParameters: params);
      return _handleResponse(response);
    } else if (method == POST) {
      Response response = await _dio.post(path, data: data);
      return _handleResponse(response);
    }
  }

  HResponse _handleResponse(Response response) {
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
//        print('response:\n${response.data}');
        if (response.data is Map) {
          return HResponse(0, response.data, null);
        } else {
          var map = json.decode(response.data.toString());
          return HResponse(0, map, null);
        }
      } catch (e) {
        return HResponse(InnerHttpException.DATA_HANDLE_EXCEPTION, null, e);
      }
    } else {
      return HResponse(InnerHttpException.RESPONSE_STATUS_CODE_ERROR, null,
          Exception(response));
    }
  }

  Future<HResponse> get(String path, params) {
    return _request(path, method: GET, params: params);
  }

  Future<HResponse> post(String path, data) {
    return _request(path, method: POST, data: data);
  }

  Future<HResponse> postByUri(String url,
      {data, Map<String, dynamic> headers}) async {
    Response response = await _dio.postUri(Uri.parse(url),
        data: data, options: Options(headers: headers));
    return _handleResponse(response);
  }

  Future<HResponse> getByUri(String url, {Map<String, dynamic> headers}) async {
    Response response = await _dio
        .getUri(Uri.parse(url), options: Options(headers: headers))
        .catchError((e) {
      return HResponse(
          InnerHttpException.RESPONSE_DIO_E_ERROR, null, Exception(e));
    });
    return _handleResponse(response);
  }
}

//成功回调
typedef OnSuccess = Function(dynamic data);
//失败回调
typedef OnError = Function(int code, dynamic error);
