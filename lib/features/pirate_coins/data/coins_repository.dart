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
  /// Get coins data from the [databases] via [realtime].
  Stream<CoinEntity> coinsData();

  /// Modify the coins in the [databases].
  Future<void> updateCoins(CoinEntity coin);
}

/// The default implementation of [CoinsRepository].
base class _AppwriteCoinsRepository implements CoinsRepository {
  /// Create a new instance of [_AppwriteCoinsRepository].
  const _AppwriteCoinsRepository(this.databases, this.id, this.sub);

  /// The Appwrite databases.
  final Databases databases;

  /// The user id.
  final int id;

  /// The realtime subscription.
  final Stream<RealtimeMessage> sub;

  @override
  Stream<CoinEntity> coinsData() async* {
    try {
      yield await _coinsData();
    } catch (e) {
      yield await _newDocument(_empty);
    }

    yield* sub.map((event) {
      final json = event.payload[r"$snapshot"];
      if (json is Map<String, Object?>) {
        return CoinEntity.fromJson(json);
      }
      return _empty;
    });
  }

  Future<CoinEntity> _coinsData() async {
    final json = await _getDocument();

    return CoinEntity.fromJson(json.data);
  }

  /// Add coins to the _database.
  @override
  Future<void> updateCoins(CoinEntity coin) async {
    try {
      await _updateDocument(coin);
    } catch (e) {
      await _newDocument(coin);
    }
  }

  Future<CoinEntity> _newDocument(CoinEntity data) async {
    await databases.createDocument(
      databaseId: apiInfo.databaseId,
      collectionId: apiInfo.collectionId,
      documentId: id.toString(),
      data: data.toJson(),
    );

    return data;
  }

  Future<Document> _getDocument() async {
    return databases.getDocument(
      databaseId: apiInfo.databaseId,
      collectionId: apiInfo.collectionId,
      documentId: id.toString(),
    );
  }

  Future<void> _updateDocument(CoinEntity coin) async {
    await databases.updateDocument(
      databaseId: apiInfo.databaseId,
      collectionId: apiInfo.collectionId,
      documentId: id.toString(),
      data: coin.toJson(),
    );
  }

  static const _empty = CoinEntity(coins: 0);
}

/// Get the coins data.
@riverpod
CoinsRepository coinsData(CoinsDataRef ref, int id) {
  final databases = ref.watch(databasesProvider);
  final channel = ref.watch(_channelProvider(id));

  return _AppwriteCoinsRepository(databases, id, channel);
}

@Riverpod(keepAlive: true)
class _Channel extends _$Channel {
  @override
  Raw<Stream<RealtimeMessage>> build(int user) {
    final realtime = ref.watch(realtimeProvider);

    final sub = realtime.subscribe(
      [
        "databases.${apiInfo.databaseId}.collections.${apiInfo.collectionId}.documents.$user",
      ],
    );
    ref.onDispose(sub.close);

    return sub.stream;
  }
}
