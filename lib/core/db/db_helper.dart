import 'dart:async';

import 'package:merokaam/core/errors/exceptions.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

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
    final db = await DatabaseHelper.db();
    if (db == null) {
      throw DatabaseInitializationException('Database is not initialized.');
    }
    try {
      final result = await db.insert('jobprofile', jobProfileModel.toJson());
      return result;
    } on DatabaseException catch (e) {
      throw DatabaseOperationException('Failed to insert job profile.', e);
    } catch (e) {
      throw UnknownException('An unexpected error occurred while inserting the job profile.', e);
    }
  }

  static Future<JobProfileModel> readJobProfile(int id) async {
    final db = await DatabaseHelper.db();

    if (db == null) {
      throw DatabaseInitializationException('Database is not initialized.');
    }

    try {
      final List<Map<String, dynamic>> result = await db.query(
        'jobprofile',
        where: 'userAccountId = ?',
        whereArgs: [id],
        limit: 1, // Ensures only one record is fetched
      );

      if (result.isNotEmpty) {
        try {
          return JobProfileModel.fromJson(result.first);
        } on FormatException catch (e) {
          throw DataFormatException('Invalid data format.', e);
        }
      } else {
        throw NotFoundException('Job profile not found for userAccountId: $id.');
      }
    } on NotFoundException {
      rethrow;
    } on DatabaseException catch (e) {
      // Handle database-related exceptions
      throw DatabaseOperationException('Database query failed.', e);
    } on DataFormatException {
      rethrow;
    } on DatabaseInitializationException catch (e) {
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw UnknownException('An unexpected error occurred.', e);
    }
  }

  static Future<int> updateJobProfile(JobProfileModel jobProfileModel) async {
    final db = await DatabaseHelper.db();
    if (db == null) {
      throw DatabaseInitializationException('Database is not initialized.');
    }
    try {
      final result = await db.update(
        'jobprofile',
        jobProfileModel.toJson(),
        where: 'userAccountId = ?',
        whereArgs: [jobProfileModel.userAccountId],
      );

      // Check if any rows were affected by the update
      if (result == 0) {
        // If no rows were updated, throw NotFoundException
        throw NotFoundException('Job profile not found for userAccountId: ${jobProfileModel.userAccountId}.');
      }
      return result;
    } on NotFoundException catch (e) {
      rethrow;
    } on DatabaseException catch (e) {
      // Handle database-related exceptions
      throw DatabaseOperationException('Failed to update job profile.', e);
    } on DatabaseInitializationException catch (e) {
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw UnknownException('An unexpected error occurred while updating the job profile.', e);
    }
  }

  static Future<int> deleteAllJobProfiles() async {
    final db = await DatabaseHelper.db();
    if (db == null) {
      throw DatabaseInitializationException('Database is not initialized.');
    }
    try {
      final result = await db.delete('jobprofile');
      return result;
    } on DatabaseException catch (e) {
      throw DatabaseOperationException('Failed to delete job profiles.', e);
    } on DatabaseInitializationException catch (e) {
      rethrow;
    } catch (e) {
      throw UnknownException('An unexpected error occurred while deleting job profiles.', e);
    }
  }
}
