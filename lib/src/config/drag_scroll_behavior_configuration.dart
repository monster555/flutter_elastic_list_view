import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Custom scroll behavior that allows dragging with both touch and mouse input.
///
/// This class extends [MaterialScrollBehavior] to customize the scroll behavior
/// and specifies the set of pointer devices that can be used for dragging,
/// including touch and mouse devices.
class DragScrollBehavior extends MaterialScrollBehavior {
  /// Returns a set of pointer devices allowed for dragging.
  ///
  /// This implementation includes both touch and mouse devices for dragging.
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
