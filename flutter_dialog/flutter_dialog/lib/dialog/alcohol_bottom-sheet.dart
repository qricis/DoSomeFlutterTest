import 'package:flutter/material.dart';

import '../main.dart';

class SelectionBottomSheet {

  static void showSelectionBottomSheet(BuildContext context, State<HomePage> state) {

    bool _isSecond = false;

    void setSecond() {
      print("setSecond");
      state.setState(() {
        _isSecond = true;
      });
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        if (_isSecond) {
          print("isSecond: " + _isSecond.toString());
          return Container(
          );       
        } else {
          print("isSecond: " + _isSecond.toString());
          return Container(
            height: 400.00,
           
            child: ElevatedButton(
              onPressed: () {
                setSecond();
              },
              child: const Text('有问题'),
            ),
          );
        }
      },
    );
  }
}
