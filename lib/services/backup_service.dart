import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'database_service.dart';

class BackupService {
  static Future<void> exportBackup(BuildContext context) async {
    final db = await DatabaseService.getDatabase();

    final users = await db.query('users');
    final donations = await db.query('donations');

    final payload = jsonEncode({
      'version': 1,
      'exportedAt': DateTime.now().toIso8601String(),
      'users': users,
      'donations': donations,
    });

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/bloody_backup.json');
    await file.writeAsString(payload);

    await Share.shareXFiles([XFile(file.path)], subject: 'Bloody — backup');
  }

  static Future<bool> importBackup() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    if (result == null || result.files.single.path == null) return false;

    final content = await File(result.files.single.path!).readAsString();
    final Map<String, dynamic> data = jsonDecode(content);

    if (!data.containsKey('users') || !data.containsKey('donations')) {
      return false;
    }

    final db = await DatabaseService.getDatabase();

    await db.transaction((txn) async {
      await txn.delete('users');
      await txn.delete('donations');

      for (final u in (data['users'] as List)) {
        await txn.insert('users', Map<String, dynamic>.from(u));
      }
      for (final d in (data['donations'] as List)) {
        await txn.insert('donations', Map<String, dynamic>.from(d));
      }
    });

    return true;
  }
}
