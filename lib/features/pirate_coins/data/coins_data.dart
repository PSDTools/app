import "package:appwrite/appwrite.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/data/api.dart";

part "coins_data.g.dart";

/// Get coins data.
@riverpod
Future<int> coinsData(CoinsDataRef ref) async {
  final client = ref.watch(clientProvider);
  final apiInfo = ref.watch(apiInfoProvider);
  final database = Databases(client);
  final data = await database.getDocument(
    databaseId: apiInfo.databaseId,
    collectionId: apiInfo.collectionId,
    documentId: apiInfo.documentId,
  );

  return data.data["Coins"] as int;
}
