class TokenData {
  final String tokenName;
  final String tokenFullName;
  final int ageInSeconds; // 改为秒数，用于倒计时
  final String contractAddress; // 显示用的简略地址
  final String fullContractAddress; // 完整的合约地址
  final List<String> stats;
  final List<String> tags;
  final String volume;
  final String marketCap;
  final String avatarUrl;
  final double progress;
  final DateTime createdAt; // 添加创建时间

  TokenData({
    required this.tokenName,
    required this.tokenFullName,
    required this.ageInSeconds,
    required this.contractAddress,
    required this.fullContractAddress,
    required this.stats,
    required this.tags,
    required this.volume,
    required this.marketCap,
    required this.avatarUrl,
    required this.progress,
    required this.createdAt,
  });

  // 格式化年龄显示
  String get formattedAge {
    final now = DateTime.now();
    final elapsed = now.difference(createdAt).inSeconds;
    
    if (elapsed < 60) {
      return '${elapsed}s';
    } else {
      final minutes = elapsed ~/ 60;
      return '${minutes}m';
    }
  }

  // 格式化在线时间显示（用于Completing状态）
  String get formattedOnlineTime {
    final now = DateTime.now();
    final elapsed = now.difference(createdAt).inSeconds;
    
    if (elapsed < 60) {
      return '${elapsed}s';
    } else {
      final minutes = elapsed ~/ 60;
      if (minutes < 60) {
        return '${minutes}m';
      } else {
        final hours = minutes ~/ 60;
        return '${hours}h';
      }
    }
  }

  // 检查是否应该被移除（超过1分钟）
  bool get shouldBeRemoved {
    final now = DateTime.now();
    return now.difference(createdAt).inMinutes >= 1;
  }
} 