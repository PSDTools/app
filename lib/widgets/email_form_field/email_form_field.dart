/// This library contains a widget for validating emails in forms.
library;

import "package:flutter/material.dart";

import "../../l10n/l10n.dart";

/// A [TextFormField] that only accepts valid email addresses.
class EmailFormField extends StatelessWidget {
  /// Create a new [EmailFormField].
  const EmailFormField(this._controller, {super.key});

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return TextFormField(
      // The validator receives the text that the user has entered.
      validator: (value) => validate(value, l10n),
      controller: _controller,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "example@example.com",
        border: OutlineInputBorder(),
      ),
      smartDashesType: SmartDashesType.disabled,
      smartQuotesType: SmartQuotesType.disabled,
    );
  }
}

/// Validate whether or not a given value is a valid email.
///
/// - If it is valid, return null.
/// - If it is invalid, return a string describing the error.
///
/// This is used by the [EmailFormField] widget.
@visibleForTesting
String? validate(String? value, AppLocalizations l10n) {
  // Do I need a parser library for this?
  if (value == null || value.isEmpty) {
    return l10n.email_validate_failed_empty;
  } else if (!value.contains("@")) {
    return l10n.email_validate_failed_missingAtSymbol;
  } else if (!(value.substring(0, value.indexOf("@")).length > 1)) {
    return l10n.email_validate_failed_missingBeforeAtSymbol;
  } else if (!(value.substring(value.indexOf("@")).length > 1)) {
    return l10n.email_validate_failed_missingAfterAtSymbol;
  } else if (value.contains("@") &&
      value.contains("@", value.indexOf("@") + 1)) {
    return l10n.email_validate_failed_tooManyAtSymbols;
  } else if (value.contains(" ")) {
    return l10n.email_validate_failed_containsSpaces;
  } else if (!value.substring(value.indexOf("@")).contains(".")) {
    return l10n.email_validate_failed_topLevelDomain;
  } else if (value.contains("example.com") ||
      value.contains("example@") ||
      value.contains("@example.org") ||
      value.contains("name@") ||
      value.contains("person@")) {
    return l10n.email_validate_failed_exampleEmail;
  } else {
    return null;
  }
}
