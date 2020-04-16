class Banner {
  String cesuan_type;
  String icon;
  String title;
  String type;

  Banner({this.cesuan_type, this.icon, this.title, this.type});

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      cesuan_type: json['cesuan_type'],
      icon: json['icon'],
      title: json['title'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cesuan_type'] = this.cesuan_type;
    data['icon'] = this.icon;
    data['title'] = this.title;
    data['type'] = this.type;
    return data;
  }
}
