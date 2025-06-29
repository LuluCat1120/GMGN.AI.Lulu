import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/wallet_data.dart';
import '../services/wallet_service.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  late WalletData _walletData;
  late List<PhishingCheck> _phishingChecks;
  String _selectedTab = '7d';
  String _selectedCurrency = 'USD'; // 当前选择的货币
  bool _isCopied1 = false; // 第一个复制按钮的状态
  bool _isCopied2 = false; // 第二个复制按钮的状态
  bool _isCopied3 = false; // 第三个复制按钮的状态

  @override
  void initState() {
    super.initState();
    _walletData = WalletService.generateWalletData();
    _phishingChecks = WalletService.generatePhishingChecks();
  }

  void _copyToClipboard(String text, int buttonIndex) async {
    await Clipboard.setData(ClipboardData(text: text));
    
    setState(() {
      switch (buttonIndex) {
        case 1:
          _isCopied1 = true;
          break;
        case 2:
          _isCopied2 = true;
          break;
        case 3:
          _isCopied3 = true;
          break;
      }
    });

    // 2秒后恢复为复制图标
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          switch (buttonIndex) {
            case 1:
              _isCopied1 = false;
              break;
            case 2:
              _isCopied2 = false;
              break;
            case 3:
              _isCopied3 = false;
              break;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWalletHeader(),
          const SizedBox(height: 24),
          _buildTabBar(),
          const SizedBox(height: 16),
          _buildPnLSection(),
          const SizedBox(height: 24),
          _buildPhishingCheck(),
          const SizedBox(height: 24),
          _buildTransactionHistory(),
        ],
      ),
    );
  }

  Widget _buildWalletHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 左侧：头像
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blue,
                child: Text(
                  _walletData.shortAddress.substring(0, 2).toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(width: 16),
              // 中间：信息区域
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 第一行：地址名称和三个图标
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            _walletData.shortAddress,
                            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () => _copyToClipboard(_walletData.shortAddress, 1),
                          child: Icon(
                            _isCopied1 ? Icons.check : Icons.copy,
                            color: _isCopied1 ? Colors.green : Colors.grey,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.share, color: Colors.grey, size: 18),
                        const SizedBox(width: 8),
                        const Icon(Icons.refresh, color: Colors.grey, size: 18),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // 第二行：完整地址 + 复制图标 + 另一个图标
                    Row(
                      children: [
                        Text(
                          'CJzZXg',
                          style: TextStyle(color: Colors.grey[400], fontSize: 14),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => _copyToClipboard('CJzZXg...full_address', 2),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.grey[600],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Icon(
                              _isCopied2 ? Icons.check : Icons.copy,
                              color: _isCopied2 ? Colors.green : Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.menu, color: Colors.white, size: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 第三行：Add Twitter按钮和Copy trade按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.close, color: Colors.black, size: 16),
                    SizedBox(width: 6),
                    Text(
                      'Add Twitter',
                      style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward_ios, color: Colors.black, size: 14),
                  ],
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _copyToClipboard('Copy trade functionality', 3),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _isCopied3 ? Icons.check : Icons.content_copy,
                            color: _isCopied3 ? Colors.green : Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Copy trade',
                            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.person, color: Colors.black, size: 22),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    final tabs = ['7D PnL', 'Profit', 'Distribution'];
    final timeTabs = ['1d', '7d', '30d', 'All'];
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 左侧：主要标签
        Row(
          children: tabs.map((tab) {
            final isSelected = tab == '7D PnL';
            return Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey[600]!),
              ),
              child: Text(
                tab,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[400],
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            );
          }).toList(),
        ),
        // 右侧：时间标签
        Row(
          children: timeTabs.map((timeTab) {
            final isSelected = timeTab == '7d';
            return Container(
              margin: const EdgeInsets.only(left: 4),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? Colors.grey[800] : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                timeTab,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[500],
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPnLSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        '7D Realized PnL',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCurrency = _selectedCurrency == 'USD' ? 'SOL' : 'USD';
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _selectedCurrency,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.currency_exchange, color: Colors.grey, size: 14),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_walletData.realizedPnL >= 0 ? '+' : ''}\$${_walletData.realizedPnL.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: _walletData.realizedPnL >= 0 ? Colors.green : Colors.red,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Total PnL',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const Text(
                    'Unrealized Profits',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Win Rate',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_walletData.winRate.toStringAsFixed(0)}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${_walletData.unrealizedProfits >= 0 ? '+' : ''}${_walletData.unrealizedProfits.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: _walletData.unrealizedProfits >= 0 ? Colors.green : Colors.red,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '\$${_walletData.unrealizedProfits.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhishingCheck() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.security, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text(
              'Phishing check',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ..._phishingChecks.map((check) => _buildPhishingItem(check)),
      ],
    );
  }

  Widget _buildPhishingItem(PhishingCheck check) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: check.isGood ? Colors.green : Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '${check.title}: ${check.description}',
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标签栏
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildHistoryTab('Recent PnL', false),
              const SizedBox(width: 8),
              _buildHistoryTab('Holdings', false),
              const SizedBox(width: 8),
              _buildHistoryTab('Activity', true),
              const SizedBox(width: 8),
              _buildHistoryTab('Deployed Tokens', false),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // 表格头部
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const Icon(Icons.filter_alt, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                const Text('Type', style: TextStyle(color: Colors.white, fontSize: 14)),
                const SizedBox(width: 40),
                const SizedBox(
                  width: 80,
                  child: Text('Token', style: TextStyle(color: Colors.grey, fontSize: 14)),
                ),
                const SizedBox(width: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Total', style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCurrency = _selectedCurrency == 'USD' ? 'SOL' : 'USD';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          _selectedCurrency,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.currency_exchange, color: Colors.grey, size: 14),
                  ],
                ),
                const SizedBox(width: 20),
                const SizedBox(
                  width: 60,
                  child: Text('Amount', style: TextStyle(color: Colors.grey, fontSize: 14)),
                ),
                const SizedBox(width: 20),
                const Row(
                  children: [
                    Text('Price', style: TextStyle(color: Colors.grey, fontSize: 14)),
                    SizedBox(width: 4),
                    Icon(Icons.swap_vert, color: Colors.grey, size: 14),
                  ],
                ),
                const SizedBox(width: 20),
                const SizedBox(
                  width: 50,
                  child: Text('Profit', style: TextStyle(color: Colors.grey, fontSize: 14)),
                ),
                const SizedBox(width: 20),
                const SizedBox(
                  width: 40,
                  child: Text('Age', style: TextStyle(color: Colors.grey, fontSize: 14)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        // No Data 状态
        Container(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Text(
                          'CLOSE',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'No Data',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryTab(String title, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey[800] : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[500],
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
} 