import 'models/horoscope.dart';

//星座相关定义
class HoroscopeConfig {
  static List<Horoscope> horoscopes = [
    HoroscopeConfig.baiyang,
    HoroscopeConfig.jinniu,
    HoroscopeConfig.shuangzi,
    HoroscopeConfig.juxie,
    HoroscopeConfig.shizi,
    HoroscopeConfig.chunv,
    HoroscopeConfig.tiancheng,
    HoroscopeConfig.tianxie,
    HoroscopeConfig.sheshou,
    HoroscopeConfig.mojie,
    HoroscopeConfig.shuiping,
    HoroscopeConfig.shuangyu,
  ];
  static Horoscope baiyang = Horoscope(
      astroid: 1,
      astroname: '白羊座',
      date: '3-21~4-19',
      pic: 'http://api.jisuapi.com/astro/static/images/baiyang.png');

  static Horoscope jinniu = Horoscope(
      astroid: 2,
      astroname: '金牛座',
      date: '4-20~5-20',
      pic: 'http://api.jisuapi.com/astro/static/images/jinniu.png');

  static Horoscope shuangzi = Horoscope(
      astroid: 3,
      astroname: '双子座',
      date: '5-21~6-21',
      pic: 'http://api.jisuapi.com/astro/static/images/shuangzi.png');

  static Horoscope juxie = Horoscope(
      astroid: 4,
      astroname: '巨蟹座',
      date: '6-22~7-22',
      pic: 'http://api.jisuapi.com/astro/static/images/juxie.png');

  static Horoscope shizi = Horoscope(
      astroid: 5,
      astroname: '狮子座',
      date: '7-23~8-22',
      pic: 'http://api.jisuapi.com/astro/static/images/shizi.png');

  static Horoscope chunv = Horoscope(
      astroid: 6,
      astroname: '处女座',
      date: '8-23~9-22',
      pic: 'http://api.jisuapi.com/astro/static/images/chunv.png');

  static Horoscope tiancheng = Horoscope(
      astroid: 7,
      astroname: '天秤座',
      date: '9-23~10-23',
      pic: 'http://api.jisuapi.com/astro/static/images/tianping.png');

  static Horoscope tianxie = Horoscope(
      astroid: 8,
      astroname: '天蝎座',
      date: '10-24~11-22',
      pic: 'http://api.jisuapi.com/astro/static/images/tianxie.png');

  static Horoscope sheshou = Horoscope(
      astroid: 9,
      astroname: '射手座',
      date: '11-23~12-21',
      pic: 'http://api.jisuapi.com/astro/static/images/sheshou.png');

  static Horoscope mojie = Horoscope(
      astroid: 10,
      astroname: '摩羯座',
      date: '12-22~1-19',
      pic: 'http://api.jisuapi.com/astro/static/images/mojie.png');

  static Horoscope shuiping = Horoscope(
      astroid: 11,
      astroname: '水瓶座',
      date: '1-20~2-18',
      pic: 'http://api.jisuapi.com/astro/static/images/shuiping.png');

  static Horoscope shuangyu = Horoscope(
      astroid: 12,
      astroname: '双鱼座',
      date: '2-19~3-20',
      pic: 'http://api.jisuapi.com/astro/static/images/shuangyu.png');
}
