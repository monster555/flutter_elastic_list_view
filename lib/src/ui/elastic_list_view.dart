import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_elastic_list_view/src/config/drag_scroll_behavior_configuration.dart';
import 'package:flutter_elastic_list_view/src/utils/elastic_list_view_utils.dart';

/// A customizable [ListView] with an elastic effect.
///
/// This widget provides an extended [ListView] with additional features such as
/// elastic scrolling, customizable animation curve, and duration.
///
/// The [ElasticListView] allows you to customize various aspects, including
/// scroll direction, controller, item extent, itemBuilder, and more.
class ElasticListView extends StatefulWidget {
  /// The axis along which the [ElasticListView] scrolls.
  final Axis scrollDirection;

  /// Whether the [ElasticListView] scrolls in the reverse direction.
  final bool reverse;

  /// An optional controller for the [ElasticListView].
  final ScrollController? controller;

  /// Whether this [ElasticListView] is the primary scroll view associated with the parent.
  final bool? primary;

  /// The physics of the [ElasticListView].
  final ScrollPhysics? physics;

  /// Whether the [ElasticListView] should wrap its content or not.
  final bool shrinkWrap;

  /// The padding for the [ElasticListView].
  final EdgeInsetsGeometry? padding;

  /// The size of each item in the [ElasticListView].
  final double? itemExtent;

  /// A builder that returns the size of each item in the [ElasticListView].
  final ItemExtentBuilder? itemExtentBuilder;

  /// A prototype of the item that is used for measuring its size.
  final Widget? prototypeItem;

  /// Called to build children for the [ElasticListView].
  final IndexedWidgetBuilder itemBuilder;

  /// Callback to find the index of a child based on its key.
  final ChildIndexGetter? findChildIndexCallback;

  /// The number of children that the [ElasticListView] should contain.
  final int? itemCount;

  /// Whether to add automatic keep-alive widgets to the children of the [ElasticListView].
  final bool addAutomaticKeepAlives;

  /// Whether to add repaint boundaries to the children of the [ElasticListView].
  final bool addRepaintBoundaries;

  /// Whether to add semantic indexes to the children of the [ElasticListView].
  final bool addSemanticIndexes;

  /// The extent of the cache in pixels.
  final double? cacheExtent;

  /// The number of children that are taken into account for semantic indexing.
  final int? semanticChildCount;

  /// The drag start behavior for the [ElasticListView].
  final DragStartBehavior dragStartBehavior;

  /// The keyboard dismissal behavior for the [ElasticListView].
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// An identifier to use for state restoration.
  final String? restorationId;

  /// The clip behavior for the [ElasticListView].
  final Clip clipBehavior;

  /// The curve for the elastic scrolling animation.
  final Curve curve;

  /// The duration of the elastic scrolling animation.
  final Duration animationDuration;

  /// Enables drag scrolling behavior for the [ElasticListView].
  final bool enableDragScrolling;

  /// The elasticity factor for the [ElasticListView].
  final int elasticityFactor;

  /// A builder that returns a separator widget for the [ElasticListView].
  final IndexedWidgetBuilder? separatorBuilder;

  /// List of children for the [ElasticListView].
  final List<Widget>? children;

  /// [ElasticListView._base] is a private constructor that provides a base for
  /// the other constructors of the [ElasticListView] widget.
  ///
  /// This constructor is not meant to be directly invoked. Instead, it's used
  /// internally by the other constructors ([ElasticListView], [ElasticListView.builder],
  /// and [ElasticListView.separated]) to provide the core functionality of the
  /// [ElasticListView] widget.
  ///
  /// The [itemBuilder` function is called with the current context and index,
  /// and it should return a widget that corresponds to the item at that index
  /// in the list.
  ///
  /// The [itemCount` is the number of items in the list and must be provided.
  ///
  /// The [elasticityFactor` controls the elasticity of the dynamic padding effect
  /// during scrolling.
  ///
  /// The [separatorBuilder] function is similar to [itemBuilder], but it's used
  /// for creating separator widgets in the [ElasticListView.separated] constructor.
  ///
  /// This constructor also includes assertions to ensure that the [elasticityFactor]
  /// is greater than or equal to 0, and the [animationDuration] is greater than
  /// or equal to 100 ms for optimal user experience.
  const ElasticListView._base({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.itemExtent,
    this.itemExtentBuilder,
    this.prototypeItem,
    required this.itemBuilder,
    this.children,
    this.findChildIndexCallback,
    required this.itemCount,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.curve = Curves.easeOut,
    this.animationDuration = const Duration(milliseconds: 200),
    this.enableDragScrolling = true,
    this.elasticityFactor = 4,
    this.separatorBuilder,
  })  : assert(elasticityFactor >= 0,
            'Elasticity factor must be greater than or equal to 0.'),
        assert(animationDuration >= const Duration(milliseconds: 100),
            'Animation duration should be greater than or equal to 100 ms for optimal user experience.');

