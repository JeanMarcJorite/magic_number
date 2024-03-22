// ignore_for_file: file_names

import 'dart:math';

class RandomNumber {
  late int _findNumber;
  late int _nbCoupsRestants;
  late int nbCoupsFait;

  RandomNumber({required int level}) {
    _nbCoupsRestants = level + 2;
    nbCoupsFait = 0;
    _findNumber = Random().nextInt(level * 10) + 1;
  }

  String compare(int number) {
    _nbCoupsRestants--;
    if (number == findNumber) {
      return 'Bravo! Vous avez trouvé le nombre magique en $nbCoupsFait coups';
    } else if (number < findNumber) {
      return 'Votre nombre est supérieur au mien';
    } else {
      return 'Votre nombre est inférieur au mien';
    }
  }

  bool get isGameOver => nbCoupsRestants <= 0;

  int get nbCoupsRestants => _nbCoupsRestants;

  int get findNumber => _findNumber;

  @override
  String toString() {
    return 'RandomNumber{findNumber: $findNumber, nbCoups: $nbCoupsRestants}';
  }
}
