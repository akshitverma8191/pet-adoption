

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:petadoption/data/data_manager.dart';

class AssetDataSource implements DataSource{

  String assetPath;

  AssetDataSource(this.assetPath);

  @override
  Future getData() async {
    String jsonString = await rootBundle.loadString(assetPath);
    final data = jsonDecode(jsonString);
    return data;
  }

}