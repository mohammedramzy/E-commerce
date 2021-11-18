// To parse this JSON data, do
//
//     final errorResponse = errorResponseFromJson(jsonString);

import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) => ErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  ErrorResponse({
    this.message,
    this.errors,
  });

  String message;
  Errors errors;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
    message: json["message"]== null ? "" :json["message"],
    errors:json["errors"] == null ? Errors(): Errors.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors.toJson(),
  };
}

class Errors {
  Errors({
    this.email,
    this.password,
  });

  List<String> email;
  List<String> password;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    email: json["email"] == null ? <String>[] : List<String>.from(json["email"].map((x) => x)),
    password: json["password"] == null ? <String>[] : List<String>.from(json["password"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "email": List<dynamic>.from(email.map((x) => x)),
    "password": List<dynamic>.from(password.map((x) => x)),
  };
}
