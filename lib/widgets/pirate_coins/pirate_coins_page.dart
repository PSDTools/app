import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

// import '../../model.dart';

@RoutePage()
class PirateCoinsPage extends ConsumerWidget {
  const PirateCoinsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final appState = ref.watch(appStateProvider);
    const data = "All of them coins!";

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: const Padding(
              padding: EdgeInsets.all(500),
              child: Text(data),
            ),
          ),
        ],
      ),
    );
  }
}
