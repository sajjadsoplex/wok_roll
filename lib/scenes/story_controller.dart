import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../widgets/cat_mascot.dart';
import '../widgets/floating_decorations.dart';
import '../widgets/story_button.dart';

enum StoryScene {
  welcome,
  calendar,
  running,
  stall,
  gr,
  delivery,
  thanks,
  appreciation,
}

class StoryController extends StatefulWidget {
  const StoryController({super.key});

  @override
  State<StoryController> createState() => _StoryControllerState();
}

class _StoryControllerState extends State<StoryController>
    with TickerProviderStateMixin {
  StoryScene scene = StoryScene.welcome;
  bool isRunning = false;

  late final AnimationController _beeController =
      AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  )..repeat();

  Timer? _transitionTimer;

  @override
  void dispose() {
    _transitionTimer?.cancel();
    _beeController.dispose();
    super.dispose();
  }

  void _go(StoryScene next) {
    _transitionTimer?.cancel();
    setState(() {
      scene = next;
      isRunning = false;
    });
  }

  void _runTo(StoryScene destination) {
    _transitionTimer?.cancel();

    setState(() {
      scene = StoryScene.running;
      isRunning = true;
    });

    _transitionTimer = Timer(
      const Duration(milliseconds: 2000),
      () {
        if (!mounted) return;
        setState(() {
          isRunning = false;
          scene = destination;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth > 720;

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFF7F0),
                  Color(0xFFFCE4EF),
                  Color(0xFFF8C8DD),
                ],
              ),
            ),
            child: Stack(
              children: [
                const Positioned.fill(
                  child: FloatingDecorations(),
                ),
                SafeArea(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 920,
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 550),
                        switchInCurve: Curves.easeOutBack,
                        switchOutCurve: Curves.easeIn,
                        child: _buildScene(
                          wide,
                          key: ValueKey(scene),
                        ),
                      ),
                    ),
                  ),
                ),
                if (scene == StoryScene.thanks ||
                    scene == StoryScene.appreciation)
                  ..._buildBees(constraints),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 10,
                  child: IgnorePointer(
                    child: Text(
                      'WOK & ROLL  •  CHOWMEIN CORNER  •  CULTURE DAY',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 1.5,
                        color: const Color(0xFFA52D63)
                            .withOpacity(0.6),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // FLYING BEE ANIMATION

  List<Widget> _buildBees(BoxConstraints constraints) {
    return List.generate(5, (i) {
      return AnimatedBuilder(
        animation: _beeController,
        builder: (context, child) {
          final progress =
              (_beeController.value + i * 0.19) % 1.0;

          final x =
              progress * (constraints.maxWidth + 70) - 35;

          final y = 55.0 +
              ((i * 73) % 230) +
              10 *
                  (1 +
                      math.sin(
                        _beeController.value * 2 * math.pi,
                      ));

          return Positioned(
            left: x,
            top: y,
            child: Transform.rotate(
              angle: math.sin(
                    _beeController.value * 2 * math.pi,
                  ) *
                  0.15,
              child: const Text(
                '🐝',
                style: TextStyle(fontSize: 26),
              ),
            ),
          );
        },
      );
    });
  }

  // SCENE CONTROLLER

  Widget _buildScene(bool wide, {Key? key}) {
    final Widget content = switch (scene) {
      StoryScene.welcome => _welcome(wide),
      StoryScene.calendar => _calendar(wide),
      StoryScene.running => _running(wide),
      StoryScene.stall => _stall(wide),
      StoryScene.gr => _gr(wide),
      StoryScene.delivery => _delivery(wide),
      StoryScene.thanks => _thanks(wide),
      StoryScene.appreciation => _appreciation(wide),
    };

    return SingleChildScrollView(
      key: key,
      padding: EdgeInsets.fromLTRB(
        wide ? 42 : 20,
        26,
        wide ? 42 : 20,
        55,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 580),
        child: content,
      ),
    );
  }

  // REUSABLE DESIGN COMPONENTS

  Widget _frame({
    required Widget child,
    Color color = const Color(0xFFFFFBF8),
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color.withOpacity(0.94),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFFFFB6D2),
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x332D1021),
            offset: Offset(0, 7),
            blurRadius: 18,
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _heading(
    String text, {
    double size = 30,
  }) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: size,
        height: 1.08,
        fontWeight: FontWeight.w900,
        color: const Color(0xFFA52D63),
      ),
    );
  }

  Widget _body(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 16,
        height: 1.45,
        color: Color(0xFF563344),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _cat({
    double size = 190,
    CatExpression expression = CatExpression.happy,
    bool parcel = false,
  }) {
    return CatMascot(
      size: size,
      expression: expression,
      withParcel: parcel,
    );
  }

  // SCENE 01: WELCOME

  Widget _welcome(bool wide) {
    return _frame(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '🐾  PSSST... YOU!  🐾',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Color(0xFFA52D63),
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          _cat(size: wide ? 250 : 210),
          _heading(
            "I've got a very important noodle mission for you!",
            size: wide ? 34 : 27,
          ),
          const SizedBox(height: 10),
          _body(
            "It's urgent. It's delicious. And I absolutely cannot do it without you. 😼",
          ),
          const SizedBox(height: 25),
          StoryButton(
            label: 'TAKE ME TO WOK & ROLL! 💗',
            icon: Icons.pets,
            onPressed: () => _runTo(StoryScene.calendar),
          ),
          const SizedBox(height: 12),
          const Text(
            "Tap the button. The cat has places to be.",
            style: TextStyle(
              color: Color(0xFF9B6680),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  // SCENE 02: CALENDAR REMINDER

  Widget _calendar(bool wide) {
    return _frame(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _cat(
            size: 170,
            expression: CatExpression.curious,
          ),
          _heading(
            'WAIT! Have you marked your calendar?',
            size: wide ? 34 : 27,
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 20,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE7A8),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: const Color(0xFFA52D63),
                width: 2,
              ),
            ),
            child: const Column(
              children: [
                Text(
                  'CULTURE DAY',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    color: Color(0xFFA52D63),
                  ),
                ),
                Text(
                  '26',
                  style: TextStyle(
                    fontSize: 72,
                    height: 1,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFE83E83),
                  ),
                ),
                Text(
                  'NOVEMBER',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFA52D63),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _body(
            "If you forget, the cat will personally come and remind you. Probably.",
          ),
          const SizedBox(height: 22),
          StoryButton(
            label: "YES! IT'S MARKED! 📅",
            icon: Icons.check_circle,
            onPressed: () => _runTo(StoryScene.stall),
          ),
        ],
      ),
    );
  }

  // SCENE 03: RUNNING CAT

  Widget _running(bool wide) {
    return _frame(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _heading(
            'NO TIME TO WASTE!',
            size: 30,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 220,
            child: TweenAnimationBuilder<double>(
              key: ValueKey(isRunning),
              tween: Tween<double>(
                begin: 0,
                end: 1,
              ),
              duration: const Duration(milliseconds: 1800),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Align(
                  alignment: Alignment.lerp(
                    Alignment.centerLeft,
                    Alignment.centerRight,
                    value,
                  )!,
                  child: Transform.scale(
                    scaleX: value < 0.5 ? 1 : -1,
                    child: child,
                  ),
                );
              },
              child: _cat(
                size: 185,
                expression: CatExpression.excited,
              ),
            ),
          ),
          _heading(
            'The noodles are NOT going to eat themselves!',
            size: 24,
          ),
          const SizedBox(height: 10),
          _body(
            'Running on tiny paws and BIG chowmein dreams...',
          ),
          const SizedBox(height: 18),
          const LinearProgressIndicator(
            minHeight: 8,
            color: Color(0xFFE83E83),
            backgroundColor: Color(0xFFFFD8E8),
          ),
        ],
      ),
    );
  }

  // SCENE 04: STALL REVEAL

  Widget _stall(bool wide) {
    return _frame(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _heading(
            'WE FOUND WOK & ROLL!',
            size: wide ? 38 : 29,
          ),
          const SizedBox(height: 8),
          _body(
            'The lights! The funfair! THE NOODLES! This is not a drill.',
          ),
          const SizedBox(height: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              'assets/images/culture_day_poster.jpg',
              height: wide ? 300 : 230,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return _fallbackStall();
              },
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/chowmein_from_poster.jpg',
              height: 150,
              width: 250,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return _fallbackStall();
              },
            ),
          ),
          const SizedBox(height: 14),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('🏮', style: TextStyle(fontSize: 24)),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  'SPECIAL CHICKEN CHOWMEIN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFA52D63),
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text('🍜', style: TextStyle(fontSize: 24)),
            ],
          ),
          const SizedBox(height: 18),
          StoryButton(
            label: 'WAIT... WHERE IS GR? 👀',
            onPressed: () => _go(StoryScene.gr),
          ),
        ],
      ),
    );
  }

  Widget _fallbackStall() {
    return Container(
      height: 220,
      width: double.infinity,
      color: const Color(0xFFFFE0C8),
      child: const Center(
        child: Text(
          '🏮  WOK & ROLL  🍜',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Color(0xFFA52D63),
          ),
        ),
      ),
    );
  }

  // SCENE 05: GR MISSION

  Widget _gr(bool wide) {
    return _frame(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _cat(
            size: 190,
            expression: CatExpression.curious,
          ),
          _heading(
            'EXCUSE ME... WHERE IS GR?!',
            size: wide ? 34 : 27,
          ),
          const SizedBox(height: 10),
          _body(
            "We cannot leave a fellow noodle lover behind. This mission needs a special delivery!",
          ),
          const SizedBox(height: 22),
          StoryButton(
            label: 'CLICK TO BUY CHOWMEIN FOR GR 🥡',
            icon: Icons.card_giftcard,
            onPressed: () => _go(StoryScene.delivery),
          ),
        ],
      ),
    );
  }

  // SCENE 06: CHOWMEIN DELIVERY

  Widget _delivery(bool wide) {
    return _frame(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _heading(
            'SPECIAL DELIVERY!',
            size: 34,
          ),
          const SizedBox(height: 8),
          _cat(
            size: wide ? 250 : 215,
            expression: CatExpression.proud,
            parcel: true,
          ),
          _body(
            'One parcel of happiness, made extra special for GR. 💗',
          ),
          const SizedBox(height: 20),
          StoryButton(
            label: 'MISSION ACCOMPLISHED! 💝',
            onPressed: () => _go(StoryScene.thanks),
          ),
        ],
      ),
    );
  }

  // SCENE 07: THANK YOU GIRLIES

  Widget _thanks(bool wide) {
    return _frame(
      color: const Color(0xFFFFF5D9),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '🐝  ✨  🐝  ✨  🐝',
            style: TextStyle(fontSize: 30),
          ),
          _cat(
            size: 170,
            expression: CatExpression.happy,
          ),
          _heading(
            'BEE-YOND AMAZING!',
            size: wide ? 39 : 31,
          ),
          const SizedBox(height: 8),
          _heading(
            'THANK YOU, 6th B GIRLIES! 💗',
            size: wide ? 30 : 24,
          ),
          const SizedBox(height: 12),
          _body(
            'For the creativity, teamwork, hard work and all the love you put into this wonderful stall. You made Culture Day extra delicious!',
          ),
          const SizedBox(height: 20),
          StoryButton(
            label: 'ONE LAST THING... 💐',
            onPressed: () => _go(StoryScene.appreciation),
          ),
        ],
      ),
    );
  }

  // SCENE 08: FINAL APPRECIATION

  Widget _appreciation(bool wide) {
    return _frame(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '🌸  💗  🐝  💗  🌸',
            style: TextStyle(fontSize: 28),
          ),
          _cat(
            size: 180,
            expression: CatExpression.happy,
          ),
          _heading(
            'A LITTLE APPRECIATION FOR OUR GIRLIES',
            size: wide ? 34 : 27,
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF0D9),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFFFC0D7),
                width: 2,
              ),
            ),
            child: _body(
              'Behind every delicious plate is a team of hardworking, creative and wonderful girls. Thank you, 6th B Girlies, for putting your hearts into making this stall special. Your teamwork, coordination and bright smiles made this Culture Day sweeter — and definitely more delicious! 💗',
            ),
          ),
          const SizedBox(height: 20),
          StoryButton(
            label: 'REPLAY THE ADVENTURE 🐾',
            icon: Icons.replay,
            onPressed: () => _go(StoryScene.welcome),
          ),
          const SizedBox(height: 10),
          const Text(
            'Made with love, paws and a suspicious amount of noodles. 🍜',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF9B6680),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}