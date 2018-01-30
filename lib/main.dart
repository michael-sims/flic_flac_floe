import 'package:flutter/material.dart';
import 'package:flic_flac_floe/game.dart';

void main() => runApp(new FlicFlacFloeApp());

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

  final List<Player> _players = [new Player("X"), new Player("O")];
  final List<Move> _moves = new List<Move>();

  void move(final int x, final int y) {
    _moves.add(new Move(_players.first, x, y));
    _cyclePlayers();
  }

  void _cyclePlayers() {
    Player p = _players.removeAt(0);
    _players.add(p);
  }

  @override
  Widget build(BuildContext context) {
    final GameBoard board = new GameBoard(_moves);

    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Play ball!")
        ),
        body: _buildGameGrid(context, board)
    );
  }


  Widget _buildGameGrid(BuildContext context, final GameBoard board) {
    return new Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(
          children: new List.generate(GameBoard.WIDTH, (x) => _row(x, board))
      ),
    );
  }

  Widget _row(int x, final GameBoard board) {
    return new Column(
      children: new List.generate(
          GameBoard.HEIGHT, (y) => _cellAt(x, y, board)),
    );
  }

  Widget _cellAt(int x, int y, final GameBoard board) {
    Player owner = board.ownerOf(x, y);
    return new GridCell(x, y, owner, () {
      setState(() {
        move(x, y);
      });
    });
  }
}

class GridCell extends StatelessWidget {
  GridCell(this.locX,
      this.locY,
      this.owner,
      this.onPressed);

  final int locX;
  final int locY;
  final Player owner;
  final VoidCallback onPressed;


  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: new Column(
          children: <Widget>[

            new IconButton(
                icon: new Icon(fromPlayer(owner)),
                onPressed: owner == Player.NONE ? onPressed : null
            ),
            new Text("$locX,$locY"),
          ],
        )
    );
  }

  IconData fromPlayer(Player p) {
    if (p.name == "X") {
      return Icons.close;
    }

    if (p.name == "O") {
      return Icons.add_circle;
    }

    return Icons.cake;
  }
}
