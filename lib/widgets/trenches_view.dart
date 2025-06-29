import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import '../models/token_data.dart';
import '../services/mock_data_service.dart';
import '../widgets/trenches_token_list_item.dart';
import '../widgets/filter_widgets.dart';

class TrenchesView extends StatefulWidget {
  const TrenchesView({super.key});

  @override
  State<TrenchesView> createState() => _TrenchesViewState();
}

class _TrenchesViewState extends State<TrenchesView> {
  String _selectedOptionKey = 'new_creations';
  List<TokenData> _tokenData = [];
  Timer? _timer;

  static const Map<String, Map<String, String>> _menuOptions = {
    'new_creations': {'icon': '🌱', 'text': 'New Creations'},
    'completing': {'icon': '🕒', 'text': 'Completing'},
    'completed': {'icon': '🐣', 'text': 'Completed'},
  };

  @override
  void initState() {
    super.initState();
    _generateMockData();
    // 每秒更新一次，处理倒计时和新代币
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTokenData();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _generateMockData() {
    setState(() {
      // 根据选择的菜单生成不同的数据
      if (_selectedOptionKey == 'completing') {
        _tokenData = MockDataService.generateCompletingTokens();
      } else if (_selectedOptionKey == 'completed') {
        _tokenData = MockDataService.generateCompletedTokens();
      } else {
        _tokenData = MockDataService.generateMockTokens();
      }
    });
  }

  void _updateTokenData() {
    setState(() {
      if (_selectedOptionKey == 'completing') {
        // Completing状态：代币不会自动移除，只是更新在线时间
        // 可以偶尔添加新的completing代币
        if (Random().nextInt(10) == 0) {
          _tokenData.insert(0, MockDataService.generateCompletingTokens(count: 1).first);
        }
      } else if (_selectedOptionKey == 'completed') {
        // Completed状态：代币不会自动移除，很少添加新代币
        // 这些是已经成功完成的代币，相对稳定
        if (Random().nextInt(20) == 0) {
          _tokenData.insert(0, MockDataService.generateCompletedTokens(count: 1).first);
        }
      } else {
        // New Creations状态：原有逻辑
        _tokenData.removeWhere((token) => token.shouldBeRemoved);
        
        if (Random().nextInt(4) == 0) {
          _tokenData.insert(0, MockDataService.generateNewToken());
        }
      }
      
      // 限制最大数量为10个
      if (_tokenData.length > 10) {
        _tokenData = _tokenData.take(10).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTrenchesFilterBar(),
        _buildNewCreationsFilterBar(),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            itemCount: _tokenData.length,
            itemBuilder: (context, index) {
              final token = _tokenData[index];
              return TrenchesTokenListItem(
                tokenName: token.tokenName,
                tokenFullName: token.tokenFullName,
                age: _selectedOptionKey == 'completing' || _selectedOptionKey == 'completed' 
                    ? token.formattedOnlineTime 
                    : token.formattedAge,
                contractAddress: token.contractAddress,
                fullContractAddress: token.fullContractAddress,
                stats: token.stats,
                tags: token.tags,
                volume: token.volume,
                marketCap: token.marketCap,
                avatarUrl: token.avatarUrl,
                progress: token.progress,
                isCompleting: _selectedOptionKey == 'completing',
                isCompleted: _selectedOptionKey == 'completed',
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTrenchesFilterBar() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.security, color: Colors.white, size: 24), // Helmet placeholder
              const SizedBox(width: 8),
              const Text('Trenches', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              const Icon(Icons.arrow_drop_down, color: Colors.white),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.view_list, color: Colors.white),
                  SizedBox(width: 16),
                  Icon(Icons.manage_search, color: Colors.white),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.account_balance_wallet_outlined, color: Colors.white, size: 16),
                        SizedBox(width: 8),
                        Text('1', style: TextStyle(color: Colors.white)),
                        Icon(Icons.arrow_drop_down, color: Colors.white, size: 20),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2E),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.greenAccent),
                    ),
                    child: const Text('TP/SL', style: TextStyle(color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNewCreationsFilterBar() {
    final selectedOption = _menuOptions[_selectedOptionKey]!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PopupMenuButton<String>(
            offset: const Offset(0, 40),
            onSelected: (String result) {
              setState(() {
                _selectedOptionKey = result;
                // 切换菜单时重新生成数据
                _generateMockData();
              });
            },
            color: const Color(0xFF2C2C2E),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            itemBuilder: (BuildContext context) {
              return _menuOptions.entries.map((entry) {
                return PopupMenuItem<String>(
                  value: entry.key,
                  child: Row(children: [Text(entry.value['icon']!), const SizedBox(width: 8), Text(entry.value['text']!)]),
                );
              }).toList();
            },
            child: Row(
              children: [
                Text(selectedOption['icon']!, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Text(selectedOption['text']!, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                const Icon(Icons.arrow_drop_down, color: Colors.white),
              ],
            ),
          ),
          Row(
            children: [
              FilterWidgets.filterChip(child: Row(children: [const Icon(Icons.layers, color: Colors.purpleAccent, size: 16), const SizedBox(width: 4), const Text('0', style: TextStyle(color: Colors.white))])),
              const SizedBox(width: 8),
              FilterWidgets.filterChip(child: const Row(children: [Text('P1'), Icon(Icons.arrow_drop_down)])),
              const SizedBox(width: 8),
              FilterWidgets.filterChip(child: const Row(children: [Icon(Icons.search), Text('Sear...')])),
              const SizedBox(width: 8),
              FilterWidgets.filterChip(icon: Icons.filter_alt_outlined),
            ],
          )
        ],
      ),
    );
  }
} 