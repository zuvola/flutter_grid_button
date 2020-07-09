# flutter_grid_button

Flutter widget that arrange buttons in a grid. It is useful for making a number pad, calculator, and so on.

[![pub package](https://img.shields.io/pub/v/flutter_grid_button.svg)](https://pub.dartlang.org/packages/flutter_grid_button)

<img src="https://github.com/zuvola/flutter_grid_button/blob/master/example/screenshot.png?raw=true" width="320px"/>


## Getting Started

To use this plugin, add `flutter_grid_button` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

```yaml
dependencies:
 flutter_grid_button: 
```

Import the library in your file.

````dart
import 'package:flutter_grid_button/flutter_grid_button.dart';
````

See the `example` directory for a complete sample app using GridButton.
Or use the GridButton like below.

````dart
GridButton(
  onPressed: (String value) {
    /*...*/
  },
  items: [
    [
      GridButtonItem(title: "1"),
      GridButtonItem(title: "2"),
      GridButtonItem(title: "3", flex: 2),
    ],
    [
      GridButtonItem(title: "a", value: "100", longPressValue: "long"),
      GridButtonItem(title: "b", color: Colors.lightBlue)
    ],
  ],
)
````