/// This library contains utilities for logging.
library;

import "dart:developer" as developer;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:io/ansi.dart";
import "package:logging/logging.dart";
import "package:os_detect/os_detect.dart";

export "package:logging/logging.dart" show Logger;

/// Utility methods for logging.
extension LoggingUtils on Logger {
  /// Debug code when a value is still needed.
  T debug<T>(T value, [Object? message, Level level = Level.FINE]) {
    this.log(level, message ?? value);

    return value;
  }
}

/// Initialize the logger.
Future<void> initLogging([Level level = Level.INFO]) async {
  Logger.root.level = level;
  hierarchicalLoggingEnabled = true;
  Logger.root.onRecord.listen((record) async {
    // Don't use ansi output in the browser.
    final prefix = overrideAnsiOutput(
      !isBrowser && ansiOutputEnabled,
      () {
        final color = switch (record.level) {
          >= Level.SEVERE => red,
          >= Level.WARNING => yellow,
          Level() => cyan,
        };
        return color.wrap(
          "[${record.sequenceNumber}: ${record.level.name}@${record.time}]",
        );
      },
    );

    developer.log(
      "$prefix: ${record.message}",
      error: record.error.toString(),
      stackTrace: record.stackTrace,
      level: record.level.value,
      time: record.time,
      name: record.loggerName,
    );
  });
  Logger.root.onLevelChanged.listen((level) {
    Logger.root.info("Log level changed to $level");
  });
}

/// The app's logger.
final log = Logger("App");

/// Log provider updates to the console.
class ProviderLogger extends ProviderObserver {
  /// Create a new instance of [ProviderLogger].
  const ProviderLogger();

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log.finest("[${provider.name}] value: $newValue");
  }
}

/// Log routing events to the console.
class RouterLogger extends AutoRouterObserver {
  @override
  void didPush(
    Route<Object?> route,
    Route<Object?>? previousRoute,
  ) {
    log.finest("New route pushed: ${route.settings.name}");
  }

  @override
  void didPop(
    Route<Object?> route,
    Route<Object?>? previousRoute,
  ) {
    log.finest("Route popped: ${route.settings.name}");
  }

  @override
  void didRemove(
    Route<Object?> route,
    Route<Object?>? previousRoute,
  ) {
    log.finest("Route removed: ${route.settings.name}");
  }

  @override
  void didReplace({
    Route<Object?>? newRoute,
    Route<Object?>? oldRoute,
  }) {
    log.finest("Route replaced: ${newRoute?.settings.name}");
  }

  @override
  void didStartUserGesture(
    Route<Object?> route,
    Route<Object?>? previousRoute,
  ) {
    log.finest("User gesture started: ${route.settings.name}");
  }

  @override
  void didStopUserGesture() {
    log.finest("User gesture stopped");
  }

  @override
  void didInitTabRoute(
    TabPageRoute route,
    TabPageRoute? previousRoute,
  ) {
    log.finest("Tab route visited: ${route.name}");
  }

  @override
  void didChangeTabRoute(
    TabPageRoute route,
    TabPageRoute previousRoute,
  ) {
    log.finest("Tab route re-visited: ${route.name}");
  }
}
