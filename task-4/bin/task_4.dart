class PokerPlayer {
  /// Список текущих карт в руке у игрока
  final List<String> _currentHand = ['King of clubs', 'Nine of hearts'];

  /// Субъективная оценка выигрыша
  // ignore: unused_field
  double _surenessInWin = 0;

  /// Вычислить шансы на выигрыш
  void calculateProbabilities(
      List<String> cardOnDesk,

      /// Это часть первого задания. [Strategy] пока не сущестивует.
      ///
      /// Опишите его.
      Strategy strategy,
      ) =>
      _surenessInWin = strategy(cardOnDesk, _currentHand);
}

typedef Strategy = double Function(List<String>, List<String>);

void main() {
  final opponent = PokerPlayer();

  /// Это часть первого задания. [Strategy] пока не сущестивует.
  ///
  /// Опишите его.
  fakeStrategy(p0, p1) {
    print("Карты противника:");
    p1.forEach((element) {print(element);});
    return 1.0;
  }

  opponent.calculateProbabilities(
    ['Nine of diamonds', 'king of hearts'],
    fakeStrategy,
  );
}