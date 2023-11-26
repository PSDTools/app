/// This library contains the Pirate Coins feature's data fetchers.
library;

import "package:appwrite/appwrite.dart";
import "package:appwrite/models.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/api.dart";
import "../domain/coin_entity.dart";

part "coins_repository.g.dart";

/// A repository for coin manipulation.
abstract interface class CoinsRepository {
  /// Get coins data from the [databases].
  Future<CoinEntity> coinsData(int user);

  /// Modify the coins in the [databases].
  Future<void> updateCoins(CoinEntity coin, int user);
}

/// The default implementation of [CoinsRepository].
base class _AppwriteCoinsRepository implements CoinsRepository {
  /// Create a new instance of [_AppwriteCoinsRepository].
  const _AppwriteCoinsRepository(Databases databases) : _database = databases;

  /// The Appwrite databases.
  final Databases _database;

  @override
  Future<CoinEntity> coinsData(int id) async {
    try {
      final json = await _getDocument(id);

      return CoinEntity.fromJson(json.data);
    } catch (e) {
      return _newDocument(id, const CoinEntity(coins: 0));
    }
  }

  /// Add coins to the _database.
  @override
  Future<void> updateCoins(CoinEntity coin, int id) async {
    try {
      await _updateDocument(id, coin);
    } catch (e) {
      await _newDocument(id, coin);
    }
  }

  Future<CoinEntity> _newDocument(int id, CoinEntity data) async {
    await _database.createDocument(
      databaseId: apiInfo.databaseId,
      collectionId: apiInfo.collectionId,
      documentId: id.toString(),
      data: data.toJson(),
    );

    return data;
  }

  Future<Document> _getDocument(int id) async {
    return _database.getDocument(
      databaseId: apiInfo.databaseId,
      collectionId: apiInfo.collectionId,
      documentId: id.toString(),
    );
  }

  Future<void> _updateDocument(int id, CoinEntity coin) async {
    await _database.updateDocument(
      databaseId: apiInfo.databaseId,
      collectionId: apiInfo.collectionId,
      documentId: id.toString(),
      data: coin.toJson(),
    );
  }
}

/// Get the coins data.
@riverpod
CoinsRepository coinsData(CoinsDataRef ref) {
  final databases = ref.watch(databasesProvider);

  return _AppwriteCoinsRepository(databases);
}
