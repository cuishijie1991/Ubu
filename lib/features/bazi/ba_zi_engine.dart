import 'dart:collection';

import 'package:date_format/date_format.dart';
import 'package:flutter_website/features/bazi/pai_pan.dart';
import 'package:flutter_website/features/bazi/solar.dart';
import 'package:flutter_website/features/bazi/solar_term.dart';

class PaiPanEngine {
  static const Gan = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"];
  static const Zhi = [
    "子",
    "丑",
    "寅",
    "卯",
    "辰",
    "巳",
    "午",
    "未",
    "申",
    "酉",
    "戌",
    "亥"
  ];

  String _name;
  DateTime _birthtime;
  bool _isChineseCalendar;
  bool _isMale;
  String _solarBirthTime;
  String _lunarBirthTime;
  String nayinString;
  String genderString;
  String solarString;
  String lunarString;

  PaiPan _paiPan;

  PaiPanEngine.loadBasic(
      this._name, this._birthtime, this._isChineseCalendar, this._isMale) {
    _paiPan = new PaiPan(_birthtime);
    Solar solarMode = Solar(_birthtime);
    nayinString = _paiPan.getNaYinString(_birthtime);
    genderString = _isMale ? "男" : "女";
    var time = '${_birthtime.hour}时${_birthtime.minute}分';
    solarString = '${formatDate(_birthtime, Solar.chineseDateFormat)}$time';
    lunarString = '${solarMode.getLunarString()}$time';
    init();
  }

  String siZhuString;

  String getBasicInfo() {
    return '姓名：$_name   性别：$genderString\n阳历：$solarString\n阴历：$lunarString\n纳音：$nayinString';
  }

  void init() {
    siZhuString = _paiPan.getSiZhuString();
    getDaYunString(siZhuString);
    siZhuArray = [
      siZhuString.substring(0, 2),
      siZhuString.substring(2, 4),
      siZhuString.substring(4, 6),
      siZhuString.substring(6, 8)
    ];
  }

  List<String> siZhuArray = [];
  List<String> daYunYearLabel = [];
  List<String> daYunYear = [];

  getDaYunString(String siZhu) {
    List<String> daYunLabels = List<String>(8);
    DateTime daYunDate = getDaYunStartCalendar(
        _birthtime, _isMale ? 1 : 0, siZhu.substring(0, 1));
    // 起运时间
    int daYunFirstYear = daYunDate.year;
    //初始化大运标签时，标记起运的月份
    String DAYUN_FIRST = ' ${daYunDate.year}.${daYunDate.month + 1}';
    daYunLabels[0] = daYunFirstYear.toString();
    for (int k = 1; k < 8; k++) {
      daYunLabels[k] = (int.parse(daYunLabels[k - 1]) + 10).toString();
    }
    // 显示大运
    daYunYearLabel = _paiPan.getDaYunString(
        _isMale ? 1 : 0, siZhu.substring(0, 2), siZhu.substring(2, 4));
    daYunYear = daYunLabels;
  }

  DateTime getDaYunStartCalendar(DateTime cal, int gender, String yeargan) {
    int result; //获取毫秒数
    DateTime time;
    var jieqis = _paiPan.getWholeYearJieQis(_paiPan.getCheckedYear(cal));
    int jieqiPos = _paiPan.getPostionOfTheYear(cal, jieqis);
    int dir = _paiPan.getPaiDaYunDir(gender, yeargan);
    if (dir == 1) {
      try {
        time = DateTime.parse(jieqis[jieqiPos + 1]);
      } catch (e) {
        print(e);
      }
      result = time.millisecondsSinceEpoch - cal.millisecondsSinceEpoch;
    } else {
      try {
        time = DateTime.parse(jieqis[jieqiPos]);
      } catch (e) {
        print(e);
      }
      result = cal.millisecondsSinceEpoch - time.millisecondsSinceEpoch;
    }
    result = (result / 7200000) ~/ 3;
    return DateTime(cal.year, result, cal.day);
  }

  Map<int, List<String>> liuNianLabelMap = HashMap();
  Map<int, List<String>> liuNianMap = HashMap();

  //* 输入年份，返回该大运中的十年
  List<String> getLiuNianStrings(int year) {
    if (liuNianLabelMap.containsKey(year)) return liuNianLabelMap[year];
    int y = year - 1864;
    List<String> outPut = List(10);

    for (int i = 0; i < 10; i++, y++) {
      outPut[i] = (Gan[y % 10] + Zhi[y % 12]);
    }
    liuNianLabelMap[year] = outPut;
    return outPut;
  }

//  * 输入年份，返回该大运中的十年
  List<String> getLiuNian(int year) {
    if (liuNianMap.containsKey(year)) return liuNianMap[year];
    List<String> outPut = [
      year.toString(),
      (year + 1).toString(),
      (year + 2).toString(),
      (year + 3).toString(),
      (year + 4).toString(),
      (year + 5).toString(),
      (year + 6).toString(),
      (year + 7).toString(),
      (year + 8).toString(),
      (year + 9).toString()
    ];
    liuNianMap[year] = outPut;
    return outPut;
  }

  Map<String, List<String>> liuYueMap = HashMap();

  List<String> getLiuYueStrings(String mGan) {
//    if (liuYueMap.containsKey(mGan)) return liuYueMap[mGan];
    // 创建当年的所有月的干支字符数组monthGanZhis
    List<String> outPut = List(12);
    String monthGan = "丙戊庚壬甲";
    // 获得的位置对5求余来源于：甲己对应丙，乙庚对应戊，丙辛对应庚，，，以此类推
    int ganPos = _paiPan.getGanPosition(mGan.substring(0, 1)) % 5;
    String monBeginGan = monthGan.substring(ganPos, ganPos + 1);
    int gan = _paiPan.getGanPosition(monBeginGan);
    int zhi = _paiPan.getZhiPosition("寅");

    for (int i = 0; i < 12; i++) {
      outPut[i] = Gan[(gan++) % 10] + Zhi[(zhi++) % 12];
    }
    liuYueMap[mGan] = outPut;
    return outPut;
  }
}
