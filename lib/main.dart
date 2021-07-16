import 'package:flutter/material.dart';

void main() {
  runApp(ChompGrid());
}

class ChompGrid extends StatefulWidget {
  const ChompGrid({Key? key}) : super(key: key);

  @override
  _ChompGridState createState() => _ChompGridState();
}

class _ChompGridState extends State<ChompGrid> {
  final title = 'Chomp Game';
  bool isEnabled = true;
  List<int> clickedList = [];
  int lastClicked = -6;
  List<Function> allConstraints = [];

  enableElevatedButton() {
    setState(() {
      isEnabled = true;
    });
  }

  disableElevatedButton() {
    setState(() {
      isEnabled = false;
    });
  }

  Function checkIfBeyondLastClicked(int lastClickedIndex) {
    return (index) =>
        (index - 6 * (index ~/ 6)) <
            (lastClickedIndex - 6 * (lastClickedIndex ~/ 6)) ||
        index ~/ 6 > lastClickedIndex ~/ 6;
  }

  bool applyConstraints(int index) {
    bool inter = true;
    for (var i = 0; i < allConstraints.length; i++) {
      inter = inter && allConstraints[i](index);
    }
    return inter;
  }

  addConstraint() {
    allConstraints.add(checkIfBeyondLastClicked(lastClicked));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Container(
              alignment: Alignment.center,
              child: Container(
                width: 300,
                height: 200,
                child: GridView.count(
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: 6,
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(24, (index) {
                    return Container(
                      child: ElevatedButton(
                          child: Text('$index'),
                          onPressed: applyConstraints(index)
                              ? () {
                                  lastClicked = index;
                                  setState(() {});
                                  addConstraint();
                                }
                              : null),
                    );
                  }),
                ),
              ))),
    );
  }
}
