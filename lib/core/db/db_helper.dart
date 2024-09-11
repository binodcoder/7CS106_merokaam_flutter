import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/job_profile_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'fitness.db');

    return await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE job_profile (
            userAccountId INTEGER PRIMARY KEY,
            firstName TEXT,
            lastName TEXT,
            city TEXT,
            state TEXT,
            country TEXT,
            workAuthorization TEXT,
            employmentType TEXT,
                    )
        ''');
    });
  }

  Future<int> insertJobProfile(JobProfileModel jobProfileModel) async {
    final db = await database;
    return await db!.insert('JobProfile', jobProfileModel.toJson());
  }

  Future<JobProfileModel> readJobProfile(int id) async {
    final db = await database;
    Map<String, dynamic>? jobProfile;
    final List<Map<String, dynamic>> result = await db!.query(
      'JobProfile',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1, // Optional, to ensure only one record is fetched
    );

    if (result.isNotEmpty) {
      jobProfile = result.first;
      // Process the job profile record
    }

    return JobProfileModel.fromJson(jobProfile!);
  }
}
