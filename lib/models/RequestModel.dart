import 'dart:convert';

class RequestModel{
  int id,requestId, detailId, price;
  String servedBy, createdBy;
  double quantity;

  RequestModel({this.id, this.requestId, this.detailId, this.price, this.servedBy, this.createdBy, this.quantity});

  factory RequestModel.fromJson(Map<String, dynamic> json){
        return RequestModel(
            id: json['id'] as int,
            requestId: json['requestId'] as int,
            detailId: json['detailId'] as int,
            price: json['price'] as int,
            servedBy: json['servedBy'] as String,
            createdBy: json['createdBy'] as String,
            quantity: json['quantity'] as double
        );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, 
      "requestId": requestId, 
      "detailId": detailId, 
      "price": price, 
      "servedBy": servedBy, 
      "createdBy": createdBy, 
      "quantity": quantity
    };
  }

  static String requestToJson(RequestModel data) {
    final dyn = data.toJson();
    return json.encode(dyn);
  }
}