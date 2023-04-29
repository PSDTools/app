// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'main.dart';

abstract class _$NavigationManager extends RootStackRouter {
  // ignore: unused_element
  _$NavigationManager({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    GeneratorRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: GeneratorPage(),
      );
    },
    FavoritesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: FavoritesPage(),
      );
    },
  };
}

/// generated route for
/// [GeneratorPage]
class GeneratorRoute extends PageRouteInfo<void> {
  const GeneratorRoute({List<PageRouteInfo>? children})
      : super(
          GeneratorRoute.name,
          initialChildren: children,
        );

  static const String name = 'GeneratorRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FavoritesPage]
class FavoritesRoute extends PageRouteInfo<void> {
  const FavoritesRoute({List<PageRouteInfo>? children})
      : super(
          FavoritesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoritesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
