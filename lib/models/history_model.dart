import 'dart:convert';

class Post {
  int id;
  String name;
  int totalAmount;

  Post({this.id, this.name, this.totalAmount,});
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      name: json['name'],
      totalAmount: json['total_amount'],
    );
  }
  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "comment": totalAmount};
  }

  @override
  String toString() {
    return 'Post{id:$id,name:$name,comment:$totalAmount}';
  }
}

List<Post> postFromJson(String strJson) {
  final str = json.decode(strJson);
  // print(str);
  return List<Post>.from(str.map((item) {
    return Post.fromJson(item);
  }));
}

String postToJson(Post data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
