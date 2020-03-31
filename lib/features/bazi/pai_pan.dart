import 'package:flutter_website/features/bazi/solar_term.dart';

class PaiPan {
  static const int DAYUN_COUNT = 8; // 需要的大运的数目
  // ==========干支数组===================
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
  static const NaYin = [
    "海中金",
    "海中金",
    "炉中火",
    "炉中火",
    "大林木",
    "大林木",
    "路旁土",
    "路旁土",
    "剑锋金",
    "剑锋金",
    "山头火",
    "山头火",
    "涧下水",
    "涧下水",
    "城头土",
    "城头土",
    "白腊金",
    "白腊金",
    "杨柳木",
    "杨柳木",
    "泉中水",
    "泉中水",
    "屋上土",
    "屋上土",
    "霹雳火",
    "霹雳火",
    "松柏木",
    "松柏木",
    "长流水",
    "长流水",
    "沙中金",
    "沙中金",
    "山下火",
    "山下火",
    "平地木",
    "平地木",
    "壁上土",
    "壁上土",
    "金箔金",
    "金箔金",
    "佛灯火",
    "佛灯火",
    "天河水",
    "天河水",
    "大驿土",
    "大驿土",
    "钗钏金",
    "钗钏金",
    "桑松木",
    "桑松木",
    "大溪水",
    "大溪水",
    "沙中土",
    "沙中土",
    "天上火",
    "天上火",
    "石榴木",
    "石榴木",
    "大海水",
    "大海水"
  ];

  // 计算干支的偏移值
  int yearCyl, dayCyl, hourCyl;
  String monthGanZhi;

  // 三种时间格式化格式
//  static SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
//  static SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH");
//  static SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
//  static SimpleDateFormat sdf4 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

  PaiPan(DateTime cal) {
    DateTime baseDate = DateTime(1900, 1, 31);
    yearCyl = getCheckedYear(cal) - 1864;
    // 求出月的干支
    monthGanZhi = getMonthGanZhiString(cal, getCheckedYear(cal));
    // 求出日和时的偏移值
    int offset =
        (cal.millisecondsSinceEpoch - baseDate.millisecondsSinceEpoch) ~/
            86400000;
    dayCyl = offset + 40;
    hourCyl = (cal.millisecondsSinceEpoch -
            baseDate.millisecondsSinceEpoch +
            3300000) ~/
        7200000;
  }

  //  * 输出四柱
  String getSiZhuString() {
    // 返回四柱
    return cyclicalm(yearCyl) +
        monthGanZhi +
        cyclicalm(dayCyl) +
        cyclicalm(hourCyl);
  }

//   * 传入 月日的offset 传回干支, 0=甲子
  String cyclicalm(int num) {
    return (Gan[num % 10] + Zhi[num % 12]);
  }

  //* 输入日干支，返回空亡
  String getKWString(String rigan) {
    int gan = 0, zhi = 0, kong = 0;
    gan = getGanPosition(rigan.substring(0, 1));
    zhi = getZhiPosition(rigan.substring(1, 2));

    kong = (10 - gan - (12 - zhi) + 12) % 12;
    String kw = Zhi[kong] + Zhi[kong + 1];
    return kw;
  }

//   * 输入性别和年干，返回排大运的方向
  int getPaiDaYunDir(int gender, String yeargan) {
    int dir = 1;
    int yg = getGanPosition(yeargan);
    if ((yg % 2 == 0 && gender == 1) || (yg % 2 == 1 && gender == 0)) {
      // 男阳/女阴
      dir = 1;
    } else if ((yg % 2 == 1 && gender == 1) || (yg % 2 == 0 && gender == 0)) {
      // 男阴/女阳
      dir = -1;
    }
    return dir;
  }

