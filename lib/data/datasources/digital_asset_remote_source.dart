import 'package:api_market_cap_coin/core/service/network_client.dart';
import 'package:api_market_cap_coin/domain/entities/digital_asset_model.dart';

abstract class IDigitalAssetRemoteSource {
  Future<List<DigitalAssetModel>> retrieveDigitalAssets(String tickerSymbols);
}

class DigitalAssetRemoteSource implements IDigitalAssetRemoteSource {
  final NetworkClient _networkClient;

  DigitalAssetRemoteSource(this._networkClient);

  @override
  Future<List<DigitalAssetModel>> retrieveDigitalAssets(String tickerSymbols) async {
    print('Buscando ativos digitais para símbolos: $tickerSymbols');
    try {
      final apiResponse = await _networkClient.executeRequest(
        path: '/v2/cryptocurrency/quotes/latest?symbol=$tickerSymbols&convert=BRL',
      );

      print('Resposta bruta da API: $apiResponse');

      if (apiResponse != null && apiResponse['data'] != null) {
        final Map<String, dynamic> responseData = apiResponse['data'];
        final List<DigitalAssetModel> assetsList = [];
        responseData.forEach((key, value) {
          if (value is List) { 
            for (var item in value) {
              if (item is Map<String, dynamic>) {
                 try {
                    assetsList.add(DigitalAssetModel.fromJson(item));
                 } catch (e) {
                    print('Erro ao processar item para chave $key: $item. Erro: $e');
                 }
              }
            }
          } else if (value is Map<String, dynamic>) {
             try {
                assetsList.add(DigitalAssetModel.fromJson(value));
             } catch (e) {
                print('Erro ao processar valor para chave $key: $value. Erro: $e');
             }
          }
        });
        print('Processados ${assetsList.length} ativos digitais.');
        return assetsList;
      } else {
        print('Nenhum dado encontrado na resposta ou resposta é nula.');
        return [];
      }
    } catch (e) {
      print('Erro em DigitalAssetRemoteSource.retrieveDigitalAssets: $e');
      throw Exception('Falha ao buscar ativos digitais: $e');
    }
  }
}