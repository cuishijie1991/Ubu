
class Tipinfo {
    String max;
    String time;

    Tipinfo({this.max, this.time});

    factory Tipinfo.fromJson(Map<String, dynamic> json) {
        return Tipinfo(
            max: json['max'], 
            time: json['time'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['max'] = this.max;
        data['time'] = this.time;
        return data;
    }
}