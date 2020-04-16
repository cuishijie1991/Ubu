
class Page {
    String icon;
    String title;
    String type;
    String url;

    Page({this.icon, this.title, this.type, this.url});

    factory Page.fromJson(Map<String, dynamic> json) {
        return Page(
            icon: json['icon'], 
            title: json['title'], 
            type: json['type'], 
            url: json['url'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['icon'] = this.icon;
        data['title'] = this.title;
        data['type'] = this.type;
        data['url'] = this.url;
        return data;
    }
}