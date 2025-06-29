import 'dart:math';
import '../models/token_data.dart';

class MockDataService {
  static final Random _random = Random();
  
  static const List<String> _tokenNames = [
    'HACHI', 'POMPO', 'Solan', 'STICK', 'NI690', 'PEPE', 'DOGE', 'SHIB', 'FLOKI'
  ];
  
  static const List<String> _fullNames = [
    'HACHI', 'pompompurin', 'Solanhoe', 'STICKFIG', 'Nigga Index 6900', 
    'PepeCoin', 'DogeCoin', 'ShibaInu', 'FlokiInu'
  ];
  
  static const List<String> _avatarUrls = [
    'https://via.placeholder.com/50/FF6B6B/FFFFFF?text=H',
    'https://via.placeholder.com/50/4ECDC4/FFFFFF?text=P', 
    'https://via.placeholder.com/50/45B7D1/FFFFFF?text=S',
    'https://via.placeholder.com/50/96CEB4/FFFFFF?text=ST',
    'https://via.placeholder.com/50/FFEAA7/000000?text=N',
    'https://via.placeholder.com/50/DDA0DD/FFFFFF?text=PE',
    'https://via.placeholder.com/50/F39C12/FFFFFF?text=D',
    'https://via.placeholder.com/50/E74C3C/FFFFFF?text=SH',
    'https://via.placeholder.com/50/9B59B6/FFFFFF?text=F',
  ];

  static List<TokenData> generateMockTokens({int count = 6}) {
    return List.generate(count, (index) {
      final nameIndex = _random.nextInt(_tokenNames.length);
      final now = DateTime.now();
      final fullAddress = _generateFullContractAddress();
      return TokenData(
        tokenName: _tokenNames[nameIndex],
        tokenFullName: _fullNames[nameIndex],
        ageInSeconds: _random.nextInt(60), // 0-59秒随机
        contractAddress: _generateShortAddress(fullAddress),
        fullContractAddress: fullAddress,
        stats: [
          '${_random.nextInt(20)}',
          '${_random.nextInt(20)}', 
          '${(_random.nextDouble() * 0.1).toStringAsFixed(4)} TX ${_random.nextInt(50)}'
        ],
        tags: [
          '${_random.nextInt(50)}%',
          '${_random.nextInt(20)}%',
          _random.nextBool() ? 'Run' : '${_random.nextInt(10)}%',
          '${_random.nextInt(20)}'
        ],
        volume: '\$${(_random.nextDouble() * 10).toStringAsFixed(1)}K',
        marketCap: '\$${(_random.nextDouble() * 20).toStringAsFixed(1)}K',
        avatarUrl: _avatarUrls[nameIndex],
        progress: _random.nextDouble(),
        createdAt: now.subtract(Duration(seconds: _random.nextInt(60))), // 随机创建时间
      );
    });
  }

  // 生成单个新代币
  static TokenData generateNewToken() {
    final nameIndex = _random.nextInt(_tokenNames.length);
    final fullAddress = _generateFullContractAddress();
    return TokenData(
      tokenName: _tokenNames[nameIndex],
      tokenFullName: _fullNames[nameIndex],
      ageInSeconds: 0,
      contractAddress: _generateShortAddress(fullAddress),
      fullContractAddress: fullAddress,
      stats: [
        '${_random.nextInt(20)}',
        '${_random.nextInt(20)}', 
        '${(_random.nextDouble() * 0.1).toStringAsFixed(4)} TX ${_random.nextInt(50)}'
      ],
      tags: [
        '${_random.nextInt(50)}%',
        '${_random.nextInt(20)}%',
        _random.nextBool() ? 'Run' : '${_random.nextInt(10)}%',
        '${_random.nextInt(20)}'
      ],
      volume: '\$${(_random.nextDouble() * 10).toStringAsFixed(1)}K',
      marketCap: '\$${(_random.nextDouble() * 20).toStringAsFixed(1)}K',
      avatarUrl: _avatarUrls[nameIndex],
      progress: _random.nextDouble(),
      createdAt: DateTime.now(),
    );
  }

