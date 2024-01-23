import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_elastic_list_view/flutter_elastic_list_view.dart';
import 'package:flutter_elastic_list_view/src/utils/elastic_list_view_utils.dart';
import 'package:flutter_test/flutter_test.dart';

/// The main entry point for running tests.
void main() {
  // Testing group for [ElasticListView].
  group('ElasticListView', () {
    // Test case: Ensure an AssertionError is thrown if elasticityFactor is zero or negative.
    test('throws AssertionError if elasticityFactor is zero or negative', () {
      expect(
        () => ElasticListView(elasticityFactor: -10, children: const []),
        throwsAssertionError,
      );
    });

    // Test case: Ensure an AssertionError is thrown if animationDuration is zero or negative.
    test('throws AssertionError if animationDuration is zero or negative', () {
      expect(
          () => ElasticListView(
              animationDuration: Duration.zero, children: const []),
          throwsAssertionError);

      expect(
          () => ElasticListView(
              animationDuration: const Duration(milliseconds: -100),
              children: const []),
          throwsAssertionError);
    });

    // Test case: Ensure default values are used when parameters are not provided.
    test('uses default values when parameters are not provided', () {
      const defaultElasticityFactor = 4;
      const defaultAnimationDuration = Duration(milliseconds: 200);
      final listView = ElasticListView(children: const []);

      expect(listView.elasticityFactor, equals(defaultElasticityFactor));
      expect(listView.animationDuration, equals(defaultAnimationDuration));
    });
  });

  // Testing group for [ElasticListViewUtils].
  group('ElasticListViewUtils', () {
    // Test case: Ensure elasticity is calculated based on controller value and scroll speed.
    test('calculates elasticity based on controller value and scroll speed',
        () {
      final controller = AnimationController(vsync: const TestVSync());

      final minElasticity =
          ElasticListViewUtils.calculateElasticity(controller, 0);
      expect(minElasticity, 1.0);

      final elasticity1 =
          ElasticListViewUtils.calculateElasticity(controller, 1);

      controller.value = 0.5;

      final elasticity2 =
          ElasticListViewUtils.calculateElasticity(controller, 1.5);
      expect(elasticity2, greaterThan(elasticity1));

      final elasticity3 =
          ElasticListViewUtils.calculateElasticity(controller, 2);
      expect(elasticity3, greaterThan(elasticity2));
    });

    // Test case: Ensure calculateSimulation returns a valid SpringSimulation.
    test('calculateSimulation returns a valid SpringSimulation', () {
      const overscroll = 100.0;
      final simulation = ElasticListViewUtils.calculateSimulation(overscroll);
      expect(simulation, isA<SpringSimulation>());
    });

    // Test case: Ensure calculateElasticity returns a valid elasticity value.
    test('calculateElasticity returns a valid elasticity value', () {
      final controller = AnimationController(vsync: const TestVSync());
      const scrollSpeed = 2.0;
      final elasticity =
          ElasticListViewUtils.calculateElasticity(controller, scrollSpeed);
      expect(
          elasticity,
          inInclusiveRange(ElasticListViewUtils.minElasticity,
              ElasticListViewUtils.maxElasticity));
    });

    // Test case: Ensure calculateElasticity returns correct value for various inputs.
    test('calculateElasticity returns correct value for various inputs', () {
      final controller = AnimationController(vsync: const TestVSync());

      controller.value = 0;
      var elasticity = ElasticListViewUtils.calculateElasticity(controller, 0);

      expect(elasticity, equals(1.0));

      controller.value = 0.5;
      elasticity = ElasticListViewUtils.calculateElasticity(controller, 0);

      expect(elasticity, equals(1.1));

      controller.value = 0;
      elasticity = ElasticListViewUtils.calculateElasticity(controller, 2);

      expect(elasticity, equals(3.0));

      controller.value = 0.5;
      elasticity = ElasticListViewUtils.calculateElasticity(controller, 2);

      expect(elasticity, equals(3.0));
    });
  });
}
