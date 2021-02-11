import 'dart:io';
import 'package:smsApp/models/detail_model.dart';
import 'package:smsApp/providers/services.dart';
import 'package:smsApp/models/history_model.dart';
import 'package:smsApp/models/tarif_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String baseUrl = Services.url;
Future<List<TarifModel>> getProductTarif(String token) async{
  String url = baseUrl + "/tarif";
  List<TarifModel> products = [];
  final response = await http.get(url, headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token
  });
  var data = json.decode(response.body);
  // print(data);
  try{
    for(var item in data){
      TarifModel product = TarifModel(
        id: item["id"],
        name: item["name"],
        price: item["selling_rice"]
      );
      products.add(product);
    }
  } catch(e){
    print(e);
  }
  return products;
}
Future<List<Post>> getRequest(String token) async {
  // something here

  // print("Before Sending the request: " + token);
  String url = baseUrl + "/history";
  // print(url);
  final response = await http.get(url, headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token
  });
  // print(response.body);
  return postFromJson(response.body);

}

Future<List<Details>> getHistoryIdBy(String token,int id) async {

  String url = '$baseUrl/history/$id}';
  // print(url);
  final response = await http.get(url, headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token
  });
  return detailsFromJson(response.body);
}

Future<http.Response> createPost(Post post, String token) async {
  String data = postToJson(post);
  //print(data);
  final response = await http.post('$baseUrl/history',
      headers: {
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + token
      }, body: data);
  print(response.body);
  return response;
}

// update
Future<http.Response> updatePost(Post post) async {
  final response = await http.put('$baseUrl/history/${post.id}',
      headers: {"content-type": "application/json"}, body: postToJson(post));
  return response;
}

// delete
Future<http.Response> deletePost(int id) async {
  final response = await http.delete('$baseUrl/history/$id}',
      headers: {"content-type": "application/json"});
  return response;
}