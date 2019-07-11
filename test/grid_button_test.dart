import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';

void main() {
  testWidgets('widget test', (WidgetTester tester) async {
    var keyA = UniqueKey();
    var keyB = UniqueKey();
    var value;
    var gridButton = GridButton(
      onPressed: (String val) {
        value = val;
      },
      items: [
        [
          GridButtonItem(title: "a", key: keyA),
          GridButtonItem(title: "b", key: keyB, value: "100"),
          GridButtonItem(title: "c"),
        ],
        [GridButtonItem(title: "d")],
        [
          GridButtonItem(title: "e"),
          GridButtonItem(title: "f"),
          GridButtonItem(title: "g"),
          GridButtonItem(title: "h")
        ],
      ],
    );
    var app = MaterialApp(
      home: gridButton,
    );
    await tester.pumpWidget(app);
    await tester.tap(find.byKey(keyA));
    expect(value, equals("a"));
    await tester.tap(find.byKey(keyB));
    expect(value, equals("100"));
  });
}