  /// [ElasticListView] is a customizable list view widget that provides a unique
  /// scrolling experience.
  ///
  /// Unlike a standard [ListView], [ElasticListView] adds dynamic padding when
  /// scrolling, which varies depending on the scroll speed. This is controlled
  /// by the [elasticityFactor] parameter.
  ///
  /// The [curve] and [animationDuration] parameters allow you to customize the
  /// animation of the dynamic padding effect.
  ///
  /// Here's an example of how to use [ElasticListView]
  /// ```dart
  /// ElasticListView(
  ///   children: List.generate(
  ///     50,
  ///     (index) {
  ///       return Container(
  ///         height: 100,
  ///         margin: const EdgeInsets.all(8),
  ///         decoration: BoxDecoration(
  ///           color: Colors.red[(index % 9 + 1) * 100],
  ///           borderRadius: BorderRadius.circular(16),
  ///         ),
  ///       );
  ///     },
  ///   ),
  /// )
  /// ```
  ElasticListView({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    double? itemExtent,
    ItemExtentBuilder? itemExtentBuilder,
    Widget? prototypeItem,
    required List<Widget> children,
    ChildIndexGetter? findChildIndexCallback,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    Curve curve = Curves.easeOut,
    Duration animationDuration = const Duration(milliseconds: 200),
    bool enableDragScrolling = true,
    int elasticityFactor = 4,
  }) : this._base(
          key: key,
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding,
          itemExtent: itemExtent,
          itemExtentBuilder: itemExtentBuilder,
          prototypeItem: prototypeItem,
          itemBuilder: (_, int index) => children[index],
          findChildIndexCallback: findChildIndexCallback,
          itemCount: children.length,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          cacheExtent: cacheExtent,
          semanticChildCount: semanticChildCount,
          dragStartBehavior: dragStartBehavior,
          keyboardDismissBehavior: keyboardDismissBehavior,
          restorationId: restorationId,
          clipBehavior: clipBehavior,
          curve: curve,
          animationDuration: animationDuration,
          enableDragScrolling: enableDragScrolling,
          elasticityFactor: elasticityFactor,
        );

