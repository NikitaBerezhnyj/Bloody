class User {
  final int? id;
  final String name;
  final DateTime birthday;
  final String gender;
  final String bloodType;
  final String? createdAt;

  User({
    this.id,
    required this.name,
    required this.birthday,
    required this.gender,
    required this.bloodType,
    this.createdAt,
  });

  int get age {
    final now = DateTime.now();
    int years = now.year - birthday.year;
    if (now.month < birthday.month ||
        (now.month == birthday.month && now.day < birthday.day)) {
      years--;
    }
    return years;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'birthday': birthday.toIso8601String(),
      'gender': gender,
      'bloodType': bloodType,
      'createdAt': createdAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      name: map['name'],
      birthday: DateTime.parse(map['birthday']),
      gender: map['gender'],
      bloodType: map['bloodType'],
      createdAt: map['createdAt'] as String?,
    );
  }
}
