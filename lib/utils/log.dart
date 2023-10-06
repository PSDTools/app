/// This library contains utilities for logging.
library;

import "dart:developer" as developer;

import "package:io/ansi.dart";
import "package:logging/logging.dart";
import "package:os_detect/os_detect.dart";

export "package:logging/logging.dart" show Logger;

/// Utility methods for logging.
extension LoggingUtils on Logger {
  /// Debug code when a value is still needed.
  T debug<T>(String message, T value) {
    fine(message);

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
          < Level.WARNING => cyan,
          < Level.SEVERE => yellow,
          _ => red,
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
