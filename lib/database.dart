//import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'sales_database.db'),
    // When the database is first created, create a table to store sales.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE sales(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  // Define a function that inserts sales into the database
  Future<void> insertSales(Sales sale) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the SALE into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same SALE is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'dogs',
      sale.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the sales from the sales table.
  Future<List<Sales>> sale() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('dogs');

    // Convert the List<Map<String, dynamic> into a List<Sale>.
    return List.generate(maps.length, (i) {
      return Sales(
        id: maps[i]['id'],
        itemName: maps[i]['name'],
        itemPrice: maps[i]['age'],
      );
    });
  }

  Future<void> updateSale(Sales sale) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'dogs',
      sale.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [sale.id],
    );
  }

  Future<void> deleteSale(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'dogs',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  // Create a Sale and add it to the sales table
  var item_sale = const Sales(
    id: 0,
    itemName: 'Fido',
    itemPrice: 35,
  );

  await insertSales(item_sale);

  // Now, use the method above to retrieve all the dogs.
  print(await sale()); // Prints a list that include Fido.

  // Update a sale value and save it to the database.
/*  sale = Sales(
    id: sale.id,
    itemName: sale.itemName,
    itemPrice: sale.itemPrice + 7,
  );
  await updateSale(sale);*/

  // Print the updated results.
  print(await sale()); // Prints Fido with age 42.

  // Delete Fido from the database.
  /*await deleteSale(sale.id);*/

  // Print the list of dogs (empty).
  print(await sale());
}

class Sales {
  final int id;
  final String itemName;
  final int itemPrice;

  const Sales({
    required this.id,
    required this.itemName,
    required this.itemPrice,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': itemName,
      'age': itemPrice,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Sale{id: $id, name: $itemName, age: $itemPrice}';
  }
}