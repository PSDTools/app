/// The pirate_coins feature's data.
library;

import "package:appwrite/appwrite.dart";
import "package:appwrite/models.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/api.dart";
import "../domain/coins_model.dart";

part "coins_data.g.dart";

/// A repository for coin manipulation.
abstract interface class CoinsRepository {
  /// Get coins data from the [databases].
  Future<Coin> coinsData(int user);

  /// Modify the coins in the [databases].
  Future<void> updateCoins(Coin coin, int user);
}

/// The default implementation of [CoinsRepository].
class AppwriteCoinsRepository implements CoinsRepository {
  /// Create a new instance of [AppwriteCoinsRepository].
  const AppwriteCoinsRepository(this.database, this.session);

  /// The Appwrite databases.
  final Databases database;

  /// The Appwrite user.
  final Account session;

  @override
  Future<Coin> coinsData(int id) async {
    try {
      final json = await _getDocument(id);

      return Coin.fromJson(json.data);
    } catch (e) {
      return _newDocument(id, const Coin(coins: 0));
    }
  }

  /// Add coins to the database.
  @override
  Future<void> updateCoins(Coin coin, int id) async {
    try {
      await _updateDocument(id, coin);
    } catch (e) {
      await _newDocument(id, coin);
    }
  }

  Future<Coin> _newDocument(int id, Coin data) async {
    await database.createDocument(
      databaseId: apiInfo.databaseId,
      collectionId: apiInfo.collectionId,
      documentId: id.toString(),
      data: data.toJson(),
    );

    return data;
  }

  Future<Document> _getDocument(int id) async {
    return database.getDocument(
      databaseId: apiInfo.databaseId,
      collectionId: apiInfo.collectionId,
      documentId: id.toString(),
    );
  }

  Future<void> _updateDocument(int id, Coin coin) async {
    await database.updateDocument(
      databaseId: apiInfo.databaseId,
      collectionId: apiInfo.collectionId,
      documentId: id.toString(),
      data: coin.toJson(),
    );
  }
}

/// Get coins data.
@riverpod
CoinsRepository coinsData(CoinsDataRef ref) {
  final databases = ref.watch(databasesProvider);
  final account = ref.watch(accountsProvider);

  return AppwriteCoinsRepository(databases, account);
}
