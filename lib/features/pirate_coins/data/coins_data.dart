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
  AppwriteCoinsRepository(this.database);

  /// The Appwrite databases.
  final Databases database;

  @override
  Future<int> coinsData() async {
    final data = await database.getDocument(
      databaseId: apiInfo.databaseId,
      collectionId: apiInfo.collectionId,
      documentId: apiInfo.documentId,
    );
    return data.data["Coins"] as int;
  }

  /// Add coins to the database.
  @override
  Future<void> updateCoins(int coins) async {
    await database.updateDocument(
      databaseId: apiInfo.databaseId,
      collectionId: apiInfo.collectionId,
      documentId: apiInfo.documentId,
      data: {
        "Coins": coins,
      },
    );
  }
}

/// Get coins data.
@riverpod
CoinsRepository coinsData(CoinsDataRef ref) {
  final databases = ref.watch(databasesProvider);

  return AppwriteCoinsRepository(databases);
}
