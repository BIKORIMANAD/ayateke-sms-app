import 'dart:io';

import 'package:AyatekeApp/providers/domain/request_model.dart';
import 'package:http/http.dart' as http;

String baseUrl = 'http://192.168.43.70/ayatekestar-sms/public/api/v1/Api';
Future<List<Post>> getRequest(String token) async {
  // something here
  
  print("Before Sending the request: " + token);
  final response = await http.get('$baseUrl/request', headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token
  });
  print(response.body);
  return postFromJson(response.body);
  
}

Future<http.Response> createPost(Post post) async {
  final response = await http.post('$baseUrl/fund',
      headers: {"content-type": "application/json"}, body: postToJson(post));
  return response;
}

// update
Future<http.Response> updatePost(Post post) async {
  final response = await http.put('$baseUrl/fund/${post.id}',
      headers: {"content-type": "application/json"}, body: postToJson(post));
  return response;
}

// delete
Future<http.Response> deletePost(int id) async {
  final response = await http.delete('$baseUrl/fund/$id}',
      headers: {"content-type": "application/json"});
  return response;
}
