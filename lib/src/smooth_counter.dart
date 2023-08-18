import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:smooth_counter/src/controller.dart';
import 'package:smooth_counter/src/formatter.dart';
import 'package:smooth_counter/src/smooth_counter_row.dart';

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
  })  : assert(
          count != null || controller != null,
          'Either count or controller must be non-null.',
        ),
        assert(
          count == null || controller == null,
          'Either count or controller must be set to null.',
        );

  final int? count;
  final bool hasSeparator;
  final bool animateOnInit;
  final TextStyle? textStyle;
  final Duration? duration;
  final Duration sizeDuration;
  final Curve? curve;
  final SmoothCounterController? controller;

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
      text: TextSpan(text: numberString, style: style),
      textDirection: Directionality.of(context),
    )..layout();

    return IgnorePointer(
      child: AnimatedSize(
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
            curve: widget.controller?.curve ?? widget.curve ?? controller.curve,
            controller: controller,
          ),
        ),
      ),
    );
  }
}
