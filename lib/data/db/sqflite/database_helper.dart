import 'package:fit_movies_app/data/db/favourite_movie.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const String _databaseName = 'fit_movie_app.db';
  static const String _tableName = 'favourite_movies';
  static const int _version = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future createTables(Database database) async {
    await database.execute("""
    CREATE TABLE $_tableName(
       id INTEGER PRIMARY KEY,
       title TEXT,
       release_date TEXT,
       poster_path TEXT
    )
    """);
  }

  Future<Database> _initializeDB() async {
    return openDatabase(join(await getDatabasesPath(), _databaseName),
        version: _version, onCreate: (Database db, int version) async {
      await createTables(db);
    });
  }

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initializeDB();
    return _database!;
  }

  Future<int> addFavouriteMovie(FavouriteMovie movie) async {
    final db = await database;
    final data = movie.toJson();

    final id = await db.insert(_tableName, data,
        conflictAlgorithm: ConflictAlgorithm.replace);

    return id;
  }

  Future<List<FavouriteMovie>> getAllFavouriteMovies() async {
    final db = await database;
    final results = await db.query(_tableName);

    return results.map((result) => FavouriteMovie.fromJson(result)).toList();
  }

  Future<bool> isFavourite(int movieId) async {
    final db = await database;
    final results = await db.query(_tableName,
        where: "id = ?", whereArgs: [movieId], limit: 1);

    return results.isNotEmpty;
  }

  Future<int> removeFavouriteMovie(int movieId) async {
    final db = await database;

    final result =
        await db.delete(_tableName, where: "id = ?", whereArgs: [movieId]);
    return result;
  }
}
