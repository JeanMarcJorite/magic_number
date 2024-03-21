

class User {


  String name;
  int score = 0;

  User({required this.name, required this.score});

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'score': score,
    };
  }

  @override
  String toString() {
    return 'User{name: $name, score: $score}';
  }


}