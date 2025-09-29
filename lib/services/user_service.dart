import 'database_service.dart';
import '../models/user.dart';

class UserService {
  static Future<User?> getUser() async {
    final db = await DatabaseService.getDatabase();
    final result = await db.query('users', limit: 1);

    if (result.isEmpty) return null;

    return User.fromMap(result.first);
  }

  static Future<void> saveUser(User user) async {
    final db = await DatabaseService.getDatabase();
    final existing = await db.query('users', limit: 1);

    if (existing.isEmpty) {
      // При створенні нового користувача додаємо час створення
      final userWithTimestamp = User(
        id: user.id,
        name: user.name,
        age: user.age,
        gender: user.gender,
        bloodType: user.bloodType,
        createdAt: user.createdAt ?? DateTime.now().toIso8601String(),
      );
      await db.insert('users', userWithTimestamp.toMap());
    } else {
      await db.update(
        'users',
        user.toMap(),
        where: 'id = ?',
        whereArgs: [existing.first['id']],
      );
    }
  }
}