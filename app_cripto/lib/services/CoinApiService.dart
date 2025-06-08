import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/model/coin.dart';

class CoinApiService {
  final String _apiKey = 'SUA_CHAVE_API_COINMARKETCAP';
  final String _url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest';

  Future<List<Coin>> fetchCoins() async {
    final response = await http.get(
      Uri.parse(_url),
      headers: {
        'X-CMC_PRO_API_KEY': _apiKey,
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List coinsJson = data['data'];
      return coinsJson.map((json) => Coin.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar moedas');
    }
  }
}
