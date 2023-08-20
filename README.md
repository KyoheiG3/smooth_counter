# Smooth Counter

Smooth Counter is a plugin that allows you to perform smooth count-ups or count-downs, just like the `Text` widget, with simple arguments.

![example](https://github.com/KyoheiG3/smooth_counter/assets/5707132/87790d65-f642-4bde-9daf-3c9ad24f0e39)

## Getting started

Add `smooth_counter` to your `pubspec.yaml` file.

## Requirements
- Dart 3.0.0+
- flutter 3.10.0+

## Usage

You can either pass `count` directly to the widget or use a `controller`.

### Using count

This is the simplest method. Just pass an int variable and the animation will be performed.

```dart
class _CounterState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter += 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SmoothCounter(
          count: _counter,
          textStyle: Theme.of(context).textTheme.headlineMedium,
        ),
        FilledButton(
          onPressed: _incrementCounter,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
```

### Using controller

If you want to change the animation's `curve` or `duration`, use a `controller`.

```dart
class _CounterState extends State<MyHomePage> {
  final _controller = SmoothCounterController(
    duration: const Duration(milliseconds: 1000),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    _controller.count += 100;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SmoothCounter(
          controller: _controller,
          textStyle: Theme.of(context).textTheme.headlineMedium,
        ),
        FilledButton(
          onPressed: _incrementCounter,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
```

### Separator

It is possible to set whether to show separators for numbers. default is true,

```dart
SmoothCounter(
  count: _counter,
  hasSeparator: false, // or true
),
```

|    | true | false | 
| -- | ---- | ----- |
| result | Separated | Not separated |
| img | ![true](https://github.com/KyoheiG3/smooth_counter/assets/5707132/afaafc1f-6cde-4b4c-8e00-73224d1d0af3) | ![false](https://github.com/KyoheiG3/smooth_counter/assets/5707132/4b6f197b-595f-430e-8ba6-d1eb5eb2b0d0) |

### Animation on initial display

It is possible to set whether to perform scroll animation of the counter when it is built for the first time. default is true,

```dart
SmoothCounter(
  count: _counter,
  animateOnInit: false, // or true
),
```

|    | true | false | 
| -- | ---- | ----- |
| result | Animate | No animation |
| img | ![true](https://github.com/KyoheiG3/smooth_counter/assets/5707132/b150619a-9b9b-4475-972a-03484b1c9a2c) | ![false](https://github.com/KyoheiG3/smooth_counter/assets/5707132/405b6630-227e-45b5-ba85-df5ff9f18706) |

## License
Smooth Counter is released under the [BSD-3-Clause License](./LICENSE).
