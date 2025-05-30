/// This library contains the design scheme for the application.
library;

import "package:flutter/material.dart";

/// The app's color scheme.
final scheme = ColorScheme.fromSeed(seedColor: Colors.green);

/// The app's theme.
final theme = ThemeData(
  useMaterial3: true,
  colorScheme: scheme,
  appBarTheme: AppBarTheme(color: scheme.primary),
);
