import 'package:flutter/material.dart';
import 'package:flutter_elastic_list_view/flutter_elastic_list_view.dart';
import 'package:flutter_test/flutter_test.dart';

/// The main entry point for running widget tests.
void main() {
  late Widget widget;

  setUp(() {
    widget = MaterialApp(
      home: ElasticListView.builder(
        itemCount: 50,
        itemBuilder: (BuildContext context, int index) => Material(
          child: ListTile(
            title: Text('Item $index'),
          ),
        ),
      ),
    );
  });
  // Testing group for [ElasticListView].
  group('ElasticListView', () {
    // Test case: Ensure that ElasticListView renders children correctly.
    testWidgets('renders children correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ElasticListView(
              children: [
                Container(
                  height: 100,
                  color: Colors.red,
                ),
                Container(
                  height: 100,
                  color: Colors.blue,
                ),
                Container(
                  height: 100,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ),
      );

      // Expecting to find three Container widgets and one ElasticListView widget.
      expect(find.byType(Container), findsNWidgets(3));
      expect(find.byType(ElasticListView), findsOneWidget);
    });

    // Test case: Ensure that ElasticListView.builder renders children correctly.
    testWidgets('builder renders children correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ElasticListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  color: Colors.red,
                );
              },
            ),
          ),
        ),
      );

      // Expecting to find three Container widgets and one ElasticListView widget.
      expect(find.byType(Container), findsNWidgets(3));
      expect(find.byType(ElasticListView), findsOneWidget);
    });

    // Test case: Animate scroll and verify elasticity.
    testWidgets('Animate scroll, verify elasticity',
        (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      final itemFinder = find.byType(ElasticListView);

      final state = tester.state(itemFinder) as ElasticListViewState;

      // Initial elasticity should be 1.0.
      expect(state.elasticity, equals(1.0));

      // Simulating a scroll gesture.
      final gesture = await tester.startGesture(const Offset(0, 50));
      await gesture.moveBy(const Offset(0, -50));
      await tester.pump();

      // Elasticity should be greater than 1.0 during scrolling.
      expect(state.elasticity, greaterThan(1.0));

      // Releasing the scroll gesture and waiting for settling.
      await gesture.up();
      await tester.pumpAndSettle();

      // Elasticity should return to 1.0 after settling.
      expect(state.elasticity, equals(1.0));
    });

    // Test case: Verify elasticity remains 1.0 when scrolling at the start.
    testWidgets('Verify elasticity remains 1.0 when scrolling at start',
        (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      final itemFinder = find.byType(ElasticListView);

      // Getting the state of the ElasticListView.
      final state = tester.state(itemFinder) as ElasticListViewState;

      // Initial elasticity should be 1.0.
      expect(state.elasticity, equals(1.0));

      // Simulating a scroll gesture at the start.
      final gesture = await tester.startGesture(const Offset(0, 50));
      await gesture.moveBy(const Offset(0, 50));
      await tester.pump();

      // Elasticity should remain 1.0 when scrolling at the start.
      expect(state.elasticity, equals(1.0));
    });
  });
}
