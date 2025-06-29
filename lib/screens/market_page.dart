import 'package:flutter/material.dart';
import '../widgets/trenches_view.dart';
import '../widgets/filter_widgets.dart';
import 'wallet_page.dart';

// Main Widget for the Market Page, containing the TabBar structure
class MarketPage extends StatelessWidget {
  final TabController tabController;
  const MarketPage({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: tabController,
          dividerColor: Colors.transparent,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
          indicator: const BoxDecoration(),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'Trenches'),
            Tab(text: 'New'),
            Tab(text: 'Trending'),
            Tab(text: 'CopyTrade'),
            Tab(text: 'Monitor'),
            Tab(text: 'Track'),
            Tab(text: 'Holding'),
            SizedBox.shrink(), // Hidden tab for Wallet
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: const [
              TrenchesView(),
              NewCreationsView(),
              Center(child: Text('Trending Content')),
              Center(child: Text('Holdings Content')),
              Center(child: Text('CopyTrade Content')),
              Center(child: Text('Monitor Content')),
              Center(child: Text('Track Content')),
              WalletPage(), // Added WalletPage content
            ],
          ),
        ),
      ],
    );
  }
}

// =================================================================
// TRENCHES TAB WIDGETS - Now moved to separate files
// =================================================================


// =================================================================
// NEW CREATIONS TAB WIDGETS
// =================================================================

class NewCreationsView extends StatelessWidget {
  const NewCreationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildNewTabFilterBar(),
        _buildListHeader(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            children: const [
              TokenListItem(
                tokenName: 'Moonlit',
                age: '2m',
                contractAddress: 'Ffpnm...dd5',
                solValue: 'SOL 84.9/84.9',
                percentageChange: '0%',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Dedicated filter bar for the NEW tab
Widget _buildNewTabFilterBar() {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Column(
      children: [
        // Time Filter Row
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FilterWidgets.timeButton('1m', isSelected: true),
                FilterWidgets.timeButton('5m'),
                FilterWidgets.timeButton('1h'),
                FilterWidgets.timeButton('6h'),
                FilterWidgets.timeButton('24h'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Advanced Filter Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterWidgets.filterChip(
              child: Row(
                children: [
                  const Icon(Icons.person_remove_outlined, color: Colors.grey, size: 18),
                  const SizedBox(width: 6),
                  const Text('Blacklist\nDevs', style: TextStyle(fontSize: 10, color: Colors.grey)),
                  const SizedBox(width: 6),
                  const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
                ],
              ),
            ),
            FilterWidgets.filterChip(
              child: const Row(
                children: [
                  Icon(Icons.filter_list, color: Colors.grey, size: 20),
                  SizedBox(width: 4),
                  Text('Filter 9', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            FilterWidgets.filterChip(
              child: const Row(
                children: [
                  Text('TP/SL', style: TextStyle(color: Colors.white)),
                  SizedBox(width: 4),
                  Icon(Icons.edit, color: Colors.grey, size: 16),
                ],
              ),
            ),
            FilterWidgets.filterChip(
              child: Row(
                children: [
                  const Icon(Icons.flash_on, color: Colors.green, size: 20),
                  const SizedBox(width: 4),
                  Icon(Icons.layers, color: Colors.purpleAccent.shade100, size: 16),
                  const SizedBox(width: 4),
                  const Text('0', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            FilterWidgets.filterChip(
              child: const Row(
                children: [
                  Text('P1', style: TextStyle(color: Colors.white)),
                  Icon(Icons.arrow_drop_down, color: Colors.white),
                ],
              ),
            ),
          ],
        )
      ],
    ),
  );
}

// Filter functions moved to FilterWidgets class

Widget _buildListHeader() {
  return FilterWidgets.buildListHeader();
}

class TokenListItem extends StatelessWidget {
    const TokenListItem({super.key, required this.tokenName, required this.age, required this.contractAddress, required this.solValue, required this.percentageChange});
    final String tokenName, age, contractAddress, solValue, percentageChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          const Icon(Icons.star_border, color: Colors.grey, size: 24),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[800],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(tokenName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 4),
                    const Icon(Icons.search, color: Colors.grey, size: 16),
                    const SizedBox(width: 4),
                    const Icon(Icons.warning, color: Colors.red, size: 16),
                    const SizedBox(width: 4),
                    const Icon(Icons.medication, color: Colors.grey, size: 16),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(age, style: const TextStyle(color: Colors.greenAccent)),
                    const SizedBox(width: 8),
                    Text(contractAddress, style: TextStyle(color: Colors.grey[600])),
                     const SizedBox(width: 4),
                    Icon(Icons.copy, color: Colors.grey[600], size: 12),
                  ],
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(solValue, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(percentageChange, style: TextStyle(color: Colors.grey[600])),
            ],
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.flash_on, color: Colors.green),
          ),
        ],
      ),
    );
  }
} 