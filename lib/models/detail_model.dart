import 'dart:convert';

class Details {
  //int id;
  String detailName;
  int totalAmount, qty, prc, subTotal;

  Details({this.detailName, this.totalAmount, this.qty,this.prc, this.subTotal });
  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      detailName: json['detailName'],
      totalAmount: json['totalAmount'],
      qty: json['qty'],
      prc: json['prc'],
      subTotal: json['subTotal'],
    );
  }
  Map<String, dynamic> toJson() {
    return { "detailName": detailName, "totalAmount": totalAmount, "qty":qty, "prc":prc, "subTotal":subTotal};
  }

}

List<Details> detailsFromJson(String strJson) {
  final str = json.decode(strJson);
  print(str);print("pnly GOD");
  return List<Details>.from(str.map((item) {
    return Details.fromJson(item);
  }));
}

String detailsToJson(Details data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
