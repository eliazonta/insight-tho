import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  with SingleTickerProviderStateMixin{
 late AnimationController _animationController;

 @override
  void initState() {
   _animationController = AnimationController(
     vsync: this,
     duration: Duration(milliseconds: 500),
   );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stackoverflow playground'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            CupertinoFullscreenDialogTransition(
            primaryRouteAnimation: _animationController,
            secondaryRouteAnimation: _animationController,
            linearTransition: true,
              child: Center(
                child: Container(
                  color: Colors.blueGrey,
                  width: 200,
                  height: 500,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CupertinoButton(
                  onPressed: () => _animationController.forward(),
                  child: Text('Forward'),
                ),
                CupertinoButton(
                  onPressed: () => _animationController.reverse(),
                  child: Text('Reverse'),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}