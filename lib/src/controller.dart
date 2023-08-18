import 'package:flutter/widgets.dart';

class SmoothCounterController extends ValueNotifier<int> {
  SmoothCounterController({
    this.initialCount = 0,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutCubic,
  }) : super(initialCount);

  final int initialCount;
  final Duration duration;
  final Curve curve;

  int get count => value;
  set count(int newValue) => value = newValue;

  @protected
  @override
  int get value => super.value;
  @protected
  @override
  set value(int newValue) => super.value = newValue;
}
