import 'dart:math';
import '../models/wallet_data.dart';

class WalletService {
  static final Random _random = Random();
  
  static const List<String> _tokenNames = [
    'BONK', 'WIF', 'PEPE', 'SHIB', 'FLOKI', 'DOGE', 'SAMO', 'RAY', 'SRM', 'FTT'
  ];
  
  static const List<String> _tokenSymbols = [
    'BONK', 'WIF', 'PEPE', 'SHIB', 'FLOKI', 'DOGE', 'SAMO', 'RAY', 'SRM', 'FTT'
  ];
  
  static const List<String> _avatarUrls = [
    'https://via.placeholder.com/40/FF6B6B/FFFFFF?text=B',
    'https://via.placeholder.com/40/4ECDC4/FFFFFF?text=W', 
    'https://via.placeholder.com/40/45B7D1/FFFFFF?text=P',
    'https://via.placeholder.com/40/96CEB4/FFFFFF?text=S',
    'https://via.placeholder.com/40/FFEAA7/000000?text=F',
    'https://via.placeholder.com/40/DDA0DD/FFFFFF?text=D',
    'https://via.placeholder.com/40/F39C12/FFFFFF?text=SA',
    'https://via.placeholder.com/40/E74C3C/FFFFFF?text=R',
    'https://via.placeholder.com/40/9B59B6/FFFFFF?text=SR',
    'https://via.placeholder.com/40/3498DB/FFFFFF?text=FT',
  ];

  // 生成模拟钱包数据
  static WalletData generateWalletData() {
    final fullAddress = _generateFullAddress();
    final shortAddress = _generateShortAddress(fullAddress);
    
    final tokens = _generateWalletTokens();
    final totalValue = tokens.fold(0.0, (sum, token) => sum + token.value);
    
    return WalletData(
      address: fullAddress,
      shortAddress: shortAddress,
      totalBalance: totalValue,
      realizedPnL: _random.nextDouble() * 1000 - 500, // -500 到 +500
      unrealizedProfits: _random.nextDouble() * 200 - 100, // -100 到 +100
      winRate: _random.nextDouble() * 100, // 0-100%
      tokens: tokens,
    );
  }

  // 生成钱包中的代币列表
  static List<WalletToken> _generateWalletTokens() {
    final tokenCount = 3 + _random.nextInt(5); // 3-7个代币
    return List.generate(tokenCount, (index) {
      final tokenIndex = _random.nextInt(_tokenNames.length);
      return WalletToken(
        name: _tokenNames[tokenIndex],
        symbol: _tokenSymbols[tokenIndex],
        amount: _random.nextDouble() * 10000 + 100, // 100-10100
        value: _random.nextDouble() * 500 + 10, // 10-510 USD
        changePercent: (_random.nextDouble() - 0.5) * 100, // -50% 到 +50%
        avatarUrl: _avatarUrls[tokenIndex],
      );
    });
  }

  // 生成Phishing检查结果
  static List<PhishingCheck> generatePhishingChecks() {
    return [
      PhishingCheck(
        title: 'Blacklist',
        isGood: _random.nextBool(),
        description: '--',
      ),
      PhishingCheck(
        title: "Didn't buy",
        isGood: _random.nextBool(),
        description: '--',
      ),
      PhishingCheck(
        title: 'Sold > Bought',
        isGood: _random.nextBool(),
        description: '--',
      ),
      PhishingCheck(
        title: 'Buy/Sell within 5 secs',
        isGood: _random.nextBool(),
        description: '--',
      ),
    ];
  }

  // 生成完整地址（44字符）
  static String _generateFullAddress() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    return String.fromCharCodes(Iterable.generate(
        44, (_) => chars.codeUnitAt(_random.nextInt(chars.length))));
  }

  // 生成简短地址显示
  static String _generateShortAddress(String fullAddress) {
    if (fullAddress.length < 8) return fullAddress;
    return '${fullAddress.substring(0, 5)}...${fullAddress.substring(fullAddress.length - 3)}';
  }
} 