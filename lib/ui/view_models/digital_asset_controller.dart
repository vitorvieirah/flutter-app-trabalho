import 'package:flutter/material.dart';
import 'package:api_market_cap_coin/domain/entities/digital_asset_model.dart';
import 'package:api_market_cap_coin/domain/repositories/i_digital_asset_repository.dart';
import 'package:api_market_cap_coin/core/library/app_defaults.dart';

enum ScreenState { inactive, processing, completed, failed }

class DigitalAssetController extends ChangeNotifier {
  final IDigitalAssetRepository _assetRepository;

  DigitalAssetController(this._assetRepository);

  List<DigitalAssetModel> _digitalAssets = [];
  List<DigitalAssetModel> get digitalAssets => _digitalAssets;

  ScreenState _currentState = ScreenState.inactive;
  ScreenState get currentState => _currentState;

  String _failureMessage = '';
  String get failureMessage => _failureMessage;

  Future<void> loadDigitalAssets({String? tickerSymbols}) async {
    _currentState = ScreenState.processing;
    notifyListeners();

    try {
      final symbolsToLoad = tickerSymbols == null || tickerSymbols.trim().isEmpty 
          ? AppDefaults.primaryCoinSymbols 
          : tickerSymbols.trim();
      
      print('DigitalAssetController: Carregando com símbolos: "$symbolsToLoad"');
      _digitalAssets = await _assetRepository.retrieveDigitalAssets(symbolsToLoad);
      _currentState = ScreenState.completed;
      print('DigitalAssetController: Carregados com sucesso ${_digitalAssets.length} ativos.');
    } catch (e) {
      _failureMessage = e.toString();
      _currentState = ScreenState.failed;
      print('DigitalAssetController: Erro ao carregar ativos: $_failureMessage');
    }
    notifyListeners();
  }
}