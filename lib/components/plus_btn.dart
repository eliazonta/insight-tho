import 'package:flutter/material.dart';

class PlusButton extends StatelessWidget {
  final function;

  const PlusButton({this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 65,
        width: 65,
        decoration: BoxDecoration(
          color: Colors.orange[400],
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text(
            '+',
            style: TextStyle(color: Colors.black87, fontSize: 25),
          ),
        ),
      ),
    );
  }
}
