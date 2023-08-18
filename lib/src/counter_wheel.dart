import 'package:flutter/widgets.dart';

class CounterWheel extends StatefulWidget {
  const CounterWheel({
    super.key,
    this.textStyle,
    required this.digits,
    required this.duration,
    required this.curve,
    required this.itemIndex,
    required this.animateOnInit,
  });

  final TextStyle? textStyle;
  final int digits;
  final Duration duration;
  final Curve curve;
  final int itemIndex;
  final bool animateOnInit;

  @override
  State<CounterWheel> createState() => _CounterWheelState();
}

class _CounterWheelState extends State<CounterWheel> {
  late final controller = FixedExtentScrollController(
    initialItem: widget.animateOnInit ? 0 : widget.itemIndex,
  );
  late bool initialized = widget.digits == 1 || !widget.animateOnInit;
  int? selectedItem;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (controller.hasClients && selectedItem != widget.itemIndex) {
        selectedItem = widget.itemIndex;
        await controller.animateToItem(
          widget.itemIndex,
          duration: widget.duration,
          curve: widget.curve,
        );
        initialized = true;
      }
    });

    return LayoutBuilder(
      builder: (_, constraints) {
        return ListWheelScrollView.useDelegate(
          itemExtent: constraints.maxHeight,
          controller: controller,
          physics: const FixedExtentScrollPhysics(),
          useMagnifier: true,
          childDelegate: CounterWheelChildLoopingListDelegate(
            skipFirstItem: !initialized,
            children: List.generate(10, (i) => Text(i.toString(), style: widget.textStyle)),
          ),
        );
      },
    );
  }
}

class CounterWheelChildLoopingListDelegate extends ListWheelChildLoopingListDelegate {
  CounterWheelChildLoopingListDelegate({
    this.skipFirstItem = true,
    required super.children,
  });

  late final List<Widget> reversedChildren = [children[0], ...children.skip(1).toList().reversed];
  final bool skipFirstItem;

  @override
  Widget? build(BuildContext context, int index) {
    if (children.isEmpty || (index == 0 && skipFirstItem)) {
      return null;
    }
    final list = index.isNegative ? reversedChildren : children;
    return IndexedSemantics(index: index, child: list[index % children.length]);
  }
}
