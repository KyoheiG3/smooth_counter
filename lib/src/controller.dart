import 'package:flutter/widgets.dart';

/// A controller for a [SmoothCounter].
class SmoothCounterController extends ValueNotifier<int> {
  SmoothCounterController({
    this.initialCount = 0,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutCubic,
  }) : super(initialCount);

  /// The initial count of the counter.
  /// default: 0
  final int initialCount;

  /// The duration of the animation.
  /// default: 500ms
  final Duration duration;

  /// The curve of the animation.
  /// default: easeOutCubic
  final Curve curve;

  /// The current count of the counter.
  /// Same as [value].
  int get count => value;

  /// Sets the current count of the counter.
  /// Same as [value].
  set count(int newValue) => value = newValue;

  @protected
  @override
  int get value => super.value;
  @protected
  @override
  set value(int newValue) => super.value = newValue;
}
