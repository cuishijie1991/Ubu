
class Vip {
    String finalprice;
    String img;
    String info;
    String name;
    String price;
    String productid;
    String title;
    String type;

    Vip({this.finalprice, this.img, this.info, this.name, this.price, this.productid, this.title, this.type});

    factory Vip.fromJson(Map<String, dynamic> json) {
        return Vip(
            finalprice: json['finalprice'], 
            img: json['img'], 
            info: json['info'], 
            name: json['name'], 
            price: json['price'], 
            productid: json['productid'], 
            title: json['title'], 
            type: json['type'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['finalprice'] = this.finalprice;
        data['img'] = this.img;
        data['info'] = this.info;
        data['name'] = this.name;
        data['price'] = this.price;
        data['productid'] = this.productid;
        data['title'] = this.title;
        data['type'] = this.type;
        return data;
    }
}