import 'database_service.dart';
import '../models/donation.dart';

class DonationService {
  static Future<List<Donation>> getDonations() async {
    final db = await DatabaseService.getDatabase();
    final result = await db.query('donations', orderBy: 'date DESC');
    return result.map((e) => Donation.fromMap(e)).toList();
  }

  static Future<void> addDonation(Donation donation) async {
    final db = await DatabaseService.getDatabase();
    await db.insert('donations', donation.toMap());
  }

  static Future<void> updateDonation(Donation donation) async {
    final db = await DatabaseService.getDatabase();
    await db.update(
      'donations',
      donation.toMap(),
      where: 'id = ?',
      whereArgs: [donation.id],
    );
  }

  static Future<void> deleteDonation(int id) async {
    final db = await DatabaseService.getDatabase();
    await db.delete('donations', where: 'id = ?', whereArgs: [id]);
  }

  static Future<Donation?> getLastDonation() async {
    final db = await DatabaseService.getDatabase();
    final result = await db.query('donations', orderBy: 'date DESC', limit: 1);
    if (result.isEmpty) return null;
    return Donation.fromMap(result.first);
  }
}
