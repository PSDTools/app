import "dart:developer" as developer;
import "package:io/ansi.dart";
import "package:logging/logging.dart";

Logger _logger({StackTrace? stackTrace}) {
  Logger.root.onRecord.listen((record) {
    final message = record.message;
    final error = record.error;
    stackTrace ??= record.stackTrace;

    final color = (record.level < Level.WARNING)
        ? cyan
        : (record.level < Level.SEVERE)
            ? yellow
            : red;

    developer.log(
      "[${color.wrap(record.level.name)}]: $message",
      error: error,
      stackTrace: stackTrace,
    );
  });

  return Logger("App");
}

/// Debug logging utilities.
extension Debug on Logger {
  /// Debug code, when a value is still needed.
  T debug<T>(String message, T value) {
    info(message);
    return value;
  }
}

/// The app's logger.
final log = _logger();
