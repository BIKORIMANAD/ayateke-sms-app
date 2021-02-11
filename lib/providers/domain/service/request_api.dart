import 'dart:io';
import 'package:smsApp/providers/services.dart';
import 'package:smsApp/models/Pump.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:smsApp/models/ProductModel.dart';
import 'package:smsApp/models/RequestModel.dart';
import 'package:smsApp/models/ResponseModel.dart';
import 'package:smsApp/models/ProfileModel.dart';

String baseUrl = Services.url;
// Function to handle the user profile request
Future<ResponseModel> resetPassword(ProfileModel request, String token) async {
  String data = ProfileModel.requestToJson(request);
  //print(data);
  final response = await http.post('$baseUrl/auth/change-password',
      headers: {
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + token
      }, body: data);
  print(response.body);
  var result = json.decode(response.body);
  //print(result);
  ResponseModel resultData;
  try{
    resultData = ResponseModel(success: result['success'], message: result['message']);
  } catch(e){
    print(e);
  }
  print(resultData.message);
  print(resultData.success);
  return resultData;
}
Future<ProfileModel> requestProfile(String token) async{
  String url = baseUrl + "/user_profile";
  ProfileModel profile;
  //print(url);
  //Here send the get request to check for available stock
  final response = await http.get(url, headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token
  });
  //print(response.body);
  var data = json.decode(response.body);
  //print(data);
  try{
    if(!data['success']){
      profile = ProfileModel(
        name: "Not Found",
        request: 0,
        totalAmount: 0,
        totalPending: 0
      );
    } else {
      profile = ProfileModel(
        id: data['data']["id"],
        name: data['data']["name"],
        request: data['data']['request'],
        totalAmount: data['data']["total_amount"],
        totalPending: data['data']['total_pending'],
      );
    }
  } catch(e){
    print(e);
  }
  return profile;
}
// Function to handle Product Request operation
 
Future<ResponseModel> requestItem(RequestModel request, String token) async {
  String data = RequestModel.requestToJson(request);
  //print(data);
  final response = await http.post('$baseUrl/bar_command',
      headers: {
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + token
      }, body: data);
  //print(response.body);
  var result = json.decode(response.body);
  //print(result);
  ResponseModel resultData = ResponseModel(success: result['success'], message: result['message']);
  return resultData;
}

Future<List<ProductModel>> getProductInStock(String token) async{
  String url = baseUrl + "/bar_command";
  List<ProductModel> products = [];
  //print(url);
  //Here send the get request to check for available stock
  final response = await http.get(url, headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token
  });

  //Here decode the json information
  var data = json.decode(response.body);
  //print(data);
  try{
    for(var item in data){
      //print("OK Now creating some information");
      // print(item);
      ProductModel product = ProductModel(
        id: item["detail_id"], 
        name: item["detail"]["name"], 
        price: double.parse(item["detail"]["selling_rice"].toString()), 
        quantity: double.parse(item["quantity"].toString())
      );
      //print("Now the object created");
      products.add(product);
    }
  } catch(e){
    print(e);
  }
  // print("OK");
  //print(products);
  return products;
}

Future<List<Pump>> getPump(String token) async {
  // something here

  //print("Before Sending the request: " + token);
  String url = baseUrl + "/pump";
  print(url);
  final response = await http.get(url, headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token
  });
  print(response.body);
  return postFromJson(response.body);

}

Future<http.Response> createPost(Pump post, String token) async {
  String data = postToJson(post);
  //print(data);
  final response = await http.post('$baseUrl/bar_request',
      headers: {
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + token
      }, body: data);
  //print(response.body);
  return response;
}

// update
Future<http.Response> newRequest(Pump post, String token) async {
  final response = await http.put('$baseUrl/pump',
      headers: {
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + token
      }, body: postToJson(post));
  return response;
}

// delete
Future<http.Response> deletePost(int id, String token) async {

  final response = await http.delete('$baseUrl/bar_request/$id}',
      headers: {
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + token
      });
  //print(response.body);
  return response;
}