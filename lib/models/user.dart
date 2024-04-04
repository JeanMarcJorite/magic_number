class User {
  int id;
  String name;
  int score;
  int niveau;

  User({required this.id, required this.name, this.score = 0, this.niveau = 0});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'score': score,
      'niveau': niveau,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      score: map['score'],
      niveau: map['niveau'],
    );
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, score: $score , niveau: $niveau}';
  }
}
