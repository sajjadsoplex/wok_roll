import 'package:flutter/material.dart';

class StoryButton extends StatefulWidget {
  const StoryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.compact = false,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool compact;

  @override
  State<StoryButton> createState() => _StoryButtonState();
}

class _StoryButtonState extends State<StoryButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 950),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, child) {
        final glow = 0.20 + (_pulse.value * 0.32);
        return Transform.scale(
          scale: 1 + (_pulse.value * 0.018),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE83E83).withValues(alpha: glow),
                  blurRadius: 14 + _pulse.value * 12,
                  spreadRadius: 1 + _pulse.value * 3,
                ),
                const BoxShadow(
                  color: Color(0x553C1830),
                  offset: Offset(0, 5),
                  blurRadius: 0,
                ),
              ],
            ),
            child: child,
          ),
        );
      },
      child: ElevatedButton.icon(
        onPressed: widget.onPressed,
        icon: widget.icon == null ? const SizedBox.shrink() : Icon(widget.icon),
        label: Text(
          widget.label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: widget.compact ? 14 : 16,
            fontWeight: FontWeight.w900,
            letterSpacing: .2,
          ),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFFE83E83),
          padding: EdgeInsets.symmetric(
            horizontal: widget.compact ? 17 : 24,
            vertical: widget.compact ? 13 : 17,
          ),
          shape: const StadiumBorder(
            side: BorderSide(color: Color(0xFFA52D63), width: 2),
          ),
        ),
      ),
    );
  }
}
