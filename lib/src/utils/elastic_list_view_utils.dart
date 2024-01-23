import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// Utility class providing methods for elastic overscroll behavior in a ListView.
class ElasticListViewUtils {
  /// Minimum allowed elasticity factor.
  static const double minElasticity = 1.0;

  /// Maximum allowed elasticity factor.
  static const double maxElasticity = 3.0;

  /// Factor to adjust the scroll speed for elasticity calculation.
  static const double scrollSpeedFactor = 1.2;

  /// Factor to adjust the animation controller value for elasticity calculation.
  static const double controllerValueFactor = 0.2;

  /// Calculates the overscroll amount based on the current scroll offset.
  ///
  /// Returns a positive value if overscrolling at the end, or a negative value
  /// if overscrolling at the beginning.
  static double calculateOverscroll(ScrollController scrollController) {
    final currentOffset = scrollController.offset;
    return currentOffset < 0.0
        ? currentOffset
        : currentOffset - scrollController.position.maxScrollExtent;
  }

  /// Calculates the scroll speed based on the change in offset and time delta.
  ///
  /// This method is used to determine how fast the user is scrolling.
  static double calculateScrollSpeed(ScrollController scrollController,
      double previousOffset, DateTime previousTimestamp) {
    final now = DateTime.now();
    final timeDelta = now.difference(previousTimestamp).inMilliseconds;
    final scrollSpeed = (scrollController.offset - previousOffset) / timeDelta;
    return scrollSpeed;
  }

  /// Calculates a spring simulation for the overscroll behavior.
  static SpringSimulation calculateSimulation(double overscroll) {
    return SpringSimulation(
      const SpringDescription(mass: 1.0, stiffness: 300.0, damping: 20.0),
      0.0,
      overscroll,
      0.0,
    );
  }

  /// Calculates the current elasticity based on controller value and scroll speed.
  ///
  /// The elasticity is a factor applied to the overscroll effect.
  static double calculateElasticity(
      AnimationController controller, double scrollSpeed) {
    return (minElasticity +
            controller.value * controllerValueFactor +
            scrollSpeed.abs() * scrollSpeedFactor)
        .clamp(minElasticity, maxElasticity);
  }
}
