import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/model/coin.dart';

class CoinApiService {
  final String _url = 'http://localhost:8080/proxy';

  Future<List<Coin>> fetchCoins() async {
    final response = await http.get(
      Uri.parse(_url),
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
