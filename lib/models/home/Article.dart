class Article {
  String addtime;
  String content;
  String contentimage;
  String favor;
  String id;
  String readed;
  String subtitle;
  String title;
  String titleimage;
  String typename;
  String typetitle;
  String url;

  Article(
      {this.addtime,
      this.content,
      this.contentimage,
      this.favor,
      this.id,
      this.readed,
      this.subtitle,
      this.title,
      this.titleimage,
      this.typename,
      this.typetitle,
      this.url});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      addtime: json['addtime'],
      content: json['content'],
      contentimage: json['contentimage'],
      favor: json['favor'],
      id: json['id'],
      readed: json['readed'],
      subtitle: json['subtitle'],
      title: json['title'],
      titleimage: json['titleimage'],
      typename: json['typename'],
      typetitle: json['typetitle'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addtime'] = this.addtime;
    data['content'] = this.content;
    data['contentimage'] = this.contentimage;
    data['favor'] = this.favor;
    data['id'] = this.id;
    data['readed'] = this.readed;
    data['subtitle'] = this.subtitle;
    data['title'] = this.title;
    data['titleimage'] = this.titleimage;
    data['typename'] = this.typename;
    data['typetitle'] = this.typetitle;
    data['url'] = this.url;
    return data;
  }
}