  //  * 排大运方法
  getDaYunString(int gender, String yearganzhi, String monthganzhi) {
    int dir = 1, monthgan = 0, i, monthzhi = 0;
    List<String> daYun = List(DAYUN_COUNT);

    dir = getPaiDaYunDir(gender, yearganzhi.substring(0, 1));

    monthgan = getGanPosition(monthganzhi.substring(0, 1));
    monthzhi = getZhiPosition(monthganzhi.substring(1, 2));

    if (dir == 1) {
      for (i = 0; i < DAYUN_COUNT; i++) {
        daYun[i] = Gan[(++monthgan) % 10].toString() +
            (Zhi[(++monthzhi) % 12].toString());
      }
    } else {
      for (i = 0; i < DAYUN_COUNT; i++) {
        daYun[i] = Gan[((--monthgan) + 10) % 10].toString() +
            (Zhi[((--monthzhi) + 12) % 12].toString());
      }
    }

    return daYun;
  }

  //  * 返回输入的地支所对应的位置
  int getGanPosition(String gan) {
    // 返回输入的天干所对应的位置
    int ganBack = 0, i = 0;
    for (i = 0; i < 10; i++) {
      if (gan == Gan[i]) {
        ganBack = i;
        break;
      }
    }
    return ganBack;
  }

  //  * 返回输入的地支所对应的位置
  int getZhiPosition(String zhi) {
    int zhiBack = 0, i = 0;
    for (i = 0; i < 12; i++) {
      if (Zhi[i] == zhi) {
        zhiBack = i;
        break;
      }
    }
    return zhiBack;
  }

  //  * 输入日期，返回月干支
  String getMonthGanZhiString(DateTime cal, int year) {
    String monthGan = "丙戊庚壬甲";
    int monthGanPos = (year - 1864) % 5;
    String monBeginGan = monthGan.substring(monthGanPos, monthGanPos + 1);
    int gan = getGanPosition(monBeginGan);
    int zhi = getZhiPosition("寅");
    var monthDate = getWholeYearJieQis(year);
    // 创建当年的所有月的干支字符数组monthGanZhis
    var monthGanZhis = List<String>(12);
    for (int i = 0; i < 12; i++) {
      monthGanZhis[i] = Gan[(gan++) % 10] + Zhi[(zhi++) % 12];
    }
    return monthGanZhis[getPostionOfTheYear(cal, monthDate)];
  }

  //  * 输入校对后的年份，返回当年的所有节气的日期（立春~大寒）
  getWholeYearJieQis(int year) {
    SolarTerm solarTerm = new SolarTerm();
    var nowYear = solarTerm.getLunarJieQisDateOfTheYear(year);
    var nextYear = solarTerm.getLunarJieQisDateOfTheYear(year + 1);

    var monthDate = List<String>(12);
    for (int i = 2; i < 12; i++) {
      monthDate[i - 2] = nowYear[i];
    }
    monthDate[10] = nextYear[0];
    monthDate[11] = nextYear[1];
    return monthDate;
  }

  //  * 返回立春日历时间
  DateTime getLiChunCalendar(int year) {
    SolarTerm stLiChun = new SolarTerm();
    String liChunYear = stLiChun.getLiChunString(year);
    return DateTime.parse(liChunYear);
  }

  //  * 输入输入日期和当年节气的数组，返回所在节气的位置
  int getPostionOfTheYear(DateTime calInput, jqStrings) {
    int outPut = 0, i = 0;
    String timeString;
    int inputTime = calInput.millisecondsSinceEpoch;
    for (i = 0; i < jqStrings.length; i++) {
      timeString = jqStrings[i];
      DateTime t = DateTime.parse(timeString);
      if (t.millisecondsSinceEpoch >= inputTime) {
        break;
      }
    }
    outPut = i - 1;
    return outPut;
  }

  //  * 输入日期，返回校正后的年份
  int getCheckedYear(DateTime cal) {
    DateTime calLiChun = getLiChunCalendar(cal.year);
    return (cal.millisecondsSinceEpoch > calLiChun.millisecondsSinceEpoch)
        ? calLiChun.year
        : (calLiChun.year - 1);
  }

  //  * 输入日期返回相应的纳音
  String getNaYinString(DateTime cal) {
    DateTime calLiChun = getLiChunCalendar(cal.year);
    int year = (cal.millisecondsSinceEpoch > calLiChun.millisecondsSinceEpoch)
        ? calLiChun.year
        : (calLiChun.year - 1);
    return NaYin[(year - 1864) % 60];
  }
}
