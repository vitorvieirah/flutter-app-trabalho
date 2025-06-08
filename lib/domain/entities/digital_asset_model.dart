class DigitalAssetModel {
  final int identifier;
  final String title;
  final String ticker;
  final String urlSlug;
  final DateTime creationDate;
  final Map<String, PriceInfoModel> priceData;

  DigitalAssetModel({
    required this.identifier,
    required this.title,
    required this.ticker,
    required this.urlSlug,
    required this.creationDate,
    required this.priceData,
  });

  factory DigitalAssetModel.fromJson(Map<String, dynamic> json) {
    return DigitalAssetModel(
      identifier: json['id'] ?? 0,
      title: json['name'] ?? '',
      ticker: json['symbol'] ?? '',
      urlSlug: json['slug'] ?? '',
      creationDate: json['date_added'] != null
          ? DateTime.parse(json['date_added'])
          : DateTime.now(),
      priceData: (json['quote'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, PriceInfoModel.fromJson(value)),
          ) ??
          {},
    );
  }

  Map<String, dynamic> toJson() => {
    'id': identifier,
    'name': title,
    'symbol': ticker,
    'slug': urlSlug,
    'date_added': creationDate.toIso8601String(),
    'quote': priceData.map((key, value) => MapEntry(key, value.toJson())),
  };
}

class PriceInfoModel {
  final double currentPrice;
  final double dailyVolume;
  final double hourlyChange;
  final double dailyChange;
  final double weeklyChange;
  final double totalMarketValue;
  final DateTime lastRefresh;

  PriceInfoModel({
    required this.currentPrice,
    required this.dailyVolume,
    required this.hourlyChange,
    required this.dailyChange,
    required this.weeklyChange,
    required this.totalMarketValue,
    required this.lastRefresh,
  });

  factory PriceInfoModel.fromJson(Map<String, dynamic> json) {
    return PriceInfoModel(
      currentPrice: (json['price'] ?? 0.0).toDouble(),
      dailyVolume: (json['volume_24h'] ?? 0.0).toDouble(),
      hourlyChange: (json['percent_change_1h'] ?? 0.0).toDouble(),
      dailyChange: (json['percent_change_24h'] ?? 0.0).toDouble(),
      weeklyChange: (json['percent_change_7d'] ?? 0.0).toDouble(),
      totalMarketValue: (json['market_cap'] ?? 0.0).toDouble(),
      lastRefresh: json['last_updated'] != null
          ? DateTime.parse(json['last_updated'])
          : DateTime.now(),
    );
  }
   Map<String, dynamic> toJson() => {
    'price': currentPrice,
    'volume_24h': dailyVolume,
    'percent_change_1h': hourlyChange,
    'percent_change_24h': dailyChange,
    'percent_change_7d': weeklyChange,
    'market_cap': totalMarketValue,
    'last_updated': lastRefresh.toIso8601String(),
  };
}