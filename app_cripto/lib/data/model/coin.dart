class Coin {
  final int id;
  final String name;
  final String symbol;
  final int numMarketPairs;
  final DateTime dateAdded;
  final List<String> tags;
  final int? maxSupply;
  final int circulatingSupply;
  final int totalSupply;
  final bool infiniteSupply;
  final int cmcRank;
  final double price;

  Coin({
    required this.id,
    required this.name,
    required this.symbol,
    required this.numMarketPairs,
    required this.dateAdded,
    required this.tags,
    this.maxSupply,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.infiniteSupply,
    required this.cmcRank,
    required this.price,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    // Aqui a ideia é forçar o parse para int/double, mesmo que venha string
    int parseInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    double parseDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    return Coin(
      id: parseInt(json['id']),
      name: json['name'] ?? '',
      symbol: json['symbol'] ?? '',
      numMarketPairs: parseInt(json['num_market_pairs']),
      dateAdded: DateTime.parse(json['date_added']),
      tags: List<String>.from(json['tags'] ?? []),
      maxSupply: json['max_supply'] != null ? parseInt(json['max_supply']) : null,
      circulatingSupply: parseInt(json['circulating_supply']),
      totalSupply: parseInt(json['total_supply']),
      infiniteSupply: json['infinite_supply'] ?? false,
      cmcRank: parseInt(json['cmc_rank']),
      price: parseDouble(json['quote']['USD']['price']),
    );
  }
}