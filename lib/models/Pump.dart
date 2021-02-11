import 'dart:convert';

class Pump {

  int id;
  String name;
  String line;
  String type;
  String qty;

  Pump({this.id, this.name, this.line,this.type, this.qty});
  factory Pump.fromJson(Map<String, dynamic> json) {
    return Pump(
      id: json['pump_id'],
      name: json['pump_name'],
      line: json['line_name'],
      type: json['pump_type'],
      qty: json['quantity'],
    );
  }
  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "line_name": line,"pump_type":type,"qty":qty};
  }

  @override
  String toString() {
    return 'Post{id:$id,name:$name,line_name:$line ,pump_type:$type,qty:$qty}';
  }
}

List<Pump> postFromJson(String strJson) {
  final str = json.decode(strJson);
  return List<Pump>.from(str.map((item) {
    return Pump.fromJson(item);
  }));
}

String postToJson(Pump data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
