import 'package:commerce/model/ErrorResponse.dart';
import 'package:commerce/model/User.dart';
import 'package:commerce/model/cartResponse.dart';
import 'package:commerce/model/categoryResponse.dart';
import 'package:commerce/model/productResponse.dart';
import 'package:commerce/network/urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'as convert;

class ServiceApi{
  static int statusCode = 0;
  ServiceApi._();
  static final ServiceApi instance = ServiceApi._();

  Future<String> register(User user) async {
    http.Response res = await http.post(Uri.parse(REGISTER_URL),body:convert.jsonEncode(user),headers: {"Content-Type":"application/json"});
    statusCode=res.statusCode;
    if(res.statusCode==201){
      return convert.jsonDecode(res.body)["token"];
    }else{
      ErrorResponse errorResponse = ErrorResponse.fromJson(convert.jsonDecode(res.body));
      return errorResponse.message;
    }
  }
  Future<String> login(User user) async{
    http.Response res = await http.post(Uri.parse(LOGIN_URL),
        body: convert.jsonEncode(user),headers: {"Content-Type":"application/json"});
    statusCode=res.statusCode;
    if(res.statusCode==200){
      return convert.jsonDecode(res.body)["token"];
    }else{
      return convert.jsonDecode(res.body)["error"];
    }
  }

  Future<ProductResponse> getProducts()async{
    http.Response res = await http.get(Uri.parse(GET_PRODUCT_URL));
    statusCode=res.statusCode;
    if(res.statusCode==200){
      return ProductResponse.fromJson(convert.jsonDecode(res.body));
    }else {
      return convert.jsonDecode(res.body)["massage"];
    }
  }

  Future <CategoryResponse> getCategories()async{
    http.Response res = await http.get(Uri.parse(GET_CATEGORIES_URL));
    statusCode = res.statusCode;
    if (res.statusCode == 200) {
      return CategoryResponse.fromJson(convert.jsonDecode(res.body));
    } else {
      return convert.jsonDecode(res.body)["massage"];
    }
  }

  Future <CartResponse> getCart(String token) async{
    http.Response res = await http.get(Uri.parse(CART_URL),
        headers: {'Authorization':'Bearer $token'});
    statusCode = res.statusCode;
    if(res.statusCode==200){
      return CartResponse.fromJson(convert.jsonDecode(res.body));
    }else {
      return convert.jsonDecode(res.body)["message"];
    }
  }

  Future <String> addToCart({String token ,String productId,int amount}) async{
    http.Response res = await http.put(Uri.parse(getAddToCartUrl(productId: productId)),
        headers: {'Authorization':'Bearer $token'},body: {
          "amount": "$amount"});
    statusCode = res.statusCode;
    return convert.jsonDecode(res.body)["message"];
  }
}