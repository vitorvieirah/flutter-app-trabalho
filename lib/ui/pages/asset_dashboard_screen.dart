import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:api_market_cap_coin/ui/view_models/digital_asset_controller.dart';
import 'package:api_market_cap_coin/domain/entities/digital_asset_model.dart';

class AssetDashboardScreen extends StatefulWidget {
  const AssetDashboardScreen({super.key});

  @override
  State<AssetDashboardScreen> createState() => _AssetDashboardScreenState();
}

class _AssetDashboardScreenState extends State<AssetDashboardScreen> {
  final TextEditingController _filterController = TextEditingController();
  final NumberFormat _dollarFormatter = NumberFormat.currency(locale: 'en_US', symbol: '\$ ');
  final NumberFormat _realFormatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$ ');

  @override
  void initState() {
    super.initState();
    // Carrega dados iniciais quando o widget é inicializado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DigitalAssetController>(context, listen: false).loadDigitalAssets();
    });
  }

  void _displayAssetDetails(BuildContext context, DigitalAssetModel asset) {
    final dollarValue = asset.priceData['USD']?.currentPrice ?? 0.0;
    final realValue = asset.priceData['BRL']?.currentPrice ?? 0.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.teal[100],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    asset.ticker.substring(0, asset.ticker.length > 2 ? 2 : asset.ticker.length),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[800],
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      asset.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      asset.ticker,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                _createInfoRow(
                  icon: Icons.access_time,
                  label: 'Data de Criação',
                  value: DateFormat.yMd().add_jms().format(asset.creationDate.toLocal()),
                ),
                const SizedBox(height: 20),
                _createInfoRow(
                  icon: Icons.monetization_on,
                  label: 'Preço (USD)',
                  value: _dollarFormatter.format(dollarValue),
                  valueColor: Colors.green[700],
                ),
                const SizedBox(height: 20),
                _createInfoRow(
                  icon: Icons.attach_money,
                  label: 'Preço (BRL)',
                  value: _realFormatter.format(realValue),
                  valueColor: Colors.blue[700],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey[700],
              ),
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _createInfoRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 22,
          color: Colors.grey[700],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: TextStyle(
                  color: valueColor ?? Colors.grey[900],
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

 @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DigitalAssetController>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Painel de Ativos Digitais',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.teal[700],
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _filterController,
                decoration: InputDecoration(
                  labelText: 'Filtrar Símbolos (ex: BTC, ETH)',
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  prefixIcon: Icon(Icons.filter_list, color: Colors.teal[700]),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: Colors.teal[700]),
                    onPressed: () {
                      controller.loadDigitalAssets(tickerSymbols: _filterController.text);
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.teal[700]!, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                onSubmitted: (value) {
                  controller.loadDigitalAssets(tickerSymbols: value);
                },
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => controller.loadDigitalAssets(tickerSymbols: _filterController.text.isEmpty ? null : _filterController.text),
              color: Colors.teal[700],
              child: _buildAssetGrid(controller),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssetGrid(DigitalAssetController controller) {
    if (controller.currentState == ScreenState.processing && controller.digitalAssets.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.teal[700]!),
            ),
            const SizedBox(height: 20),
            Text(
              'Carregando ativos digitais...',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 18,
              ),
            ),
          ],
        ),
      );
    }
    if (controller.currentState == ScreenState.failed) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning_amber_outlined,
                size: 70,
                color: Colors.orange[500],
              ),
              const SizedBox(height: 20),
              Text(
                'Ops! Algo deu errado',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Falha ao carregar dados: ${controller.failureMessage}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      );
    }
    if (controller.digitalAssets.isEmpty && controller.currentState == ScreenState.completed) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_outlined,
              size: 70,
              color: Colors.grey[500],
            ),
            const SizedBox(height: 20),
            Text(
              'Nenhum ativo digital encontrado',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Tente buscar por símbolos diferentes',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }
    if (controller.digitalAssets.isEmpty && controller.currentState == ScreenState.processing) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.teal[700]!),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: controller.digitalAssets.length,
      itemBuilder: (context, index) {
        final asset = controller.digitalAssets[index];
        final dollarValue = asset.priceData['USD']?.currentPrice ?? 0.0;
        final realValue = asset.priceData['BRL']?.currentPrice ?? 0.0;

        return GestureDetector(
          onTap: () => _displayAssetDetails(context, asset),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  spreadRadius: 2,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.teal[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            asset.ticker.substring(0, asset.ticker.length > 2 ? 2 : asset.ticker.length),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.teal[800],
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          asset.ticker,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    asset.title,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _dollarFormatter.format(dollarValue),
                        style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _realFormatter.format(realValue),
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: Colors.grey[500],
                        size: 18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }
}