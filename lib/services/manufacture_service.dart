import 'dart:async' show Future;
import 'package:amit_poc_flutter/model/manufacturer_model.dart';
import 'package:amit_poc_flutter/model/product_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

Future<String> _readManufacture() async {
  return await rootBundle.loadString('assets/manufacturer.json');
}

Future<ManufacturerList> loadManufacture() async {
  String jsonCategory = await _readManufacture();
  final jsonResponse = json.decode(jsonCategory);
  return ManufacturerList.fromJson(jsonResponse['body']);
}
