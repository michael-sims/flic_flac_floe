import 'package:flutter/material.dart';
import 'package:flic_flac_floe/game.dart';

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
        body: _buildGameGrid(context)
    );
  }


  Widget _buildGameGrid(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(
          children: new List.generate(GameBoard.WIDTH, (x) => _row(x))
      ),
    );
  }

  Widget _row(int x) {
    return new Column(
      children: new List.generate(GameBoard.HEIGHT, (y) => new GridCell(x, y)),
    );
  }
}

class GridCell extends StatelessWidget {
  GridCell(this.locX, this.locY);

  final int locX;
  final int locY;

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: new Text("$locX,$locY")
    );
  }
}
