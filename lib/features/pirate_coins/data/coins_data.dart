/// The pirate_coins feature's data.
library pirate_code.features.pirate_coins.data;

import "package:appwrite/appwrite.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/api.dart";

part "coins_data.g.dart";

/// Get coins data.
@riverpod
Future<int> coinsData(CoinsDataRef ref) async {
  final client = ref.watch(clientProvider);
  final database = Databases(client);
  final data = await database.getDocument(
    databaseId: apiInfo.databaseId,
    collectionId: apiInfo.collectionId,
    documentId: apiInfo.documentId,
  );

  return data.data["Coins"] as int;
}
