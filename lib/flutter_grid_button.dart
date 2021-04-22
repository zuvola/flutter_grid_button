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
///       GridButtonItem(child: Text("2")),
///       GridButtonItem(title: "3", flex: 2),
///     ],
///     [
///       GridButtonItem(title: "a", value: "100", longPressValue: "long"),
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

  /// Width of the divider border, which is usually 1.0.
  final double borderWidth;

  /// Whether to show surrounding borders.
  final bool hideSurroundingBorder;

  /// The text style to use for all buttons in the [GridButton].
  /// [GridButtonItem.textStyle] of each item takes precedence.
  final TextStyle textStyle;

  /// Determine the layout order
  final TextDirection textDirection;

  /// ui control disabled
  final bool enabled;

  const GridButton(
      {Key key,
      @required this.items,
      @required this.onPressed,
      this.borderColor,
      this.textStyle,
      this.textDirection,
      this.borderWidth = 1.0,
      this.hideSurroundingBorder = false,
      this.enabled = true})
      : super(key: key);

  @override
  _GridButtonState createState() => _GridButtonState();
}

class _GridButtonState extends State<GridButton> {
  BorderSide _borderSide;

  Widget _getButton(int row, int col) {
    GridButtonItem item = widget.items[col][row];
    TextStyle textStyle =
        item.textStyle != null ? item.textStyle : widget.textStyle;
    var noBottomLine =
        widget.hideSurroundingBorder && widget.items.length == col + 1;
    var noRightLine =
        widget.hideSurroundingBorder && widget.items[col].length == row + 1;
    return Expanded(
      flex: item.flex,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: noBottomLine ? BorderSide.none : _borderSide,
            right: noRightLine ? BorderSide.none : _borderSide,
          ),
        ),
        child: FlatButton(
          key: item.key,
          color: item.color,
          splashColor: textStyle?.color?.withOpacity(0.12),
          shape: RoundedRectangleBorder(
            side: item.shape ?? BorderSide.none,
            borderRadius: BorderRadius.circular(item.borderRadius),
          ),
          onPressed: (widget.enabled == true)
              ? () {
                  widget
                      .onPressed(item.value != null ? item.value : item.title);
                }
              : null,
          onLongPress: (widget.enabled == true)
              ? () {
                  var result = item.longPressValue ?? item.value;
                  widget.onPressed(result != null ? result : item.title);
                }
              : null,
          child: item.child == null
              ? Text(
                  item.title,
                  style: textStyle,
                )
              : item.child,
        ),
      ),
    );
  }

  List<Widget> _getRows(int col) {
    List<Widget> list = List(widget.items[col].length);
    for (int i = 0; i < list.length; i++) {
      list[i] = _getButton(i, col);
    }
    return list;
  }

  List<Widget> _getCols() {
    List<Widget> list = List(widget.items.length);
    for (int i = 0; i < list.length; i++) {
      list[i] = Expanded(
        child: Row(
          textDirection: widget.textDirection,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _getRows(i),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    _borderSide = Divider.createBorderSide(context,
        color: widget.borderColor, width: widget.borderWidth ?? 1.0);
    return Container(
      decoration: widget.hideSurroundingBorder
          ? null
          : BoxDecoration(
              border: Border(
                top: _borderSide,
                left: _borderSide,
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

  /// The button's label.
  final Widget child;

  /// The text to display on the button.
  final String title;

  /// If non-null, the style to use for button's text.
  final TextStyle textStyle;

  /// The flex factor to use for the button.
  final int flex;

  /// The value for the [GridButton.onPressed] callback parameter.
  /// If the [value] is null, the callback will use the [title] instead.
  final dynamic value;

  /// The value for the [GridButton.onPressed] callback parameter.
  /// If the [longPressValue] is null, the callback will fallback to
  /// the [value] set for [GridButton.onPressed] if [value] is null
  /// the callback will use the [title] instead.
  final dynamic longPressValue;

  /// The corner radius of the button.
  final double borderRadius;

  // border settings
  final BorderSide shape;

  const GridButtonItem({
    this.key,
    this.title,
    this.color,
    this.textStyle,
    this.value,
    this.longPressValue,
    this.flex = 1,
    this.borderRadius = 0,
    this.child,
    this.shape,
  });
}
