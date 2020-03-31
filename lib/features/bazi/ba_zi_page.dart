import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_website/conf/config.dart';
import 'package:flutter_website/conf/routers.dart';
import 'package:flutter_website/utils/utils.dart';

class BaZiPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BaZiPageState();
  }
}

class BaZiPageState extends State<BaZiPage> {
  TextEditingController _nameCtr = TextEditingController();
  bool _isMale = true;
  bool _isChineseCalendar = false;
  static DateTime _initialDate = DateTime(1990, 1, 1);
  FocusNode _defaultNode = FocusNode();

  DateTime _birthTime = _initialDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _defaultNode.unfocus(),
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: ListView(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('姓名：'),
                  Expanded(
                      child: TextField(
                    focusNode: _defaultNode,
                    decoration: InputDecoration(
                      hintText: '输入姓名',
                    ),
                    controller: _nameCtr,
                    keyboardType: TextInputType.text,
                    maxLength: 5,
                  )),
                  SizedBox(width: 40),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('性别：'),
                  Radio<bool>(
                    value: true,
                    groupValue: _isMale,
                    onChanged: (value) {
                      setState(() {
                        _isMale = value;
                      });
                    },
                  ),
                  const Text('男'),
                  Radio<bool>(
                    value: false,
                    groupValue: _isMale,
                    onChanged: (value) {
                      setState(() {
                        _isMale = value;
                      });
                    },
                  ),
                  const Text('女'),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('日期类型：'),
                  Radio<bool>(
                    value: false,
                    groupValue: _isChineseCalendar,
                    onChanged: (value) {
                      setState(() {
                        _isChineseCalendar = value;
                      });
                    },
                  ),
                  const Text('阳历'),
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 80,
                    child: FlatButton(
                      color: AppConfig.theme.primaryColor,
                      highlightColor: AppConfig.theme.primaryColor,
                      colorBrightness: Brightness.dark,
                      splashColor: Colors.grey,
                      child: Text("转阳历"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0)),
                      onPressed: () {
                        String url = 'http://tool.ckd.cc/calendar/';
                        AppRouters.navigateTo(context, AppRouters.WEBVIEW,
                            params: {'url': url});
                      },
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  const Text('出生年月：'),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller:
                          TextEditingController(text: _getFormatDate(true)),
                      readOnly: true,
                      onTap: _showDatePop,
                      decoration: InputDecoration(
                        hintText: '选择出生年月',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: _showDatePop,
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  const Text('出生时间：'),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller:
                          TextEditingController(text: _getFormatDate(false)),
                      readOnly: true,
                      onTap: _showTimePop,
                      decoration: InputDecoration(
                        hintText: '选择出生时间 ',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: _showTimePop,
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
              SizedBox(height: 40),
              Container(
                  child: FlatButton(
                color: AppConfig.theme.primaryColor,
                highlightColor: AppConfig.theme.primaryColor,
                colorBrightness: Brightness.dark,
                splashColor: Colors.grey,
                child: Text("八字排盘"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9.0)),
                onPressed: () async {
                  if (_nameCtr.text == null || _nameCtr.text.trim().isEmpty) {
                    Tool.toast('姓名不能为空!');
                    return;
                  }
                  var confirmed = await _showConfirmPop();
                  if (confirmed != null && confirmed) {
                    String name = _nameCtr.text.trim();
                    AppRouters.navigateTo(context, AppRouters.BAZI_DETAIL_PAGE,
                        params: {
                          'name': name,
                          'birthtime': _birthTime.millisecondsSinceEpoch,
                          'isMale': _isMale,
                          'isChineseCalendar': _isChineseCalendar,
                        });
                  }
                },
              )),
            ],
          ),
        ));
  }

  String _getFormatDate(bool isDate) {
    return isDate
        ? '${_isChineseCalendar ? '农历' : '阳历'} '
            '${formatDate(_birthTime, ['yyyy', '年', 'mm', '月', 'dd', '日'])}'
        : formatDate(_birthTime, ['HH', '时', 'nn', '分', 'ss', '秒']);
  }

  void _showDatePop() {
    DatePicker.showDatePicker(context,
        minTime: DateTime(1920, 1, 1),
        maxTime: DateTime(2070, 1, 1),
        onChanged: (date) {}, onConfirm: (date) {
      if (!mounted) return;
      setState(() => _birthTime = date);
    }, currentTime: _birthTime, locale: LocaleType.zh);
  }

  void _showTimePop() {
    DatePicker.showTimePicker(context, currentTime: _birthTime,
        onConfirm: (date) {
      if (!mounted) return;
      setState(() => _birthTime = date);
    }, locale: LocaleType.zh);
  }

  Future<bool> _showConfirmPop() {
    return showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("确认信息无误"),
              content: Text(
                  "姓名：${_nameCtr.text.trim()}\n性别：${_isMale ? '男' : '女'}\n生日：${_getFormatDate(true)}  ${_getFormatDate(false)}"),
              actions: <Widget>[
                FlatButton(
                  child: Text("排盘"),
                  onPressed: () {
                    //关闭对话框并返回true
                    Navigator.of(context).pop(true);
                  },
                ),
                FlatButton(
                  child: Text("取消"),
                  onPressed: () => Navigator.of(context).pop(), // 关闭对话框
                ),
              ],
            ));
  }
}
