import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api_market_cap_coin/configs/network_settings.dart';

enum RequestType { fetch, create, update, remove }

class NetworkClient {
  Future<dynamic> executeRequest({
    required String path,
    RequestType type = RequestType.fetch,
    Map<String, dynamic>? payload,
    Map<String, String>? additionalHeaders,
  }) async {
    final requestUrl = Uri.parse('${NetworkSettings.serverEndpoint}$path');
    final requestHeaders = {
      'Accepts': 'application/json',
      'X-CMC_PRO_API_KEY': NetworkSettings.authToken,
      ...?additionalHeaders, 
    };

    http.Response apiResponse;


    await Future.delayed(const Duration(seconds: 2));

    print('Request URL: $requestUrl');
    print('Request Method: $type');
    print('Request Headers: $requestHeaders');
    if (payload != null) {
      print('Request Body: ${jsonEncode(payload)}');
    }

    try {
      switch (type) {
        case RequestType.create:
          await Future.delayed(const Duration(seconds: 2));
          apiResponse = await http.post(requestUrl, headers: requestHeaders, body: jsonEncode(payload));
          break;
        case RequestType.update:
         await Future.delayed(const Duration(seconds: 2));
          apiResponse = await http.put(requestUrl, headers: requestHeaders, body: jsonEncode(payload));
          break;
        case RequestType.remove:
           await Future.delayed(const Duration(seconds: 2));
          apiResponse = await http.delete(requestUrl, headers: requestHeaders);
          break;
        case RequestType.fetch:
           await Future.delayed(const Duration(seconds: 2));
          apiResponse = await http.get(requestUrl, headers: requestHeaders);
          break;
      }

      print('Response Status Code: ${apiResponse.statusCode}');
      print('Response Body: ${apiResponse.body}');

      if (apiResponse.statusCode >= 200 && apiResponse.statusCode < 300) {
        return jsonDecode(apiResponse.body);
      } else {
        print('Error: ${apiResponse.statusCode} - ${apiResponse.reasonPhrase}');
        print('Error Body: ${apiResponse.body}');
        
        throw Exception('Falha ao carregar informações: ${apiResponse.statusCode}');
      }
    } catch (error, trace) {
      print('Exception during HTTP request: $error');
      print('Stack trace: $trace');
      if (error == null) {
        
        throw Exception('Requisição falhou com erro nulo. Pode ser um problema de rede ou CORS na web.');
      }
      
      throw Exception('Falha na requisição HTTP: $error');
    }
  }
}