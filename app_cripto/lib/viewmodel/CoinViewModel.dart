import 'package:flutter/foundation.dart';
import '../data/model/coin.dart';
import '../services/CoinApiService.dart';

class CoinViewModel extends ChangeNotifier {
  final CoinApiService _apiService = CoinApiService();

  List<Coin> _coins = [];
  bool _loading = false;

  List<Coin> get coins => _coins;
  bool get loading => _loading;

  Future<void> fetchCoins() async {
    _loading = true;
    notifyListeners();

    try {
      _coins = await _apiService.fetchCoins();
    } catch (e) {
      print('Erro: $e');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
