import "package:flutter/material.dart";

/// The app's color scheme.
final ColorScheme scheme = ColorScheme.fromSeed(seedColor: Colors.green);

/// The app's theme.
final ThemeData theme = ThemeData(
  useMaterial3: true,
  colorScheme: scheme,
  appBarTheme: AppBarTheme(color: scheme.primary),
);
