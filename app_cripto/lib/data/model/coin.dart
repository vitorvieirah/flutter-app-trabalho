class Coin {
  final String name;
  final String symbol;
  final double price;

  Coin({required this.name, required this.symbol, required this.price});

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      name: json['name'],
      symbol: json['symbol'],
      price: double.parse(json['quote']['USD']['price'].toString()),
    );
  }
}