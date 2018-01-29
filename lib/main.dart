import 'package:flutter/material.dart';

void main() {
  runApp(new FlicFlacFloeApp());
}

class FlicFlacFloeApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flic Flac Floe',
      home: new GameScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

class GameScreen extends StatefulWidget {
  GameScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  GameScreenState createState() => new GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Play ball!")
      ),
    );
  }
}
