/// The pirate_coins feature's data.
library pirate_code.features.pirate_coins.data;

import "package:appwrite/appwrite.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/api.dart";

part "coins_data.g.dart";

/// A repository for coin manipulation.
abstract interface class CoinsRepository {
  /// Get coins data.
  Future<int> coinsData();

  /// Add coins to the database.
  Future<int> addCoins();
}

/// The default implementation of [CoinsRepository].
class AppwriteCoinsRepository implements CoinsRepository {
  /// Create a new instance of [AppwriteCoinsRepository].
  AppwriteCoinsRepository(this.client);

  /// The Appwrite client.
  final Client client;

  @override
  Future<int> coinsData() async {
    final database = Databases(client);
    final data = await database.getDocument(
      databaseId: apiInfo.databaseId,
      collectionId: apiInfo.collectionId,
      documentId: apiInfo.documentId,
    );
    return data.data["Coins"] as int;
  }

  ///Add coins to the database
  @override
  Future<int> addCoins() async {
    final database = Databases(client);
    final data = await database.updateDocument(
      databaseId: apiInfo.databaseId,
      collectionId: apiInfo.collectionId,
      documentId: apiInfo.documentId,
      data: {
        "Coins": 1,
      },
    );
    return data.data["Coins"] as int;
  }
}

/// Get coins data.
@riverpod
CoinsRepository coinsData(CoinsDataRef ref) {
  final client = ref.watch(clientProvider);

  return AppwriteCoinsRepository(client);
}
