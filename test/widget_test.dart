// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:movie/main.dart';

void main() {
  testWidgets('shows catalog and supports favorite navigation', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Loading movies...'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 700));
    await tester.pumpAndSettle();

    expect(find.textContaining('Movie Catalog'), findsOneWidget);
    expect(find.textContaining('0 favorit'), findsOneWidget);
    expect(find.text('Inception'), findsOneWidget);
    expect(find.byKey(const ValueKey('list-favorite-Inception')), findsOneWidget);

    final initialListButton = tester.widget<IconButton>(
      find.byKey(const ValueKey('list-favorite-Inception')),
    );
    expect((initialListButton.icon as Icon).icon, Icons.favorite_border);

    await tester.tap(find.byKey(const ValueKey('list-favorite-Inception')));
    await tester.pumpAndSettle();

    expect(find.textContaining('1 favorit'), findsOneWidget);

    final favoriteListButton = tester.widget<IconButton>(
      find.byKey(const ValueKey('list-favorite-Inception')),
    );
    expect((favoriteListButton.icon as Icon).icon, Icons.favorite);

    await tester.tap(find.text('Inception'));
    await tester.pumpAndSettle();

    expect(find.text('Sinopsis'), findsOneWidget);
    expect(find.byKey(const ValueKey('detail-favorite-action-Inception')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('detail-favorite-action-Inception')));
    await tester.pumpAndSettle();

    expect(find.textContaining('0 favorit'), findsOneWidget);
  });
}
