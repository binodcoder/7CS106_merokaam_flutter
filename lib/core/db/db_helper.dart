import 'dart:async';

import 'package:merokaam/core/errors/exceptions.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../models/job_profile_model.dart';

class DatabaseHelper {
  static Future<sql.Database> db() async {
    return sql.openDatabase('blog.db', version: 1, onCreate: (
      sql.Database database,
      int version,
    ) async {
      await createTables(database);
    });
  }

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE jobprofile(
      userAccountId INTEGER PRIMARY KEY NOT NULL,
            firstName TEXT,
            lastName TEXT,
            city TEXT,
            state TEXT,
            country TEXT,
            workAuthorization TEXT,
            employmentType TEXT,
            resume TEXT,
            profilePhoto TEXT,
            photosImagePath TEXT,
            duration INTEGER,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<int> insertJobProfile(JobProfileModel jobProfileModel) async {
    try {
      final db = await DatabaseHelper.db();
      return await db.insert('jobprofile', jobProfileModel.toJson());
    } catch (e) {
      rethrow;
    }
  }

  static Future<JobProfileModel> readJobProfile(int id) async {
    final db = await DatabaseHelper.db();
    Map<String, dynamic>? jobProfile;

    try {
      final List<Map<String, dynamic>> result = await db!.query(
        'jobprofile',
        where: 'userAccountId = ?',
        whereArgs: [id],
        limit: 1, // Optional, to ensure only one record is fetched
      );

      if (result.isNotEmpty) {
        jobProfile = result.first;
      } else {
        throw CacheException();
      }
    } catch (e) {
      rethrow;
    }

    return JobProfileModel.fromJson(jobProfile!);
  }

  static Future<int> updateJobProfile(JobProfileModel jobProfileModel) async {
    try {
      final db = await DatabaseHelper.db();
      return await db.update(
        'jobprofile',
        jobProfileModel.toJson(),
        where: 'userAccountId = ?',
        whereArgs: [jobProfileModel.userAccountId],
      );
    } catch (e) {
      rethrow;
    }
  }
}
