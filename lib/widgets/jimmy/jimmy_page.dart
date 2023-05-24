import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../gen/assets.gen.dart";

@RoutePage()
class JimmyPage extends ConsumerWidget {
  const JimmyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Row(
        children: <Widget>[
          Expanded(
            child: GridView(
              primary: false,
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1,
              ),
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 253, 255, 178),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(59, 0, 0, 0),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      const FittedBox(
                        fit: BoxFit.cover,
                        child: Text(
                          "Pirate Coins",
                          style: TextStyle(fontSize: 80),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Image.asset(Assets.images.treasure.path),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 242, 184, 184),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(59, 0, 0, 0),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: const Text(" "),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 178, 254, 186),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(59, 0, 0, 0),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: const Text(" "),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 249, 183, 255),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(59, 0, 0, 0),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: const Text(" "),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 187, 198, 255),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(59, 0, 0, 0),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: const Text(" "),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 205, 130),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(59, 0, 0, 0),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: const Text(" "),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 205, 130),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(59, 0, 0, 0),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Text(" "),
            ),
          ),
        ],
      ),
    );
  }
}
