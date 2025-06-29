import 'package:flutter/material.dart';
import 'package:hello_flutter_web/screens/market_page.dart';
import 'package:hello_flutter_web/screens/wallet_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleWalletMenuSelection(BuildContext context, String selection) {
    switch (selection) {
      case 'my_wallet':
        _tabController.animateTo(7); // Index 7 is for the Wallet tab now
        break;
      case 'wallet_manager':
        // Wallet Manager might have a different navigation
        _tabController.animateTo(7); // For now, also point to the wallet tab
        break;
      case 'security':
        // TODO: Implement security page
        break;
      case 'referral':
        // TODO: Implement referral page
        break;
      case 'contest':
        // TODO: Implement contest page
        break;
      case 'withdraw':
        // TODO: Implement withdraw page
        break;
      case 'tg_alert':
        // TODO: Implement TG alert settings
        break;
      case 'add_twitter':
        // TODO: Implement add twitter functionality
        break;
      case 'disconnect':
        Navigator.pushReplacementNamed(context, '/');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.pinkAccent.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.ac_unit, size: 28, color: Colors.pinkAccent),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('GMGN App', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('Discover faster, Trading in seconds', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreenAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text('Get', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                // 左侧：像素风格图标 + SOL
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.videogame_asset, color: Colors.black, size: 20),
                ),
                const SizedBox(width: 8),
                // 紫色圆形图标
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.deepPurple,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.layers, color: Colors.white, size: 14),
                ),
                const SizedBox(width: 8),
                const Text('SOL', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                const Icon(Icons.arrow_drop_down, color: Colors.white),
                const SizedBox(width: 24),
                // 功能图标
                _customIconButton(Icons.search),
                _customIconButton(Icons.hexagon_outlined),
                _customIconButton(Icons.refresh),
                const Spacer(),
                // 右侧：简化的钱包界面
                PopupMenuButton<String>(
                  offset: const Offset(0, 40),
                  onSelected: (String result) {
                    _handleWalletMenuSelection(context, result);
                  },
                  color: const Color(0xFF2C2C2E),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem<String>(
                        value: 'my_wallet',
                        child: Row(
                          children: [
                            Icon(Icons.account_balance_wallet, color: Colors.white, size: 20),
                            SizedBox(width: 12),
                            Text('My Wallet', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'wallet_manager',
                        child: Row(
                          children: [
                            Icon(Icons.settings, color: Colors.white, size: 20),
                            SizedBox(width: 12),
                            Text('Wallet Manager', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'security',
                        child: Row(
                          children: [
                            Icon(Icons.security, color: Colors.white, size: 20),
                            SizedBox(width: 12),
                            Text('Security', style: TextStyle(color: Colors.white)),
                            Spacer(),
                            Text('Not Bound', style: TextStyle(color: Colors.red, fontSize: 12)),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'referral',
                        child: Row(
                          children: [
                            Icon(Icons.card_giftcard, color: Colors.white, size: 20),
                            SizedBox(width: 12),
                            Text('Referral', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'contest',
                        child: Row(
                          children: [
                            Icon(Icons.emoji_events, color: Colors.white, size: 20),
                            SizedBox(width: 12),
                            Text('Contest(S6)', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'withdraw',
                        child: Row(
                          children: [
                            Icon(Icons.logout, color: Colors.white, size: 20),
                            SizedBox(width: 12),
                            Text('Withdraw', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'tg_alert',
                        child: Row(
                          children: [
                            Icon(Icons.notifications, color: Colors.white, size: 20),
                            SizedBox(width: 12),
                            Text('TG Alert', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'add_twitter',
                        child: Row(
                          children: [
                            Icon(Icons.add, color: Colors.white, size: 20),
                            SizedBox(width: 12),
                            Text('Add Twitter', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'disconnect',
                        child: Row(
                          children: [
                            Icon(Icons.power_settings_new, color: Colors.white, size: 20),
                            SizedBox(width: 12),
                            Text('Disconnect', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ];
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2E),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.account_balance_wallet_outlined, color: Colors.white, size: 16),
                        SizedBox(width: 8),
                        Icon(Icons.layers, color: Colors.deepPurple, size: 16),
                        SizedBox(width: 6),
                        Text('0', style: TextStyle(color: Colors.white, fontSize: 14)),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_drop_down, color: Colors.white, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: MarketPage(tabController: _tabController)),
        ],
      ),
    );
  }
}

// Custom IconButton to remove default padding and splash effects
Widget _customIconButton(IconData icon) {
  return InkWell(
    onTap: () {},
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(icon, color: Colors.white, size: 20),
    ),
  );
}

// A placeholder widget for the main content of the dashboard.
class WalletOverview extends StatelessWidget {
  const WalletOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // 1. Wallet Summary Card
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '总资产',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                const Text(
                  '\$1,234.56',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  '+\$56.78 (+4.8%) 今日',
                  style: TextStyle(fontSize: 16, color: Colors.greenAccent),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_downward),
                      label: const Text('充值'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_upward),
                      label: const Text('提现'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // 2. Portfolio List
        const Text(
          '我的持仓',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        // Mock data items
        const PortfolioListItem(
          icon: Icons.currency_bitcoin, // Placeholder
          name: 'Bonk',
          symbol: 'BONK',
          amount: '1,500,000',
          value: '\$450.12',
        ),
        const Divider(),
        const PortfolioListItem(
          icon: Icons.generating_tokens, // Placeholder
          name: 'Dogwifhat',
          symbol: 'WIF',
          amount: '350',
          value: '\$784.44',
        ),
        const Divider(),
      ],
    );
  }
}

class PortfolioListItem extends StatelessWidget {
  const PortfolioListItem({
    super.key,
    required this.icon,
    required this.name,
    required this.symbol,
    required this.amount,
    required this.value,
  });

  final IconData icon;
  final String name;
  final String symbol;
  final String amount;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[800],
        child: Icon(icon, color: Colors.yellow),
      ),
      title: Text(name),
      subtitle: Text('$amount $symbol'),
      trailing: Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      onTap: () {
        // Navigate to token detail page
      },
    );
  }
}
