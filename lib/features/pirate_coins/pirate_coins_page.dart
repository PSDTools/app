import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

// import "../../providers/client.dart";
import "../../widgets/big_card/big_card.dart";

@RoutePage()
class PirateCoinsPage extends ConsumerWidget {
  const PirateCoinsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final appState = ref.watch(clientProvider);
    // final data = appState.coins;
    const data = 0;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: BigCard(data.toString()),
          ),
        ],
      ),
    );
  }
}
