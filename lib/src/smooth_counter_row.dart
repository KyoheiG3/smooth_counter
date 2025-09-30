import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_counter/src/controller.dart';
import 'package:smooth_counter/src/counter_wheel.dart';

/// A row of [CounterWheel]s.
class SmoothCounterRow extends StatefulWidget {
  const SmoothCounterRow({
    super.key,
    this.textStyle,
    required this.duration,
    required this.curve,
    required this.animateOnInit,
    required this.controller,
    required this.format,
  });

  /// The text style of the counter.
  /// If null, the default text style will be used.
  final TextStyle? textStyle;

  /// The duration of the wheel animation.
  final Duration duration;

  /// The curve of the wheel animation.
  final Curve curve;

  /// Whether the wheel should animate on init.
  final bool animateOnInit;

  /// The controller of the counter.
  final SmoothCounterController controller;

  /// The number format for formatting the counter value.
  /// Used to convert the count into a formatted string with separators, decimal points, etc.
  final NumberFormat format;

  @override
  State createState() => _SmoothCounterRowState();
}

class _SmoothCounterRowState extends State<SmoothCounterRow> {
  void listen() => setState(() {});

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(listen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final number = widget.format.format(widget.controller.count);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var index = 0; index < number.length; index++)
          if (int.tryParse(number[index]) != null)
            Expanded(
              key: ValueKey(number.length - index),
              child: CounterWheel(
                textStyle: widget.textStyle,
                digits: 1 - index,
                duration: widget.duration,
                curve: widget.curve,
                animateOnInit: widget.animateOnInit,
                itemIndex: int.parse(
                  number
                      .substring(0, index + 1)
                      .replaceAll(RegExp(r'[^0-9]'), ''),
                ),
              ),
            )
          else
            Text(number[index], style: widget.textStyle),
      ],
    );
  }
}
