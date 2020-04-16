
class Listmenu {
    String comment_key;
    String finalprice;
    String icon;
    String isshow;
    String price;
    String productid;
    String title;
    String type;
    String typename;
    String url;

    Listmenu({this.comment_key, this.finalprice, this.icon, this.isshow, this.price, this.productid, this.title, this.type, this.typename, this.url});

    factory Listmenu.fromJson(Map<String, dynamic> json) {
        return Listmenu(
            comment_key: json['comment_key'], 
            finalprice: json['finalprice'], 
            icon: json['icon'], 
            isshow: json['isshow'], 
            price: json['price'], 
            productid: json['productid'], 
            title: json['title'], 
            type: json['type'], 
            typename: json['typename'], 
            url: json['url'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['comment_key'] = this.comment_key;
        data['finalprice'] = this.finalprice;
        data['icon'] = this.icon;
        data['isshow'] = this.isshow;
        data['price'] = this.price;
        data['productid'] = this.productid;
        data['title'] = this.title;
        data['type'] = this.type;
        data['typename'] = this.typename;
        data['url'] = this.url;
        return data;
    }
}