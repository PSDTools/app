/// {@category Translations}
/// The l10n utilities.
library;

import "package:flutter/widgets.dart";
import "app_localizations.dart";

export "app_localizations.dart";

/// Extension for [BuildContext] to access l10n via a getter.
extension AppLocalizationsX on BuildContext {
  /// Get the [AppLocalizations] for this [BuildContext].
  AppLocalizations get l10n => AppLocalizations.of(this);
}
