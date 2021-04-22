import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 26);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('GridButton'),
        ),
        body: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: GridButton(
              textStyle: textStyle,
              borderColor: Colors.grey[300],
              borderWidth: 2,
              onPressed: (dynamic val) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(val.toString()),
                    duration: Duration(milliseconds: 400),
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
                      child: Icon(
                        Icons.image_outlined,
                        size: 50,
                      ),
                      textStyle: textStyle.copyWith(color: Colors.white),
                      value: 'image',
                      color: Colors.blue,
                      shape: BorderSide(width: 4),
                      borderRadius: 30)
                ],
                [
                  GridButtonItem(title: "7"),
                  GridButtonItem(title: "8"),
                  GridButtonItem(title: "9"),
                  GridButtonItem(title: "×", color: Colors.grey[300]),
                ],
                [
                  GridButtonItem(title: "4"),
                  GridButtonItem(title: "5"),
                  GridButtonItem(title: "6"),
                  GridButtonItem(title: "-", color: Colors.grey[300]),
                ],
                [
                  GridButtonItem(title: "1"),
                  GridButtonItem(title: "2"),
                  GridButtonItem(title: "3"),
                  GridButtonItem(title: "+", color: Colors.grey[300]),
                ],
                [
                  GridButtonItem(title: "0"),
                  GridButtonItem(title: "000", flex: 2, longPressValue: 400),
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
