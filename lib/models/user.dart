

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

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      score: map['score'],
    );
  }


  @override
  String toString() {
    return 'User{name: $name, score: $score}';
  }


}