  // 为Completing状态生成代币数据
  static List<TokenData> generateCompletingTokens({int count = 6}) {
    return List.generate(count, (index) {
      final nameIndex = _random.nextInt(_tokenNames.length);
      final now = DateTime.now();
      // Completing状态的代币已经运行了一段时间（1-10分钟）
      final onlineMinutes = 1 + _random.nextInt(10);
      final fullAddress = _generateFullContractAddress();
      return TokenData(
        tokenName: _tokenNames[nameIndex],
        tokenFullName: _fullNames[nameIndex],
        ageInSeconds: onlineMinutes * 60, // 转换为秒
        contractAddress: _generateShortAddress(fullAddress),
        fullContractAddress: fullAddress,
        stats: [
          '${_random.nextInt(100) + 20}', // 更高的数值
          '${_random.nextInt(50) + 10}', 
          '${(_random.nextDouble() * 0.5 + 0.1).toStringAsFixed(4)} TX ${_random.nextInt(100) + 20}'
        ],
        tags: [
          '${_random.nextInt(30) + 10}%', // 更稳定的百分比
          '${_random.nextInt(15) + 5}%',
          _random.nextBool() ? 'Run' : '${_random.nextInt(8) + 2}%',
          '${_random.nextInt(15) + 5}'
        ],
        volume: '\$${(_random.nextDouble() * 50 + 10).toStringAsFixed(1)}K', // 更高的成交量
        marketCap: '\$${(_random.nextDouble() * 100 + 20).toStringAsFixed(1)}K', // 更高的市值
        avatarUrl: _avatarUrls[nameIndex],
        progress: 0.6 + _random.nextDouble() * 0.4, // 60%-100%的进度
        createdAt: now.subtract(Duration(minutes: onlineMinutes)),
      );
    });
  }

  // 为Completed状态生成代币数据
  static List<TokenData> generateCompletedTokens({int count = 6}) {
    return List.generate(count, (index) {
      final nameIndex = _random.nextInt(_tokenNames.length);
      final now = DateTime.now();
      // Completed状态的代币已经运行了很长时间（10分钟到几小时）
      final onlineMinutes = 10 + _random.nextInt(300); // 10分钟到5小时
      final fullAddress = _generateFullContractAddress();
      return TokenData(
        tokenName: _tokenNames[nameIndex],
        tokenFullName: _fullNames[nameIndex],
        ageInSeconds: onlineMinutes * 60,
        contractAddress: _generateShortAddress(fullAddress),
        fullContractAddress: fullAddress,
        stats: [
          '${_random.nextInt(500) + 100}', // 非常高的数值
          '${_random.nextInt(100) + 50}', 
          '${(_random.nextDouble() * 2 + 1).toStringAsFixed(4)} TX ${_random.nextInt(500) + 100}'
        ],
        tags: [
          '${_random.nextInt(20) + 5}%', // 相对稳定的百分比
          '${_random.nextInt(10) + 2}%',
          _random.nextBool() ? 'Run' : '${_random.nextDouble() * 1}.${_random.nextInt(10)}%',
          '${_random.nextInt(10) + 1}'
        ],
        volume: '\$${(_random.nextDouble() * 500 + 100).toStringAsFixed(1)}K', // 很高的成交量
        marketCap: '\$${(_random.nextDouble() * 1000 + 200).toStringAsFixed(1)}K', // 很高的市值
        avatarUrl: _avatarUrls[nameIndex],
        progress: 1.0, // 100%完成
        createdAt: now.subtract(Duration(minutes: onlineMinutes)),
      );
    });
  }

  static String _generateRandomString(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(_random.nextInt(chars.length))));
  }

  // 生成完整的合约地址（44个字符，模拟Solana地址格式）
  static String _generateFullContractAddress() {
    return _generateRandomString(44);
  }

  // 根据完整地址生成简略显示版本
  static String _generateShortAddress(String fullAddress) {
    if (fullAddress.length < 8) return fullAddress;
    return '${fullAddress.substring(0, 5)}...${fullAddress.substring(fullAddress.length - 3)}';
  }
}