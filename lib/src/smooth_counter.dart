import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:smooth_counter/src/controller.dart';
import 'package:smooth_counter/src/formatter.dart';
import 'package:smooth_counter/src/smooth_counter_row.dart';

/// A smooth counter.
class SmoothCounter extends StatefulWidget {
  const SmoothCounter({
    super.key,
    this.count,
    this.hasSeparator = true,
    this.animateOnInit = true,
    this.textStyle,
    this.duration,
    this.sizeDuration = const Duration(milliseconds: 100),
    this.curve,
    this.controller,
    this.prefix,
    this.suffix,
  })  : assert(
          count != null || controller != null,
          'Either count or controller must be non-null.',
        ),
        assert(
          count == null || controller == null,
          'Either count or controller must be set to null.',
        );

  /// The count of the counter.
  /// If null, the count of the controller will be used.
  /// If both count and controller are null, assert will be thrown.
  /// If both count and controller are non-null also it.
  final int? count;

  /// Whether the counter has a separator.
  /// default: true
  final bool hasSeparator;

  /// Whether the counter should animate on init.
  /// default: true
  final bool animateOnInit;

  /// The text style of the counter.
  /// If null, the default text style will be used.
  final TextStyle? textStyle;

  /// The duration of the wheel animation.
  /// If null, the duration of the controller will be used.
  final Duration? duration;

  /// The duration of the size animation when spreading the widget.
  /// default: 100ms
  final Duration sizeDuration;

  /// The curve of the wheel animation.
  /// If null, the curve of the controller will be used.
  final Curve? curve;

  /// The controller of the counter.
  /// If null, a new controller will be created.
  /// If non-null, the count of the controller will be used.
  /// If both count and controller are null, assert will be thrown.
  /// If both count and controller are non-null also it.
  final SmoothCounterController? controller;

  /// The prefix of the counter.
  final String? prefix;

  /// The suffix of the counter.
  final String? suffix;

  @override
  State<SmoothCounter> createState() => _SmoothCounterState();
}

class _SmoothCounterState extends State<SmoothCounter> {
  SmoothCounterController? _controller;
  SmoothCounterController get controller =>
      widget.controller ?? (_controller ??= SmoothCounterController());
  final formatter = Formatter();
  late String numberString = formatter.format(
    controller.count,
    isSeparated: widget.hasSeparator,
  );

  void listen() {
    final number = formatter.format(
      controller.count,
      isSeparated: widget.hasSeparator,
    );
    if (numberString.length != number.length) {
      setState(() => numberString = number);
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(listen);
  }

  @override
  void dispose() {
    controller.removeListener(listen);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.count ?? controller.count;
    if (controller.count != count) {
      controller.count = count;
    }

    final style = (widget.textStyle ?? DefaultTextStyle.of(context).style)
        .copyWith(fontFeatures: const [FontFeature.tabularFigures()]);

    final painter = TextPainter(
      text: TextSpan(
        text: numberString,
        style: style,
      ),
      textDirection: Directionality.of(context),
    )..layout();

    return IgnorePointer(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.prefix != null)
            Text(
              widget.prefix!,
              style: style,
            ),
          AnimatedSize(
            alignment: Alignment.centerRight,
            duration: widget.sizeDuration,
            child: SizedBox.fromSize(
              size: painter.size,
              child: SmoothCounterRow(
                hasSeparator: widget.hasSeparator,
                animateOnInit: widget.animateOnInit,
                textStyle: style,
                duration: widget.controller?.duration ??
                    widget.duration ??
                    controller.duration,
                curve: widget.controller?.curve ??
                    widget.curve ??
                    controller.curve,
                controller: controller,
              ),
            ),
          ),
          if (widget.suffix != null)
            Text(
              widget.suffix!,
              style: style,
            ),
        ],
      ),
    );
  }
}
