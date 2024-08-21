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

  Future<List<JobProfileModel>> getJobProfiles() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('JobProfile');

    return List.generate(maps.length, (i) {
      return JobProfileModel(
        userAccountId: 0,
        firstName: '',
        lastName: '',
        city: '',
        state: '',
        country: '',
        workAuthorization: '',
        employmentType: '',
        resume: '',
        profilePhoto: '',
        photosImagePath: '',
      );
    });
  }
}
