import 'dart:convert';
// import 'dart:io';

import 'package:http/http.dart' as http;

const String baseUrl = 'https://631c37911b470e0e12fcdd0b.mockapi.io/api';

class HubspotClient {
  var client = http.Client();

  //GET Function
  Future<dynamic> getName(String api) async {
    var url = Uri.parse(baseUrl + api);

    var requestHeaders = {
      'Authorization': 'Bearer sfie328370428387=',
      'api_key': 'ief873fj38uf38uf83u839898989',
    };

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }

  //POST Function
  Future<dynamic> createCustomer(
      String apiEndpoint, dynamic customerData) async {
    //
    var url = Uri.parse("https://google.com$apiEndpoint");

    var headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'api_key': 'ief873fj38uf38uf83u839898989',
      'ContentType': 'Application/json',
    };

    var jsonData = jsonEncode(customerData);

    var response = await client.post(url, body: jsonData, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      //Throw error
    }
  }
}
