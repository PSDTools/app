/// The l10n utilities.
library pirate_code.l10n;

import "package:flutter/widgets.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";

export "package:flutter_gen/gen_l10n/app_localizations.dart";

/// Extension for [BuildContext] to access l10n via a getter.
extension AppLocalizationsX on BuildContext {
  /// Get the [AppLocalizations] for this [BuildContext].
  AppLocalizations get l10n => AppLocalizations.of(this);
}
