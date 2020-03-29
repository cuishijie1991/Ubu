import 'package:date_format/date_format.dart';
import 'package:flutter_website/features/horoscope/models/fortune.dart';
import 'package:flutter_website/utils/net/http_service.dart';

class HoroscopeHttpService {
  static const APP_KEY = 'c8b7e7d8ae28f35d';

  static getFortune(
      int astroid, DateTime date, OnSuccess success, OnError error) {
    String dateStr = formatDate(date, [yyyy, '-', mm, '-', dd]);
    String url =
        'https://api.jisuapi.com/astro/fortune?appkey=$APP_KEY&astroid=$astroid&date=$dateStr';
    HttpService.getInstance().getByUri(url).then((response) {
      if (response.isSuccess()) {
        var data = response.data;
        if (data['status'] == 0) {
          Fortune fortune = Fortune.fromJson(data['result']);
          success(fortune);
        } else {
          error(data['status'], data['msg']);
        }
      } else {
        error(response.code, response.error);
      }
    });
  }
}
