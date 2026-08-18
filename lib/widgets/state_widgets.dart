import 'package:flutter/material.dart';
import 'neu_widgets.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NeuCard(
            padding: const EdgeInsets.all(24),
            borderRadius: 20,
            child: const SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor:
                    AlwaysStoppedAnimation<Color>(NeuColors.primary),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            '正在穿越历史长河...',
            style: TextStyle(
              fontSize: 15,
              color: NeuColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  final VoidCallback onRetry;

  const EmptyState({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NeuCard(
            padding: const EdgeInsets.all(28),
            borderRadius: 24,
            child: const Icon(
              Icons.event_available,
              size: 56,
              color: NeuColors.accent,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            '这一天暂无记录',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: NeuColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '换个日期试试看吧',
            style: TextStyle(
              fontSize: 13,
              color: NeuColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          NeuButton(
            onPressed: onRetry,
            child: const Text(
              '重新加载',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: NeuColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NeuCard(
            padding: const EdgeInsets.all(28),
            borderRadius: 24,
            child: const Icon(
              Icons.wifi_off,
              size: 56,
              color: NeuColors.accent,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            '加载失败',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: NeuColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: NeuColors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 20),
          NeuButton(
            onPressed: onRetry,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.refresh, color: NeuColors.primary, size: 18),
                SizedBox(width: 6),
                Text(
                  '重试',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: NeuColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
