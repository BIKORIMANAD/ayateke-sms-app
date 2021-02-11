import 'dart:convert';

class ProfileModel{
  int id, request, totalAmount, totalPending;
  String name, password, newPassword, confirmPassword;

  ProfileModel({this.id, this.totalAmount, this.totalPending, this.name, this.request, this.password, this.newPassword, this.confirmPassword});

  factory ProfileModel.fromJson(Map<String, dynamic> json){
        return ProfileModel(
            id: json['id'] as int,
            name: json['name'] as String,
            request: json['request'] as int,
            totalAmount: json['total_amount'] as int,
            totalPending: json['total_pending'] as int
        );
    }
  Map<String, dynamic> toJson() {
    return {"id": id, 
      "old_password": password,
      "new_password": newPassword, 
      "confirm_password": confirmPassword,
    };
  }

  static String requestToJson(ProfileModel data) {
    final dyn = data.toJson();
    return json.encode(dyn);
  }
}