import 'dart:async';

import 'package:DollarCheck/domain/dollar.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DollarDB {
Future<Database> database;

void createDB() async {
  database = openDatabase(
  // Set the path to the database.
  join(await getDatabasesPath(), 'dollars_database.db'),
  // When the database is first created, create a table to store dogs.
  onCreate: (db, version) {
    // Run the CREATE TABLE statement on the database.
    return db.execute(
      "CREATE TABLE dollars(id INTEGER PRIMARY KEY, buy DOUBLE, sell DOUBLE, date TEXT)",
    );
  },
  // Set the version. This executes the onCreate function and provides a
  // path to perform database upgrades and downgrades.
  version: 1,
);
}

Future<void> insertDollar(Dollar dollar) async {
  // Get a reference to the database.
  final Database db = await database;

  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  await db.insert(
    'dollars',
    dollar.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<void> updateDollar(Dollar dollar) async {
  // Get a reference to the database.
  final db = await database;

  // Update the given Dog.
  await db.update(
    'dollars',
    dollar.toMap(),
    // Ensure that the Dog has a matching id.
    where: "id = ?",
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [dollar.id],
  );
}

Future<List<Dollar>> dollars() async {
  // Get a reference to the database.
  final Database db = await database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('dollars');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return Dollar(
      id: maps[i]['id'],
      buy: maps[i]['buy'],
      sell: maps[i]['sell'],
      date: dateTimeFomString(maps[i]['date']),
    );
  });
}

DateTime dateTimeFomString(String string) {
  return DateTime.parse(string);
}

void insertDollars(List<Dollar> dollars) {
  for (var dollar in dollars) {
    insertDollar(dollar);
  }
}
}