  /// [ElasticListView.builder] is a constructor that creates a list view with
  /// items that are created on demand.
  ///
  /// This constructor is suitable for list views with a large (or infinite) number
  /// of children because the builder is called only for those children that are
  /// actually visible.
  ///
  /// The [itemBuilder] function is called with the current context and index,
  /// and it should return a widget that corresponds to the item at that index
  /// in the list.
  ///
  /// The [itemCount] is the number of items in the list and must be provided.
  ///
  /// The [elasticityFactor] controls the elasticity of the dynamic padding
  /// effect during scrolling.
  ///
  /// Here's an example of how to use [ElasticListView.builder]
  /// ```dart
  /// ElasticListView.builder(
  ///   itemCount: 50,
  ///   itemBuilder: (context, index) {
  ///     return Container(
  ///       height: 100,
  ///       margin: const EdgeInsets.all(8),
  ///       decoration: BoxDecoration(
  ///         color: Colors.green[(index % 9 + 1) * 100],
  ///         borderRadius: BorderRadius.circular(16),
  ///       ),
  ///     );
  ///   },
  /// )
  /// ```
  const ElasticListView.builder({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    double? itemExtent,
    ItemExtentBuilder? itemExtentBuilder,
    Widget? prototypeItem,
    required IndexedWidgetBuilder itemBuilder,
    ChildIndexGetter? findChildIndexCallback,
    required int itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    Curve curve = Curves.easeOut,
    Duration animationDuration = const Duration(milliseconds: 200),
    bool enableDragScrolling = true,
    int elasticityFactor = 4,
  }) : this._base(
          key: key,
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding,
          itemExtent: itemExtent,
          itemExtentBuilder: itemExtentBuilder,
          prototypeItem: prototypeItem,
          itemBuilder: itemBuilder,
          findChildIndexCallback: findChildIndexCallback,
          itemCount: itemCount,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          cacheExtent: cacheExtent,
          semanticChildCount: semanticChildCount,
          dragStartBehavior: dragStartBehavior,
          keyboardDismissBehavior: keyboardDismissBehavior,
          restorationId: restorationId,
          clipBehavior: clipBehavior,
          curve: curve,
          animationDuration: animationDuration,
          enableDragScrolling: enableDragScrolling,
          elasticityFactor: elasticityFactor,
        );

  /// [ElasticListView.separated] is a constructor that creates a list view with
  /// items and separators that are created on demand.
  ///
  /// This constructor is suitable for list views with a large number of children
  /// as the builder is called only for those children that are actually visible.
  ///
  /// The [itemBuilder] function is called with the current context and index,
  /// and it should return a widget that corresponds to the item at that index in
  /// the list.
  ///
  /// The [separatorBuilder] function is similar to [itemBuilder], but it's used
  /// for creating separator widgets.
  ///
  /// The [itemCount] is the number of items in the list and must be provided.
  ///
  /// The [elasticityFactor] controls the elasticity of the dynamic padding effect
  /// during scrolling.
  ///
  /// Here's an example of how to use [ElasticListView.separated]
  /// ```dart
  /// ElasticListView.separated(
  ///   itemCount: 50,
  ///   separatorBuilder: (context, index) => const Divider(),
  ///   itemBuilder: (context, index) {
  ///     return Container(
  ///       height: 100,
  ///       margin: const EdgeInsets.all(8),
  ///       decoration: BoxDecoration(
  ///         color: Colors.blue[(index % 9 + 1) * 100],
  ///         borderRadius: BorderRadius.circular(16),
  ///       ),
  ///     );
  ///   },
  /// )
  /// ```
  const ElasticListView.separated({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    double? itemExtent,
    ItemExtentBuilder? itemExtentBuilder,
    Widget? prototypeItem,
    required IndexedWidgetBuilder itemBuilder,
    ChildIndexGetter? findChildIndexCallback,
    required int itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    Curve curve = Curves.easeOut,
    Duration animationDuration = const Duration(milliseconds: 200),
    bool enableDragScrolling = true,
    int elasticityFactor = 4,
    required IndexedWidgetBuilder separatorBuilder,
  }) : this._base(
          key: key,
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding,
          itemExtent: itemExtent,
          itemExtentBuilder: itemExtentBuilder,
          prototypeItem: prototypeItem,
          itemBuilder: itemBuilder,
          findChildIndexCallback: findChildIndexCallback,
          itemCount: itemCount,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          cacheExtent: cacheExtent,
          semanticChildCount: semanticChildCount,
          dragStartBehavior: dragStartBehavior,
          keyboardDismissBehavior: keyboardDismissBehavior,
          restorationId: restorationId,
          clipBehavior: clipBehavior,
          curve: curve,
          animationDuration: animationDuration,
          enableDragScrolling: enableDragScrolling,
          elasticityFactor: elasticityFactor,
          separatorBuilder: separatorBuilder,
        );

  @override
  ElasticListViewState createState() => ElasticListViewState();
}

