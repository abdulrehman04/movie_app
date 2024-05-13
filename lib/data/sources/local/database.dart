import 'dart:async';
import 'package:cowlar_task/data/models/upcoming_movies_model.dart';
import 'package:cowlar_task/data/sources/local/upcoming_movies_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [UpcomingMovie])
abstract class AppDatabase extends FloorDatabase {
  UpcomingMoviesDao get upcomingDao;
}
