class User {
  final int? id;
  final String name;
  final int age;
  final String gender;
  final String bloodType;

  User({
    this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.bloodType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'bloodType': bloodType,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      name: map['name'],
      age: map['age'],
      gender: map['gender'],
      bloodType: map['bloodType'],
    );
  }
}
