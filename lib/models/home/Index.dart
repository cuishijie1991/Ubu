import 'Banner.dart';
import 'Listmenu.dart';
import 'Page.dart';
import 'Tipinfo.dart';
import 'Vip.dart';

class Index {
  List<Banner> banner;
  List<Listmenu> listmenu;
  List<Page> page;
  String pop;
  Tipinfo tipinfo;
  List<Vip> vip;
  String viptipmax;

  Index(
      {this.banner,
      this.listmenu,
      this.page,
      this.pop,
      this.tipinfo,
      this.vip,
      this.viptipmax});

  factory Index.fromJson(Map<String, dynamic> json) {
    return Index(
      banner: json['banner'] != null
          ? (json['banner'] as List).map((i) => Banner.fromJson(i)).toList()
          : null,
      listmenu: json['listmenu'] != null
          ? (json['listmenu'] as List).map((i) => Listmenu.fromJson(i)).toList()
          : null,
      page: json['page'] != null
          ? (json['page'] as List).map((i) => Page.fromJson(i)).toList()
          : null,
      pop: json['pop'],
      tipinfo:
          json['tipinfo'] != null ? Tipinfo.fromJson(json['tipinfo']) : null,
      vip: json['vip'] != null
          ? (json['vip'] as List).map((i) => Vip.fromJson(i)).toList()
          : null,
      viptipmax: json['viptipmax'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pop'] = this.pop;
    data['viptipmax'] = this.viptipmax;
    if (this.banner != null) {
      data['banner'] = this.banner.map((v) => v.toJson()).toList();
    }
    if (this.listmenu != null) {
      data['listmenu'] = this.listmenu.map((v) => v.toJson()).toList();
    }
    if (this.page != null) {
      data['page'] = this.page.map((v) => v.toJson()).toList();
    }
    if (this.tipinfo != null) {
      data['tipinfo'] = this.tipinfo.toJson();
    }
    if (this.vip != null) {
      data['vip'] = this.vip.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
