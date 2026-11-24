import 'package:flutter/material.dart';

class FloatingDecorations extends StatelessWidget {
  const FloatingDecorations({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <(double, double, String, double)>[
      (.06, .14, '♡', 34), (.84, .18, '✿', 27), (.10, .78, '✦', 24),
      (.88, .76, '♡', 30), (.50, .08, '✧', 22), (.73, .48, '✿', 18),
    ];
    return IgnorePointer(
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: items.map((e) => Positioned(
            left: constraints.maxWidth * e.$1,
            top: constraints.maxHeight * e.$2,
            child: Text(e.$3, style: TextStyle(
              fontSize: e.$4,
              color: const Color(0x73E98AB1),
              fontWeight: FontWeight.w900,
            )),
          )).toList(),
        ),
      ),
    );
  }
}
