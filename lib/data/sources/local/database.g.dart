// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UpcomingMoviesDao? _upcomingDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `upcomingMovie` (`adult` INTEGER NOT NULL, `backdropPath` TEXT, `genreIds` TEXT NOT NULL, `id` INTEGER NOT NULL, `originalLanguage` TEXT NOT NULL, `originalTitle` TEXT NOT NULL, `overview` TEXT NOT NULL, `popularity` REAL NOT NULL, `posterPath` TEXT, `releaseDate` TEXT NOT NULL, `title` TEXT NOT NULL, `video` INTEGER NOT NULL, `voteAverage` REAL NOT NULL, `voteCount` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UpcomingMoviesDao get upcomingDao {
    return _upcomingDaoInstance ??=
        _$UpcomingMoviesDao(database, changeListener);
  }
}

class _$UpcomingMoviesDao extends UpcomingMoviesDao {
  _$UpcomingMoviesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _upcomingMovieInsertionAdapter = InsertionAdapter(
            database,
            'upcomingMovie',
            (UpcomingMovie item) => <String, Object?>{
                  'adult': item.adult ? 1 : 0,
                  'backdropPath': item.backdropPath,
                  'genreIds': item.genreIds,
                  'id': item.id,
                  'originalLanguage': item.originalLanguage,
                  'originalTitle': item.originalTitle,
                  'overview': item.overview,
                  'popularity': item.popularity,
                  'posterPath': item.posterPath,
                  'releaseDate': item.releaseDate,
                  'title': item.title,
                  'video': item.video ? 1 : 0,
                  'voteAverage': item.voteAverage,
                  'voteCount': item.voteCount
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UpcomingMovie> _upcomingMovieInsertionAdapter;

  @override
  Future<List<UpcomingMovie>> getLocalMovies() async {
    return _queryAdapter.queryList('SELECT * FROM upcomingMovie',
        mapper: (Map<String, Object?> row) => UpcomingMovie(
            adult: (row['adult'] as int) != 0,
            backdropPath: row['backdropPath'] as String?,
            genreIds: row['genreIds'] as String,
            id: row['id'] as int,
            originalLanguage: row['originalLanguage'] as String,
            originalTitle: row['originalTitle'] as String,
            overview: row['overview'] as String,
            popularity: row['popularity'] as double,
            posterPath: row['posterPath'] as String?,
            releaseDate: row['releaseDate'] as String,
            title: row['title'] as String,
            video: (row['video'] as int) != 0,
            voteAverage: row['voteAverage'] as double,
            voteCount: row['voteCount'] as int));
  }

  @override
  Future<void> saveMovie(UpcomingMovie movie) async {
    await _upcomingMovieInsertionAdapter.insert(
        movie, OnConflictStrategy.abort);
  }
}
