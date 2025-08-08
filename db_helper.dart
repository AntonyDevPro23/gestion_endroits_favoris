import 'package:gestion_endroits_favoris/providers/endroits_utilisateurs.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  // 🔗 Ouvre la base SQLite
  static Future<Database> _getDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'endroits.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE endroits(id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, imagePath TEXT)',
        );
      },
      version: 1,
    );
  }

  // 📥 Récupère tous les endroits
  static Future<List<Endroit>> fetchEndroits() async {
    final db = await _getDatabase();
    final maps = await db.query('endroits');
    return maps.map((e) => Endroit.fromMap(e)).toList();
  }

  // ➕ Insère un nouvel endroit
  static Future<void> insertEndroit(Endroit endroit) async {
    final db = await _getDatabase();
    await db.insert(
      'endroits',
      await endroit.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ❌ Supprime un endroit par ID
  static Future<void> supprimerEndroit(int id) async {
    final db = await _getDatabase();
    await db.delete('endroits', where: 'id = ?', whereArgs: [id]);
  }
}
