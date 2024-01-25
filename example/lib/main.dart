import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _focusNode = FocusNode(canRequestFocus: false, skipTraversal: true);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 26);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GridButton'),
        ),
        body: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: GridButton(
              textStyle: textStyle,
              borderColor: Colors.grey[300],
              borderWidth: 2,
              onPressed: (dynamic val) {
                _focusNode.requestFocus();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(val.toString()),
                    duration: const Duration(milliseconds: 400),
                  ),
                );
              },
              items: [
                [
                  GridButtonItem(
                    title: "Black",
                    color: Colors.black,
                    textStyle: textStyle.copyWith(color: Colors.white),
                  ),
                  GridButtonItem(
                    title: "Red",
                    color: Colors.red,
                    textStyle: textStyle.copyWith(color: Colors.white),
                  ),
                ],
                [
                  GridButtonItem(
                      child: const Icon(
                        Icons.image_outlined,
                        size: 50,
                      ),
                      focusNode: _focusNode,
                      textStyle: textStyle.copyWith(color: Colors.white),
                      value: 'image',
                      color: Colors.blue,
                      shape: const BorderSide(width: 4),
                      borderRadius: 30)
                ],
                [
                  const GridButtonItem(title: "7"),
                  const GridButtonItem(title: "8"),
                  const GridButtonItem(title: "9"),
                  GridButtonItem(title: "×", color: Colors.grey[300]),
                ],
                [
                  const GridButtonItem(title: "4"),
                  const GridButtonItem(title: "5"),
                  const GridButtonItem(title: "6"),
                  GridButtonItem(title: "-", color: Colors.grey[300]),
                ],
                [
                  const GridButtonItem(title: "1"),
                  const GridButtonItem(title: "2"),
                  const GridButtonItem(title: "3"),
                  GridButtonItem(title: "+", color: Colors.grey[300]),
                ],
                [
                  const GridButtonItem(title: "0"),
                  const GridButtonItem(
                      title: "000", flex: 2, longPressValue: 400),
                  GridButtonItem(title: "=", color: Colors.grey[300]),
                ],
              ],
            ),
          );
        }),
      ),
    );
  }
}
