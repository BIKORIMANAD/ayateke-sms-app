class ProductModel{
  int id;
  String name;
  double quantity, price;

  ProductModel({this.id, this.name, this.quantity, this.price});

  factory ProductModel.fromJson(Map<String, dynamic> json){
        return ProductModel(
            id: json['id'] as int,
            name: json['name'] as String,
            quantity: json['quantity'] as double,
            price: json['price'] as double
        );
    }
}