import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrenchesTokenListItem extends StatefulWidget {
  const TrenchesTokenListItem({
    super.key,
    required this.tokenName,
    required this.tokenFullName,
    required this.age,
    required this.contractAddress,
    required this.fullContractAddress,
    required this.stats,
    required this.tags,
    required this.volume,
    required this.marketCap,
    required this.avatarUrl,
    required this.progress,
    this.isCompleting = false,
    this.isCompleted = false,
  });

  final String tokenName, tokenFullName, age, contractAddress, fullContractAddress, volume, marketCap;
  final List<String> stats, tags;
  final String avatarUrl;
  final double progress;
  final bool isCompleting;
  final bool isCompleted;

  @override
  State<TrenchesTokenListItem> createState() => _TrenchesTokenListItemState();
}

class _TrenchesTokenListItemState extends State<TrenchesTokenListItem> {
  bool _isHovered = false;

  // 复制到剪贴板的方法
  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: _isHovered ? const Color(0xFF2C2C2E) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // 头像和进度圈
            SizedBox(
              width: 60,
              height: 60,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: widget.progress,
                    strokeWidth: 3,
                    backgroundColor: Colors.grey[800],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.avatarUrl),
                      backgroundColor: Colors.grey[700],
                    ),
                  ),
                  // 右下角小图标
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: const Icon(Icons.check, size: 10, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // 主要内容区域
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 第一行：代币名称
                  Row(
                    children: [
                      Text('\$${widget.tokenName}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                      const SizedBox(width: 8),
                      Text(widget.tokenFullName, style: TextStyle(color: Colors.grey[500], fontSize: 14)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.flash_on, color: Colors.green, size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // 第二行：时间和地址
                  Row(
                    children: [
                      Text(
                        widget.age, 
                        style: TextStyle(
                          color: widget.isCompleted ? Colors.blue : (widget.isCompleting ? Colors.white : Colors.greenAccent), 
                          fontWeight: FontWeight.bold
                        )
                      ),
                      const SizedBox(width: 12),
                      Text(widget.contractAddress, style: TextStyle(color: Colors.grey[500])),
                      const SizedBox(width: 4),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => _copyToClipboard(widget.fullContractAddress),
                          child: Icon(
                            Icons.copy, 
                            size: 12, 
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      const Spacer(),
                      // 统计信息
                      const Icon(Icons.people_alt_outlined, size: 14, color: Colors.grey),
                      Text(' ${widget.stats[0]}', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                      const SizedBox(width: 8),
                      const Icon(Icons.wallet_outlined, size: 14, color: Colors.grey),
                      Text(' ${widget.stats[1]}', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                      const SizedBox(width: 8),
                      Text(widget.stats[2], style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // 第三行：标签和数据
                  Row(
                    children: [
                      // 左侧标签组
                      _buildPercentageTag(widget.tags.isNotEmpty ? widget.tags[0] : '28.1%', Colors.green),
                      const SizedBox(width: 12),
                      _buildPersonTag(widget.tags.length > 1 ? widget.tags[1] : '4%'),
                      const SizedBox(width: 12),
                      _buildRunTag(),
                      const SizedBox(width: 12),
                      _buildNumberTag(widget.tags.length > 3 ? widget.tags[3] : '4'),
                      const Spacer(),
                      // 右侧成交量和市值
                      Text('V ${widget.volume}', style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(width: 16),
                      Text('MC ${widget.marketCap}', style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 百分比标签（绿色/青色背景）
  Widget _buildPercentageTag(String percentage, Color color) {
    return Text(
      percentage,
      style: TextStyle(
        color: color,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  // 人员图标标签
  Widget _buildPersonTag(String percentage) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.person, color: Colors.teal, size: 16),
        const SizedBox(width: 2),
        Text(
          percentage,
          style: const TextStyle(
            color: Colors.teal,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // Run标签（粉色图标+文字）
  Widget _buildRunTag() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.local_fire_department, color: Colors.pink, size: 16), // 厨师帽图标
        const SizedBox(width: 2),
        const Text(
          'Run',
          style: TextStyle(
            color: Colors.pink,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // 数字标签（圆形图标）
  Widget _buildNumberTag(String number) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, color: Colors.green, size: 16),
        const SizedBox(width: 2),
        Text(
          number,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String text, Color color, IconData icon) {
    if (text.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      margin: const EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 12),
          const SizedBox(width: 4),
          Text(text, style: TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
} 