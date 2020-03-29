//提供网络请求
import 'package:flutter/cupertino.dart';
import 'package:flutter_website/models/product.dart';
import 'package:flutter_website/utils/net/http_exception.dart';
import 'package:flutter_website/utils/net/http_response.dart';

import 'net/http_service.dart';

class NetService {
  static NetService _instance;

  NetService._internal();

  factory NetService.getInstance() {
    if (_instance == null) {
      _instance = NetService._internal();
    }
    return _instance;
  }

  @override
  String getBaseUrl() {
    // TODO: implement getBaseUrl
    return null;
  }

  getProducts(int index, Function(List<Product>) onSuccess,
      Function(int code, dynamic msg) onError) async {
    HttpService.getInstance().get('',
        {'action': 'getProducts', 'pageIndex': index}).catchError((error) {
      print(error);
    }).then((response) {
      if (response.isSuccess()) {
        var json = response.data;
        List<Product> list = [];
        if (json != null) {
          List<dynamic> items = json['items'];
          for (var item in items) {
            list.add(Product.fromJson(item));
          }
          if (onSuccess != null) {
            onSuccess(list);
          }
        }
      } else {
        if (onError != null) {
          onError(response.code, response.error);
        }
      }
    });
  }
}
