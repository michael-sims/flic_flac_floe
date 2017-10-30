import 'package:test/test.dart';
import 'package:flic_flac_floe/game.dart';

void main() {
  testMove();
  testGameBoard();
}

void testMove() {
  test('moves accept strings as players', () {
    var playerX = new Player('X');
    var move = new Move(playerX, 1, 2);
    expect(move.player.name, 'X');
  });

  test("moves throw an exception if coordinates are out of range", () {
    try {
      new Move(Player.NONE, 0, 3);
      fail("invalid coordinate slipped through");
    } on RangeError {}
  });
}

void testGameBoard() {
  test("when there's one item in the thing, findmove finds it", () {
    var playerX = new Player('X');
    var board = new GameBoard([new Move(playerX, 0, 0)]);
    var list = board.findMove(0, 0);
    expect(list.length, 1);
  });

  test("when the find coordinates are wrong, find doesn't find it", () {
    var playerX = new Player('X');
    var board = new GameBoard([new Move(playerX, 1, 0)]);
    var list = board.findMove(0, 0);
    expect(list.length, 0);
  });

  test('findMove yeilds no results on an empty board', () {
    var board = new GameBoard([]);

    var list = board.findMove(0, 0);
    expect(list.length, 0);
  });

  test("owner of an unclaimed space is NONE", () {
    var board = new GameBoard([]);
    expect(board.ownerOf(1, 3), equals(Player.NONE));
  });

  test("owner of a claimed space is the player who moved there", () {
    var playerX = new Player("X");
    var board = new GameBoard([new Move(playerX, 0, 1)]);

    expect(board.ownerOf(0, 1), equals(playerX));
  });

  test("owner thing works with two players too", () {
    var playerX = new Player("X");
    var playerO = new Player("O");
    var moves = [new Move(playerX, 0, 2), new Move(playerO, 1, 0)];
    var board = new GameBoard(moves);

    expect(board.ownerOf(0, 2), equals(playerX));
    expect(board.ownerOf(1, 0), equals(playerO));
    expect(board.ownerOf(2, 2), equals(Player.NONE));
  });

  test("board with no moves has no winner", () {
    var board = new GameBoard([]);
    expect(board.getWinner(), equals(Player.NONE));
  });

  test("board with one player having first column has that player win", () {
    var pX = new Player("X");
    var pO = new Player("O");

    var moves = [
      new Move(pX, 1, 1), //  O X .
      new Move(pO, 2, 0), //  O X X
      new Move(pX, 0, 1), //  O . .
      new Move(pO, 0, 0),
      new Move(pX, 1, 2),
      new Move(pO, 1, 0),
    ];
    var board = new GameBoard(moves);
    expect(board.getWinner(), equals(pO));
  });

  test("board with one player having mid row has that player win", () {
    var pX = new Player("X");
    var pO = new Player("O");

    var moves = [
      new Move(pX, 1, 1), // O X .
      new Move(pO, 2, 2), // X X X
      new Move(pX, 1, 0), // . O O
      new Move(pO, 0, 0),
      new Move(pX, 0, 1),
      new Move(pO, 2, 1),
      new Move(pX, 1, 2)
    ];
    var board = new GameBoard(moves);
    expect(board.getWinner(), equals(pX));
  });

  test("board with one player having the diagonal has that player win", () {
    var pX = new Player("X");
    var pO = new Player("O");

    var moves = [
      new Move(pX, 0, 2), // O X X
      new Move(pO, 2, 2), // X O X
      new Move(pX, 1, 0), // . O O
      new Move(pO, 0, 0),
      new Move(pX, 0, 1),
      new Move(pO, 2, 1),
      new Move(pX, 1, 2),
      new Move(pO, 1, 1)
    ];
    var board = new GameBoard(moves);
    expect(board.getWinner(), equals(pO));
  });

  test("board with a player on the other diagonal has that player win", () {
    var pX = new Player("X");
    var pO = new Player("O");

    var moves = [
      new Move(pX, 0, 0), // X X O
      new Move(pO, 0, 2), // X O .
      new Move(pX, 0, 1), // O . .
      new Move(pO, 1, 1),
      new Move(pX, 1, 0),
      new Move(pO, 2, 0)
    ];
    var board = new GameBoard(moves);
    expect(board.getWinner(), equals(pO));
  });
}
