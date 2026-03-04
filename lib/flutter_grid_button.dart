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
  /// This is triggered when the tap is released (tap up event).
  /// This follows Flutter's gesture system and respects gesture disambiguation.
  final ValueChanged<dynamic> onPressed;

  /// Called when a pointer that might cause a tap has contacted the screen at a particular location.
  /// This is triggered during the tap down phase, before gesture recognition is complete.
  /// This follows Flutter's gesture system and respects gesture disambiguation.
  final ValueChanged<dynamic>? onTapDown;

  /// Called when a pointer has contacted the screen at a particular location.
  /// This is the most low-level touch event, triggered immediately when the pointer touches the screen,
  /// before any gesture recognition occurs. Unlike onTapDown, this bypasses gesture disambiguation.
  final ValueChanged<dynamic>? onPointerDown;

  /// The color to use when painting the line.
  final Color? borderColor;

  /// Width of the divider border, which is usually 1.0.
  final double borderWidth;

  /// Whether to show surrounding borders.
  final bool hideSurroundingBorder;

  /// The text style to use for all buttons in the [GridButton].
  /// [GridButtonItem.textStyle] of each item takes precedence.
  final TextStyle? textStyle;

  /// Determine the layout order
  final TextDirection? textDirection;

  /// ui control disabled
  final bool enabled;

  const GridButton(
      {Key? key,
      required this.items,
      required this.onPressed,
      this.onTapDown,
      this.onPointerDown,
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
  late BorderSide _borderSide;

  Widget _getButton(int row, int col) {
    GridButtonItem item = widget.items[col][row];
    TextStyle? textStyle = item.textStyle ?? widget.textStyle;
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
        child: Material(
          color: item.color ?? Colors.transparent,
          borderRadius: BorderRadius.circular(item.borderRadius),
          child: Listener(
            onPointerDown:
                (widget.enabled == true && widget.onPointerDown != null)
                    ? (event) {
                        widget.onPointerDown!(item.value ?? item.title);
                      }
                    : null,
            child: InkWell(
              key: item.key,
              focusNode: item.focusNode,
              borderRadius: BorderRadius.circular(item.borderRadius),
              onTapDown: (widget.enabled == true && widget.onTapDown != null)
                  ? (details) {
                      widget.onTapDown!(item.value ?? item.title);
                    }
                  : null,
              onTap: (widget.enabled == true)
                  ? () {
                      widget.onPressed(item.value ?? item.title);
                    }
                  : null,
              onLongPress: (widget.enabled == true)
                  ? () {
                      var result = item.longPressValue ?? item.value;
                      widget.onPressed(result ?? item.title);
                    }
                  : null,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: item.shape != null
                      ? Border.fromBorderSide(item.shape!)
                      : null,
                  borderRadius: BorderRadius.circular(item.borderRadius),
                ),
                child: item.child == null
                    ? Text(
                        item.title!,
                        style: textStyle,
                      )
                    : item.child!,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _getRows(int col) => [
        for (int i = 0; i < widget.items[col].length; i++) _getButton(i, col),
      ];

  List<Widget> _getCols() => [
        for (int i = 0; i < widget.items.length; i++)
          Expanded(
            child: Row(
              textDirection: widget.textDirection,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _getRows(i),
            ),
          )
      ];

  @override
  Widget build(BuildContext context) {
    _borderSide = Divider.createBorderSide(context,
        color: widget.borderColor, width: widget.borderWidth);
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
  final Key? key;

  /// The button's fill color.
  final Color? color;

  /// The button's label.
  final Widget? child;

  /// The text to display on the button.
  final String? title;

  /// If non-null, the style to use for button's text.
  final TextStyle? textStyle;

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

  /// border settings
  final BorderSide? shape;

  /// An optional focus node to use as the focus node for this item.
  final FocusNode? focusNode;

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
    this.focusNode,
  });
}
