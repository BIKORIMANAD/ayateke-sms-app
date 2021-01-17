import 'dart:convert';
import 'dart:core';
class Post {
  int id;
  String name;
  String status;
  DateTime  datec;
  Post({this.id, this.name, this.status, this.datec});
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      datec: DateTime.parse(json['created_at'])
    );
  }
  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "status": status};
  }

  @override
  String toString() {
    return 'Post{id:$id,name:$name,status:$status}';
  }
}

List<Post> postFromJson(String strJson) {
  final str = json.decode(strJson);
  return List<Post>.from(str.map((item) {
    return Post.fromJson(item);
  }));
}

String postToJson(Post data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
