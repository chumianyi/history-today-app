import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../models/history_event.dart';
import 'neu_widgets.dart';

class HistoryTile extends StatelessWidget {
  final HistoryEvent event;
  final int index;

  const HistoryTile({
    super.key,
    required this.event,
    required this.index,
  });

  Color get _typeColor {
    switch (event.type) {
      case 'birth':
        return NeuColors.primary;
      case 'death':
        return NeuColors.textSecondary;
      case 'festival':
        return NeuColors.accent;
      default:
        return const Color(0xFF6B8EBE);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NeuCard(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(14),
      onTap: () => _showDetail(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildYearBadge(),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildTypeTag(),
                    const Spacer(),
                    _buildShareButton(),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  event.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: NeuColors.textPrimary,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                if (event.description.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    event.description,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: NeuColors.textSecondary,
                      height: 1.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYearBadge() {
    return Container(
      width: 56,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      decoration: BoxDecoration(
        color: NeuColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: NeuColors.darkShadow.withOpacity(0.4),
            offset: const Offset(2, 2),
            blurRadius: 5,
          ),
          BoxShadow(
            color: NeuColors.lightShadow.withOpacity(0.8),
            offset: const Offset(-2, -2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            event.year,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _typeColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '年',
            style: TextStyle(
              fontSize: 10,
              color: _typeColor.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _typeColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        event.typeLabel,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: _typeColor,
        ),
      ),
    );
  }

  Widget _buildShareButton() {
    return GestureDetector(
      onTap: () => Share.share(event.shareText),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: NeuColors.cardBackground,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: NeuColors.darkShadow.withOpacity(0.4),
              offset: const Offset(1.5, 1.5),
              blurRadius: 3,
            ),
            BoxShadow(
              color: NeuColors.lightShadow.withOpacity(0.8),
              offset: const Offset(-1.5, -1.5),
              blurRadius: 3,
            ),
          ],
        ),
        child: const Icon(
          Icons.share,
          size: 16,
          color: NeuColors.accent,
        ),
      ),
    );
  }

  void _showDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: NeuColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: NeuColors.darkShadow.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _typeColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${event.year}年',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _typeColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  _buildTypeTag(),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                event.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: NeuColors.textPrimary,
                  height: 1.4,
                ),
              ),
              if (event.description.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  event.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: NeuColors.textSecondary,
                    height: 1.6,
                  ),
                ),
              ],
              const SizedBox(height: 20),
              NeuButton(
                onPressed: () => Share.share(event.shareText),
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 14),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.share, color: NeuColors.accent, size: 20),
                    SizedBox(width: 8),
                    Text(
                      '分享这条历史',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: NeuColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
