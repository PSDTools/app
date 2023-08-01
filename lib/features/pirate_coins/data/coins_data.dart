/// The pirate_coins feature's data.
library pirate_code.features.pirate_coins.data;

import "package:appwrite/appwrite.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/api.dart";

part "coins_data.g.dart";

/// A repository for coin manipulation.
abstract interface class CoinsRepository {
  /// Get coins data from the [databases].
  Future<int> coinsData();

  /// Modify the coins in the [databases].
  Future<void> updateCoins(int coins);
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
  Future<int> coinsData() async {
    final user = await session.get();

    try {
      final data = await database.getDocument(
        databaseId: apiInfo.databaseId,
        collectionId: apiInfo.collectionId,
        documentId: user.email,
      );
      return data.data["Coins"] as int;
    } catch (e) {
      await _newDocument();
      final data = await database.getDocument(
        databaseId: apiInfo.databaseId,
        collectionId: apiInfo.collectionId,
        documentId: user.email,
      );
      return data.data["Coins"] as int;
    }
  }

  Future<void> _newDocument() async {
    final user = await session.get();

    await database.createDocument(
      databaseId: apiInfo.databaseId,
      collectionId: apiInfo.collectionId,
      documentId: user.email,
      data: {
        "Coins": 0,
      },
    );
  }

  /// Add coins to the database.
  @override
  Future<void> updateCoins(int coins) async {
    final user = await session.get();

    try {
      await database.updateDocument(
        databaseId: apiInfo.databaseId,
        collectionId: apiInfo.collectionId,
        documentId: user.email,
        data: {
          "Coins": coins,
        },
      );
    } catch (e) {
      await _newDocument();
      await database.updateDocument(
        databaseId: apiInfo.databaseId,
        collectionId: apiInfo.collectionId,
        documentId: user.email,
        data: {
          "Coins": coins,
        },
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
