# Smooth Counter

Smooth Counter is a plugin that allows you to perform smooth count-ups or count-downs, just like the `Text` widget, with simple arguments.

<img width="195" alt="example" src="https://github.com/KyoheiG3/smooth_counter/assets/5707132/20e90a28-c415-4e41-9f03-1201fbb86f28">

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
| img | <img width="100" alt="true" src="https://github.com/KyoheiG3/smooth_counter/assets/5707132/141d8f95-f240-4716-875d-9ac4175f6dfe"> | <img width="90" alt="false" src="https://github.com/KyoheiG3/smooth_counter/assets/5707132/3445408d-dcbe-4852-8289-9ce279d1227f"> |

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
| img | ![true](https://github.com/KyoheiG3/smooth_counter/assets/5707132/445b2fa9-afc7-4aed-ba16-c7855b73be1e) | ![false](https://github.com/KyoheiG3/smooth_counter/assets/5707132/5862f4fd-2692-4389-bc89-2f80a41ce7f4) |

## License
Smooth Counter is released under the [BSD-3-Clause License](./LICENSE).
