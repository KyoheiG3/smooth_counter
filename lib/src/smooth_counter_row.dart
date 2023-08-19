import 'package:flutter/widgets.dart';
import 'package:smooth_counter/src/controller.dart';
import 'package:smooth_counter/src/counter_wheel.dart';
import 'package:smooth_counter/src/formatter.dart';

/// A row of [CounterWheel]s.
class SmoothCounterRow extends StatefulWidget {
  const SmoothCounterRow({
    super.key,
    required this.hasSeparator,
    this.textStyle,
    required this.duration,
    required this.curve,
    required this.animateOnInit,
    required this.controller,
  });

  /// Whether the counter has a separator.
  final bool hasSeparator;

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

  @override
  State createState() => _SmoothCounterRowState();
}

class _SmoothCounterRowState extends State<SmoothCounterRow> {
  final formatter = Formatter();

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
    final number = formatter.format(
      widget.controller.count,
      isSeparated: widget.hasSeparator,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var index = 0; index < number.length; index++)
          if (int.tryParse(number[index]) != null)
            Expanded(
              key: ValueKey(number.length - index),
              child: CounterWheel(
                textStyle: widget.textStyle,
                digits: number.length - index,
                duration: widget.duration,
                curve: widget.curve,
                animateOnInit: widget.animateOnInit,
                itemIndex:
                    formatter.parse(number.substring(0, index + 1)).toInt(),
              ),
            )
          else
            Text(number[index], style: widget.textStyle),
      ],
    );
  }
}
