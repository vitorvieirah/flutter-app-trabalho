import 'package:api_market_cap_coin/data/datasources/digital_asset_remote_source.dart';
import 'package:api_market_cap_coin/domain/entities/digital_asset_model.dart';
import 'package:api_market_cap_coin/domain/repositories/i_digital_asset_repository.dart';

class DigitalAssetRepository implements IDigitalAssetRepository {
  final IDigitalAssetRemoteSource _remoteSource;

  DigitalAssetRepository(this._remoteSource);

  @override
  Future<List<DigitalAssetModel>> retrieveDigitalAssets(String tickerSymbols) async {
    print('DigitalAssetRepository: obtendo ativos digitais para símbolos: $tickerSymbols');
    try {
      final result = await _remoteSource.retrieveDigitalAssets(tickerSymbols);
      print('DigitalAssetRepository: recebidos ${result.length} ativos da fonte de dados.');
      return result;
    } catch (e) {
      print('DigitalAssetRepository: Erro ao buscar ativos digitais: $e');
     
      rethrow;
    }
  }
}