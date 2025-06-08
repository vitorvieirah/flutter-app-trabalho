import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:api_market_cap_coin/core/service/network_client.dart';
import 'package:api_market_cap_coin/data/datasources/digital_asset_remote_source.dart';
import 'package:api_market_cap_coin/data/repositories/digital_asset_repository.dart';
import 'package:api_market_cap_coin/domain/repositories/i_digital_asset_repository.dart';
import 'package:api_market_cap_coin/ui/view_models/digital_asset_controller.dart';
import 'package:api_market_cap_coin/ui/pages/asset_dashboard_screen.dart';


void main() async {
 
  runApp(const DigitalAssetApp());
}

class DigitalAssetApp extends StatelessWidget {
  const DigitalAssetApp({super.key});

  @override
  Widget build(BuildContext context) {
   
    final NetworkClient networkClient = NetworkClient();
    final IDigitalAssetRemoteSource remoteSource = DigitalAssetRemoteSource(networkClient);
    final IDigitalAssetRepository assetRepository = DigitalAssetRepository(remoteSource);

    return ChangeNotifierProvider(
      create: (context) => DigitalAssetController(assetRepository),
      child: MaterialApp(
        title: 'Painel de Ativos Digitais',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.teal[600],
            foregroundColor: Colors.white,
            elevation: 6,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal, width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          dialogTheme: DialogThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0)
            )
          )
        ),
        home: const AssetDashboardScreen(),
      ),
    );
  }
}
