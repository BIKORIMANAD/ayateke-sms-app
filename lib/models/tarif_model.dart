class TarifModel{
  int id;
  String name;
  int price;

  TarifModel({this.id, this.name, this.price});

  factory TarifModel.fromJson(Map<String, dynamic> json){
        return TarifModel(
            id: json['id'] as int,
            name: json['name'] as String,
            price: json['selling_rice']
        );
    }
}