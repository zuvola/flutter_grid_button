// Copyright 2019 zuvola. All rights reserved.

/// Flutter widget that arrange buttons in a grid.
library flutter_grid_button;

import 'package:flutter/material.dart';

/// Grid Button
///
/// {@tool sample}
///
/// This example shows a simple [GridButton].
///
/// ```dart
/// GridButton(
///   onPressed: (dynamic value) {
///     /*...*/
///   },
///   items: [
///     [
///       GridButtonItem(title: "1"),
///       GridButtonItem(title: "2"),
///       GridButtonItem(title: "3"),
///     ],
///     [
///       GridButtonItem(title: "a", value: "100"),
///       GridButtonItem(title: "b", color: Colors.lightBlue)
///     ],
///   ],
/// )
/// ```
/// {@end-tool}
///
/// The [items] and [onPressed] arguments must not be null.
class GridButton extends StatefulWidget {
  /// Defines the appearance of the button items that are 2D arrayed within the GridButton.
  final List<List<GridButtonItem>> items;

  /// Called when the button is tapped or otherwise activated.
  final ValueChanged<dynamic> onPressed;

  /// The color to use when painting the line.
  final Color borderColor;

  /// The text style to use for all buttons in the [GridButton].
  /// [GridButtonItem.textStyle] of each item takes precedence.
  final TextStyle textStyle;

  /// Determine the layout order
  final TextDirection textDirection;

  const GridButton({
    Key key,
    @required this.items,
    @required this.onPressed,
    this.borderColor,
    this.textStyle,
    this.textDirection,
  }) : super(key: key);

  @override
  _GridButtonState createState() => _GridButtonState();
}

class _GridButtonState extends State<GridButton> {
  Widget _getButton(int row, int col) {
    GridButtonItem item = widget.items[col][row];
    TextStyle textStyle =
        item.textStyle != null ? item.textStyle : widget.textStyle;
    return Expanded(
      flex: item.flex,
      child: FlatButton(
        key: item.key,
        color: item.color,
        splashColor: textStyle?.color?.withOpacity(0.12),
        onPressed: () {
          widget.onPressed(item.value != null ? item.value : item.title);
        },
        child: Text(
          item.title,
          style: textStyle,
        ),
      ),
    );
  }

  List<Widget> _getRows(int col) {
    List<Widget> list = List(widget.items[col].length * 2);
    for (int i = 0; i < list.length; i++) {
      if (i % 2 == 1) {
        list[i] = VerticalDivider(
          width: 1,
          color: widget.borderColor,
        );
        continue;
      }
      list[i] = _getButton(i ~/ 2, col);
    }
    return list;
  }

  List<Widget> _getCols() {
    List<Widget> list = List(widget.items.length * 2);
    for (int i = 0; i < list.length; i++) {
      if (i % 2 == 1) {
        list[i] = Divider(
          height: 1,
          color: widget.borderColor,
        );
        continue;
      }
      list[i] = Expanded(
        child: Row(
          textDirection: widget.textDirection,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _getRows(i ~/ 2),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: Divider.createBorderSide(context, color: widget.borderColor),
          left: Divider.createBorderSide(context, color: widget.borderColor),
        ),
      ),
      child: Column(
        children: _getCols(),
      ),
    );
  }
}

/// The data for a cell of a [GridButton].
class GridButtonItem {
  /// The [key] for the button.
  final Key key;

  /// The button's fill color.
  final Color color;

  /// The text to display on the button.
  final String title;

  /// If non-null, the style to use for button's text.
  final TextStyle textStyle;

  /// The flex factor to use for the button.
  final int flex;

  /// The value for the [GridButton.onPressed] callback parameter.
  /// If the [value] is null, the callback will use the [title] instead.
  final dynamic value;

  const GridButtonItem({
    this.key,
    this.title,
    this.color,
    this.textStyle,
    this.value,
    this.flex = 1,
  });
}
