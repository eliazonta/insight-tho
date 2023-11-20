import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 40,
        width: 40,
        child: CupertinoActivityIndicator(
          color: Colors.orange,
          radius: 25,
        ),
      ),
    );
  }
}
