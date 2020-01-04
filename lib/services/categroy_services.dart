import 'dart:async' show Future;
import 'package:amit_poc_flutter/model/category_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

Future<String> _readCategory() async{
  return await rootBundle.loadString('assets/category.json');
}


Future<Categories> loadCategory() async{
  print("Calling json back ");
  String jsonCategory = await _readCategory();
  print("Got json back ");
  final jsonResponse = json.decode(jsonCategory);
  return  Categories.fromJson(jsonResponse['body']);

}
