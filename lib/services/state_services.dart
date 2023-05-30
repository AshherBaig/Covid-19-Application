import 'dart:convert';

import 'package:covid_19/methods/WorldStatesModel.dart';
import 'package:covid_19/services/utilities/app_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class StateServices{

  Future<WorldStatesModel> fetchWorldStateRecords() async{
    final response = await http.get(Uri.parse(ApiUrl.worldStateApi));

    // debugPrint("Here is status code"+ response.statusCode.toString());

    if (response.statusCode == 200)
      {
        var data = jsonDecode(response.body);
        return WorldStatesModel.fromJson(data);
      }
    else{
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    // var data;
    final response = await http.get(Uri.parse(ApiUrl.countriesList));

    if(response.statusCode == 200)
      {
        var data = jsonDecode(response.body);
        return data;
        // return WorldStatesModel.fromJson(data);
      }
    else{
      throw Exception("Error");
    }

  }

}