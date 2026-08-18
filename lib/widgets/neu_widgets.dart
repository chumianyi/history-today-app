import 'package:flutter/material.dart';

class NeuColors {
  static const Color background = Color(0xFFE8F0FE);
  static const Color surface = Color(0xFFE8F0FE);
  static const Color lightShadow = Color(0xFFFFFFFF);
  static const Color darkShadow = Color(0xFFB8C5D6);
  static const Color primary = Color(0xFF4A90D9);
  static const Color accent = Color(0xFFFF8FA3);
  static const Color textPrimary = Color(0xFF2D3748);
  static const Color textSecondary = Color(0xFF718096);
  static const Color cardBackground = Color(0xFFE8F0FE);
  static const Color pinkSoft = Color(0xFFFFD6E0);
  static const Color blueSoft = Color(0xFFD0E3F7);
}

class NeuCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final VoidCallback? onTap;
  final bool pressed;
  final Color? color;

  const NeuCard({
    super.key,
    required this.child,
    this.borderRadius = 16,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.onTap,
    this.pressed = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: color ?? NeuColors.cardBackground,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: pressed
              ? [
                  BoxShadow(
                    color: NeuColors.darkShadow.withOpacity(0.5),
                    offset: const Offset(3, 3),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: NeuColors.lightShadow.withOpacity(0.8),
                    offset: const Offset(-3, -3),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ]
              : [
                  BoxShadow(
                    color: NeuColors.lightShadow.withOpacity(0.9),
                    offset: const Offset(-5, -5),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: NeuColors.darkShadow.withOpacity(0.6),
                    offset: const Offset(5, 5),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
        ),
        child: child,
      ),
    );
  }
}

class NeuButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Color? color;

  const NeuButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    this.color,
  });

  @override
  State<NeuButton> createState() => _NeuButtonState();
}

class _NeuButtonState extends State<NeuButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: widget.padding,
        decoration: BoxDecoration(
          color: widget.color ?? NeuColors.cardBackground,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: _isPressed
              ? [
                  BoxShadow(
                    color: NeuColors.darkShadow.withOpacity(0.5),
                    offset: const Offset(2, 2),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: NeuColors.lightShadow.withOpacity(0.8),
                    offset: const Offset(-2, -2),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ]
              : [
                  BoxShadow(
                    color: NeuColors.lightShadow.withOpacity(0.9),
                    offset: const Offset(-4, -4),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: NeuColors.darkShadow.withOpacity(0.6),
                    offset: const Offset(4, 4),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
        ),
        child: widget.child,
      ),
    );
  }
}

class NeuCircleButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final Color? iconColor;

  const NeuCircleButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 48,
    this.iconColor,
  });

  @override
  State<NeuCircleButton> createState() => _NeuCircleButtonState();
}

class _NeuCircleButtonState extends State<NeuCircleButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: NeuColors.cardBackground,
          shape: BoxShape.circle,
          boxShadow: _isPressed
              ? [
                  BoxShadow(
                    color: NeuColors.darkShadow.withOpacity(0.5),
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                  ),
                  BoxShadow(
                    color: NeuColors.lightShadow.withOpacity(0.8),
                    offset: const Offset(-2, -2),
                    blurRadius: 4,
                  ),
                ]
              : [
                  BoxShadow(
                    color: NeuColors.lightShadow.withOpacity(0.9),
                    offset: const Offset(-3, -3),
                    blurRadius: 6,
                  ),
                  BoxShadow(
                    color: NeuColors.darkShadow.withOpacity(0.6),
                    offset: const Offset(3, 3),
                    blurRadius: 6,
                  ),
                ],
        ),
        child: Icon(
          widget.icon,
          color: widget.iconColor ?? NeuColors.primary,
          size: widget.size * 0.45,
        ),
      ),
    );
  }
}
