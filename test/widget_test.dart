
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wok_and_roll/app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    // Configure the test browser viewport.
  });

  testWidgets(
    'Welcome screen renders and starts the story',
    (WidgetTester tester) async {

      // Set desktop browser dimensions.
      tester.view.physicalSize = const Size(900, 1000);
      tester.view.devicePixelRatio = 1;

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      // Launch the application.
      await tester.pumpWidget(
        const WokAndRollApp(),
      );

      // Allow the first screen to render.
      await tester.pump(
        const Duration(milliseconds: 600),
      );

      // Verify welcome screen.
      expect(
        find.textContaining('important noodle mission'),
        findsOneWidget,
      );

      expect(
        find.text('TAKE ME TO WOK & ROLL! 💗'),
        findsOneWidget,
      );

      // Tap the welcome button.
      await tester.tap(
        find.text('TAKE ME TO WOK & ROLL! 💗'),
      );

      await tester.pump();

      // Wait for the cat's running sequence.
      await tester.pump(
        const Duration(seconds: 2),
      );

      // Complete the scene transition.
      await tester.pump(
        const Duration(milliseconds: 600),
      );

      // Verify calendar screen.
      expect(
        find.textContaining('marked your calendar'),
        findsOneWidget,
      );

      expect(
        find.text('26'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Calendar button navigates to the stall',
    (WidgetTester tester) async {

      tester.view.physicalSize = const Size(900, 1000);
      tester.view.devicePixelRatio = 1;

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        const WokAndRollApp(),
      );

      await tester.pump(
        const Duration(milliseconds: 600),
      );

      // Open calendar scene.
      await tester.tap(
        find.text('TAKE ME TO WOK & ROLL! 💗'),
      );

      await tester.pump();
      await tester.pump(
        const Duration(seconds: 2),
      );
      await tester.pump(
        const Duration(milliseconds: 600),
      );

      // Tap calendar confirmation.
      await tester.tap(
        find.text("YES! IT'S MARKED! 📅"),
      );

      await tester.pump();
      await tester.pump(
        const Duration(seconds: 2),
      );
      await tester.pump(
        const Duration(milliseconds: 600),
      );

      // Verify stall scene.
      expect(
        find.text('WE FOUND WOK & ROLL!'),
        findsOneWidget,
      );

      expect(
        find.textContaining('SPECIAL CHICKEN CHOWMEIN'),
        findsOneWidget,
      );
    },
  );
}
