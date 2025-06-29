class WalletData {
  final String address;
  final String shortAddress;
  final double totalBalance;
  final double realizedPnL;
  final double unrealizedProfits;
  final double winRate;
  final List<WalletToken> tokens;

  WalletData({
    required this.address,
    required this.shortAddress,
    required this.totalBalance,
    required this.realizedPnL,
    required this.unrealizedProfits,
    required this.winRate,
    required this.tokens,
  });
}

class WalletToken {
  final String name;
  final String symbol;
  final double amount;
  final double value;
  final double changePercent;
  final String avatarUrl;

  WalletToken({
    required this.name,
    required this.symbol,
    required this.amount,
    required this.value,
    required this.changePercent,
    required this.avatarUrl,
  });
}

class PhishingCheck {
  final String title;
  final bool isGood;
  final String description;

  PhishingCheck({
    required this.title,
    required this.isGood,
    required this.description,
  });
} 