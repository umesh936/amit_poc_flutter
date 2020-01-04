import 'dart:async' show Future;
import 'package:amit_poc_flutter/model/product_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

Future<String> _readProduct(categoryId) async{
  return await rootBundle.loadString('assets/product_'+categoryId+'.json');
}


Future<Products> loadProductForCategory(categoryId) async{
  String jsonCategory = await _readProduct(categoryId);
  final jsonResponse = json.decode(jsonCategory);
  return  Products.fromJson(jsonResponse['body']);

}
