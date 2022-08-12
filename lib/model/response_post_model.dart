import 'dart:convert';

ResponsePost responseRequestFromJson(String str) =>
    ResponsePost.fromJson(json.decode(str));

String responseRequestToJson(ResponsePost data) => json.encode(data.toJson());

class ResponsePost {
  bool? success;
  String? data;
  // int lastId;

  ResponsePost({this.success, this.data});

  factory ResponsePost.fromJson(Map<String, dynamic> json) =>
      ResponsePost(success: json["success"], data: json["data"]);

  Map<String, dynamic> toJson() => {"successs": success, "data": data};
}
