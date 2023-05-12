import 'package:english_words/english_words.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
// import 'app_router.dart';
part 'main.gr.dart';

@AutoRouterConfig(replaceInRouteName: "Page,Route")
class NavigationManager extends _$NavigationManager {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: "/",
          page: MyHomeRoute.page,
          children: [
            AutoRoute(page: GeneratorRoute.page, path: ""),
            AutoRoute(page: FavoritesRoute.page, path: "favorites"),
          ],
        ),
        RedirectRoute(path: "*", redirectTo: "/"),
      ];
}

void main() {
  usePathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // make sure you don't initiate your router
  // inside of the build function.
  final _appRouter = NavigationManager();

  @override
  Widget build(BuildContext context) {
    final flutterLocale = Locale("en", "US");
    final theme = ColorScheme.fromSeed(seedColor: Colors.green);

    return ChangeNotifierProvider(
      create: ((context) => MyAppState()),
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: theme,
        ),
        locale: flutterLocale,
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var history = <WordPair>[];

  GlobalKey? historyListKey;

  void getNext() {
    history.insert(0, current);
    var animatedList = historyListKey?.currentState as AnimatedListState?;
    animatedList?.insertItem(0);
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>{};

  void toggleFavorite([WordPair? pair]) {
    pair = pair ?? current;
    if (favorites.contains(pair)) {
      favorites.remove(pair);
    } else {
      favorites.add(pair);
    }
    notifyListeners();
  }
}

@RoutePage()
class MyHomePage extends StatelessWidget {
  const MyHomePage();

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        return AutoTabsRouter(
          routes: const [
            GeneratorRoute(),
            FavoritesRoute(),
          ],
          builder: (context, child) {
            final tabsRouter = AutoTabsRouter.of(context);

            // The container for the current page, with its background color
            // and subtle switching animation.
            var mainArea = ColoredBox(
              color: colorScheme.surfaceVariant,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: AutoRouter(),
              ),
            );

            if (constraints.maxWidth < 450) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(context.topRoute.name),
                  leading: AutoLeadingButton(),
                  bottom: TabBar(
                    tabs: const [
                      Tab(text: '1', icon: Icon(Icons.abc)),
                      Tab(text: '2', icon: Icon(Icons.abc)),
                      Tab(text: '3', icon: Icon(Icons.abc)),
                    ],
                  ),
                ),
                body: mainArea,
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: tabsRouter.activeIndex,
                  onTap: tabsRouter.setActiveIndex,
                  items: [
                    BottomNavigationBarItem(
                      label: 'Home',
                      icon: Icon(Icons.home),
                    ),
                    BottomNavigationBarItem(
                      label: 'Favorites',
                      icon: Icon(Icons.favorite),
                    ),
                  ],
                ),
              );
            } else {
              return Scaffold(
                body: Row(
                  children: [
                    SafeArea(
                      child: NavigationRail(
                        extended: constraints.maxWidth >= 600,
                        destinations: [
                          NavigationRailDestination(
                            icon: Icon(Icons.home),
                            label: Text('Home'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.favorite),
                            label: Text('Favorites'),
                          ),
                        ],
                        selectedIndex: tabsRouter.activeIndex,
                        onDestinationSelected: tabsRouter.setActiveIndex,
                      ),
                    ),
                    Expanded(child: mainArea),
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }
}

@RoutePage()
class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: HistoryListView(),
          ),
          SizedBox(height: 10),
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}

@RoutePage()
class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appState = context.watch<MyAppState>();
    var favorites = appState.favorites;

    if (favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Text('You have '
              '${appState.favorites.length} favorites:'),
        ),
        Expanded(
          // Make better use of wide windows with a grid.
          child: GridView(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              childAspectRatio: 400 / 80,
            ),
            children: favorites
                .map(
                  (pair) => ListTile(
                    leading: IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        semanticLabel: 'Delete',
                      ),
                      color: theme.colorScheme.primary,
                      onPressed: () {
                        appState.toggleFavorite(pair);
                      },
                    ),
                    title: Text(
                      pair.asLowerCase,
                      semanticsLabel: pair.asPascalCase,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    Key? key,
    required this.pair,
  }) : super(key: key);

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: AnimatedSize(
          duration: Duration(milliseconds: 200),
          // Make sure that the compound word wraps correctly when the window
          // is too narrow.
          child: MergeSemantics(
            child: Wrap(
              children: [
                Text(
                  pair.first,
                  style: style.copyWith(fontWeight: FontWeight.w200),
                ),
                Text(
                  pair.second,
                  style: style.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BigListTile extends StatelessWidget {
  const BigListTile({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return ListTile(
      leading: IconButton(
        icon: Icon(
          Icons.delete_outline,
          semanticLabel: 'Delete',
        ),
        color: theme.colorScheme.primary,
        onPressed: () {
          appState.toggleFavorite(pair);
        },
      ),
      title: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: pair.asPascalCase,
        ),
      ),
    );
  }
}

class HistoryListView extends StatefulWidget {
  const HistoryListView({Key? key}) : super(key: key);

  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  /// Needed so that [MyAppState] can tell [AnimatedList] below to animate
  /// new items.
  final _key = GlobalKey();

  /// Used to "fade out" the history items at the top, to suggest continuation.
  static const Gradient _maskingGradient = LinearGradient(
    // This gradient goes from fully transparent to fully opaque black...
    colors: [Colors.transparent, Colors.black],
    // ... from the top (transparent) to half (0.5) of the way to the bottom.
    stops: [0.0, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    appState.historyListKey = _key;

    return ShaderMask(
      shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
      // This blend mode takes the opacity of the shader (i.e. our gradient)
      // and applies it to the destination (i.e. our animated list).
      blendMode: BlendMode.dstIn,
      child: AnimatedList(
        key: _key,
        reverse: true,
        padding: EdgeInsets.only(top: 100),
        initialItemCount: appState.history.length,
        itemBuilder: (context, index, animation) {
          final pair = appState.history[index];
          return SizeTransition(
            sizeFactor: animation,
            child: Center(
              child: TextButton.icon(
                onPressed: () {
                  appState.toggleFavorite(pair);
                },
                icon: appState.favorites.contains(pair)
                    ? Icon(Icons.favorite, size: 12)
                    : SizedBox(),
                label: Text(
                  pair.asLowerCase,
                  semanticsLabel: pair.asPascalCase,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
