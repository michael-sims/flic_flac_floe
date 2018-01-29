// Assorted Game information for Tic Tac Toe.

class Move {
  static const int MIN = 0;
  static const int MAX = 2;

  final Player player;
  final int row;
  final int column;

  Move(this.player, this.row, this.column) {
    RangeError.checkValueInInterval(row, MIN, MAX);
    RangeError.checkValueInInterval(column, MIN, MAX);
  }
}

class Player {
  final String name;

  const Player(this.name);

  String toString() => name;

  static const Player NONE = const Player("NONE");
}

class GameBoard {
  static const MOVES_NEEDED = Move.MAX + 1;
  static const WIDTH = Move.MAX + 1;
  static const HEIGHT = Move.MAX + 1;
  final List<Move> moves;

  GameBoard(this.moves);

  List<Move> findMove(int row, int column) {
    return moves.where((e) => e.row == row && e.column == column).toList();
  }

  Player ownerOf(int row, int column) {
    var m = findMove(row, column);
    if (m.isEmpty) {
      return Player.NONE;
    } else {
      return m.first.player;
    }
  }

  Player getWinner() {
    Set<Player> players = new Set.from(moves.map((e) => e.player));

    for (Player player in players) {
      for (int i in new List.generate(Move.MAX, (e) => e)) {
        if (playerHasAllRow(player, i) ||
            playerHasAllColumn(player, i) ||
            playerHasDiagonal(player, i) ||
            playerHasReverseDiagonal(player, i)) {
          return player;
        }
      }
    }

    return Player.NONE;
  }

  bool playerHasAllRow(Player p, int rowCheck) {
    var filtered = moves
        .where((e) => e.row == rowCheck)
        .where((e) => e.player == p)
        .toList();
    return filtered.length == MOVES_NEEDED;
  }

  bool playerHasAllColumn(Player p, int colCheck) {
    var filtered = moves
        .where((e) => e.column == colCheck)
        .where((e) => e.player == p)
        .toList();
    return filtered.length == MOVES_NEEDED;
  }

  bool playerHasDiagonal(Player p, int i) {
    var filtered = moves
        .where((e) => e.row == e.column)
        .where((e) => e.player == p)
        .toList();
    return filtered.length == MOVES_NEEDED;
  }

  bool playerHasReverseDiagonal(Player p, int i) {
    var filtered = moves
        .where((e) => e.column + e.row == Move.MAX)
        .where((e) => e.player == p)
        .toList();
    return filtered.length == MOVES_NEEDED;
  }
}
