/// The pirate_coins feature's data.
library;

import "package:appwrite/appwrite.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/api.dart";
import "../domain/coins_model.dart";

part "coins_data.g.dart";

/// A repository for coin manipulation.
abstract interface class CoinsRepository {
  /// Get coins data from the [databases].
  Future<Coin> coinsData();

  /// Modify the coins in the [databases].
  Future<void> updateCoins(Coin coin);
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
  Future<Coin> coinsData() async {
    final user = await session.get();

    try {
      final json = await database.getDocument(
        databaseId: apiInfo.databaseId,
        collectionId: apiInfo.collectionId,
        documentId: user.$id,
      );
      final data = Coin.fromJson(json.data);

      return data;
    } catch (e) {
      await _newDocument();
      final json = await database.getDocument(
        databaseId: apiInfo.databaseId,
        collectionId: apiInfo.collectionId,
        documentId: user.$id,
      );
      final data = Coin.fromJson(json.data);

      return data;
    }
  }

  Future<void> _newDocument() async {
    final user = await session.get();

    await database.createDocument(
      databaseId: apiInfo.databaseId,
      collectionId: apiInfo.collectionId,
      documentId: user.$id,
      data: const Coin(
        coins: 0,
      ).toJson(),
    );
  }

  /// Add coins to the database.
  @override
  Future<void> updateCoins(Coin coin) async {
    final user = await session.get();

    try {
      await database.updateDocument(
        databaseId: apiInfo.databaseId,
        collectionId: apiInfo.collectionId,
        documentId: user.$id,
        data: coin.toJson(),
      );
    } catch (e) {
      await _newDocument();
      await database.updateDocument(
        databaseId: apiInfo.databaseId,
        collectionId: apiInfo.collectionId,
        documentId: user.$id,
        data: coin.toJson(),
      );
    }
  }
}

/// Get coins data.
@riverpod
CoinsRepository coinsData(CoinsDataRef ref) {
  final databases = ref.watch(databasesProvider);
  final account = ref.watch(accountsProvider);

  return AppwriteCoinsRepository(databases, account);
}
