import 'package:api_market_cap_coin/domain/entities/digital_asset_model.dart';

abstract class IDigitalAssetRepository {
  Future<List<DigitalAssetModel>> retrieveDigitalAssets(String tickerSymbols);
}