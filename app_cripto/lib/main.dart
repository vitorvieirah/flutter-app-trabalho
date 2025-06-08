import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './viewmodel/CoinViewModel.dart';
import './view/CoinListView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CoinViewModel(),
      child: MaterialApp(
        title: 'Crypto App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: CoinListView(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
