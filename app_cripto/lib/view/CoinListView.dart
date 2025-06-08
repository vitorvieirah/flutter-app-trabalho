import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/CoinViewModel.dart';
import 'package:intl/intl.dart';

class CoinListView extends StatelessWidget {
  final currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$');

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CoinViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Criptomoedas')),
      body: viewModel.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: viewModel.coins.length,
        itemBuilder: (context, index) {
          final coin = viewModel.coins[index];
          return ListTile(
            title: Text('${coin.name} (${coin.symbol})'),
            subtitle: Text(currencyFormat.format(coin.price)),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => viewModel.fetchCoins(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
