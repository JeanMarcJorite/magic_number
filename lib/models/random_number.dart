// ignore_for_file: file_names

import 'dart:math';

class RandomNumber {
  late int findNumber;
  late int nbCoups;

  RandomNumber({required int level}) {
    nbCoups = level + 2;
    findNumber = Random().nextInt(1) + level * 10;
  }
}