class ElasticListViewState extends State<ElasticListView>
    with SingleTickerProviderStateMixin {
  /// Animation controller for managing elastic overscroll animation.
  late AnimationController _controller;

  /// Scroll controller for the underlying list view.
  late ScrollController _scrollController;

  /// Current elasticity factor for overscroll behavior.
  double _elasticity = 1.0;

  /// Previous scroll offset to calculate scroll speed.
  double _previousOffset = 0.0;

  /// Timestamp of the previous scroll update.
  DateTime _previousTimestamp = DateTime.now();

  /// Getter for the current elasticity factor.
  double get elasticity => _elasticity;

  ScrollController get scrollController => _scrollController;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    // Dispose of the animation and scroll controllers to release resources.
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// Padding for the [ElasticListView] based on the current elasticity.
  ///
  /// This method calculates the padding for the [ElasticListView] based on the
  /// current elasticity. It uses the `widget.scrollDirection` to determine the
  /// padding for the vertical or horizontal axis.
  EdgeInsets get _padding => widget.scrollDirection == Axis.vertical
      ? EdgeInsets.symmetric(
          vertical: (elasticity - 1) * widget.elasticityFactor)
      : EdgeInsets.symmetric(
          horizontal: (elasticity - 1) * widget.elasticityFactor);

  @override
  Widget build(BuildContext context) {
    return widget.separatorBuilder != null
        ? ScrollConfiguration(
            behavior: widget.enableDragScrolling
                ? DragScrollBehavior()
                : const ScrollBehavior(),
            child: NotificationListener<UserScrollNotification>(
              onNotification: _notificationHandler,
              child: ListView.separated(
                scrollDirection: widget.scrollDirection,
                reverse: widget.reverse,
                controller: _scrollController,
                primary: widget.primary,
                physics: widget.physics,
                shrinkWrap: widget.shrinkWrap,
                padding: widget.padding,
                itemCount: widget.itemCount!,
                itemBuilder: (context, index) {
                  return AnimatedPadding(
                    duration: widget.animationDuration,
                    curve: widget.curve,
                    padding: _padding,
                    child: widget.itemBuilder(context, index),
                  );
                },
                separatorBuilder: (context, index) {
                  return AnimatedPadding(
                    duration: widget.animationDuration,
                    curve: widget.curve,
                    padding: _padding,
                    child: widget.separatorBuilder!(context, index),
                  );
                },
                addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
                addRepaintBoundaries: widget.addRepaintBoundaries,
                addSemanticIndexes: widget.addSemanticIndexes,
                cacheExtent: widget.cacheExtent,
                dragStartBehavior: widget.dragStartBehavior,
                keyboardDismissBehavior: widget.keyboardDismissBehavior,
                restorationId: widget.restorationId,
                clipBehavior: widget.clipBehavior,
              ),
            ),
          )
        : ScrollConfiguration(
            behavior: widget.enableDragScrolling
                ? DragScrollBehavior()
                : const ScrollBehavior(),
            child: NotificationListener<UserScrollNotification>(
              onNotification: _notificationHandler,
              child: ListView.builder(
                scrollDirection: widget.scrollDirection,
                reverse: widget.reverse,
                controller: _scrollController,
                primary: widget.primary,
                physics: widget.physics,
                shrinkWrap: widget.shrinkWrap,
                padding: widget.padding,
                itemExtent: widget.itemExtent,
                itemCount: widget.itemCount,
                itemBuilder: (context, index) {
                  return AnimatedPadding(
                    duration: widget.animationDuration,
                    curve: widget.curve,
                    padding: _padding,
                    child: widget.itemBuilder(context, index),
                  );
                },
                addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
                addRepaintBoundaries: widget.addRepaintBoundaries,
                addSemanticIndexes: widget.addSemanticIndexes,
                cacheExtent: widget.cacheExtent,
                semanticChildCount: widget.semanticChildCount,
                dragStartBehavior: widget.dragStartBehavior,
                keyboardDismissBehavior: widget.keyboardDismissBehavior,
                restorationId: widget.restorationId,
                clipBehavior: widget.clipBehavior,
              ),
            ),
          );
  }

  /// Handles scroll events to provide elastic overscroll behavior.
  ///
  /// This method is responsible for determining if the scroll position is at its
  /// limits (maximum or minimum) and resetting the elasticity if so. If the scroll
  /// is within the valid range, it calculates overscroll using the
  /// [ElasticListViewUtils.calculateOverscroll] method and creates a simulation
  /// for elastic behavior. The [_controller] is then animated with the calculated
  /// simulation, and the elasticity is updated using the [_updateElasticity] method.
  void _handleScroll() {
    // Given the variability in scroll event handling across devices, this condition
    // ensures that we correctly identify when the user has reached the list's boundaries.
    // This applies regardless of whether the user is scrolling by dragging, swiping,
    // using the mouse wheel, or manipulating the scrollbars.
    if (!_scrollController.position.outOfRange &&
        (_scrollController.offset >=
                _scrollController.position.maxScrollExtent ||
            _scrollController.offset <=
                _scrollController.position.minScrollExtent)) {
      // Reset elasticity if at scroll limits
      _resetElasticity();
    } else {
      // Calculate overscroll and simulate elastic behavior
      final overscroll =
          ElasticListViewUtils.calculateOverscroll(_scrollController);
      final simulation = ElasticListViewUtils.calculateSimulation(overscroll);

      // Animate the controller with the calculated simulation
      _controller.animateWith(simulation);

      // Update the elasticity based on scroll speed
      _updateElasticity();
    }
  }

  /// Handles user scroll notifications and resets elasticity on scroll completion.
  ///
  /// This method is a callback function designed to handle [UserScrollNotification]
  /// instances, specifically checking for an idle scroll direction. When the scroll
  /// direction becomes idle and there is no ongoing scroll activity, it triggers
  /// the `_resetElasticity` method to reset the elasticity of the [ElasticListView].
  ///
  /// It utilizes the [SchedulerBinding] to schedule a callback for the next frame
  /// to ensure that the reset occurs after the current frame is complete.
  bool _notificationHandler(UserScrollNotification notification) {
    if (notification.direction == ScrollDirection.idle &&
        _scrollController.position.isScrollingNotifier is! IdleScrollActivity) {
      // Schedule a callback to reset elasticity after the current frame
      SchedulerBinding.instance.addPostFrameCallback((_) => _resetElasticity());
    }
    // Continue propagating notifications
    return false;
  }

  /// Resets the elasticity of the [ElasticListView] to its default state.
  ///
  /// Call this method when you want to reset the elastic effect, such as on
  /// user interactions that should clear any ongoing elastic behavior.
  void _resetElasticity() {
    setState(() {
      // Set the controller's value to 0.0 to reset elasticity
      _controller.value = 0.0;

      // Reset the elasticity to its default value (1.0)
      _elasticity = 1.0;
    });
  }

  /// Updates the elasticity of the [ElasticListView] based on the scrolling speed.
  ///
  /// This method calculates the scroll speed and updates the elasticity value
  /// for creating the elastic effect during scrolling. It takes into account
  /// the time elapsed since the last update to calculate the scroll speed.
  ///
  /// If the time delta between updates is zero, the method avoids division by
  /// zero to prevent potential issues. The calculated elasticity is then set,
  /// and the widget is updated to reflect the changes.
  ///
  /// This method should be called whenever there is a change in the scrolling
  /// behavior to ensure the elasticity is accurately represented in the UI.
  void _updateElasticity() {
    // Get the current timestamp
    final DateTime now = DateTime.now();

    // Calculate the time difference between the current and previous timestamps
    final Duration timeDelta = now.difference(_previousTimestamp);

    // Check for zero timeDelta to avoid division by zero
    if (timeDelta.inMilliseconds != 0) {
      // Calculate the scroll speed based on controller, offset, and timestamp
      final double scrollSpeed = ElasticListViewUtils.calculateScrollSpeed(
        _scrollController,
        _previousOffset,
        _previousTimestamp,
      );

      // Update the previous offset and timestamp
      _previousOffset = _scrollController.offset;
      _previousTimestamp = now;

      // Calculate the elasticity based on the controller and scroll speed
      _elasticity =
          ElasticListViewUtils.calculateElasticity(_controller, scrollSpeed);

      // Trigger a widget update to reflect the changes in elasticity
      setState(() {});
    }
  }
}
