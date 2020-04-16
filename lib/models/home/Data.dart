
import 'Article.dart';
import 'Index.dart';

class Data {
    List<Article> article;
    Index index;

    Data({this.article, this.index});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            article: json['article'] != null ? (json['article'] as List).map((i) => Article.fromJson(i)).toList() : null, 
            index: json['index'] != null ? Index.fromJson(json['index']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.article != null) {
            data['article'] = this.article.map((v) => v.toJson()).toList();
        }
        if (this.index != null) {
            data['index'] = this.index.toJson();
        }
        return data;
    }
}