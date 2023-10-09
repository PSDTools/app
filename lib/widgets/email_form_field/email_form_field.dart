/// This library contains a widget for validating emails in forms.
library;

import "package:flutter/material.dart";

import "../../l10n/l10n.dart";

/// A [TextFormField] that only accepts valid email addresses.
class EmailFormField extends StatelessWidget {
  /// Create a new [EmailFormField].
  const EmailFormField(
    this._controller, {
    super.key,
  });

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return TextFormField(
      // The validator receives the text that the user has entered.
      validator: (value) => validate(
        value,
        emptyText: l10n.empty,
        missingAtSymbolText: l10n.missingAtSymbol,
        missingBeforeAtSymbolText: l10n.missingBeforeAtSymbol,
        missingAfterAtSymbolText: l10n.missingAfterAtSymbol,
        tooManyAtSymbolsText: l10n.tooManyAtSymbols,
        containsSpacesText: l10n.containsSpaces,
        topLevelDomainText: l10n.topLevelDomain,
        exampleEmailText: l10n.exampleEmail,
      ),
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
String? validate(
  String? value, {
  String emptyText = "",
  String missingAtSymbolText = "",
  String missingBeforeAtSymbolText = "",
  String missingAfterAtSymbolText = "",
  String tooManyAtSymbolsText = "",
  String containsSpacesText = "",
  String topLevelDomainText = "",
  String exampleEmailText = "",
}) {
  /*
    I'll probably need a regex for this.
    If so, would it be best to use the regex for all validation?
    It'd have less customized error messages, but it'd be more thorough.
    It'd also be more difficult to maintain, but might be faster to run the validations just once.
  */
  if (value == null || value.isEmpty) {
    return emptyText;
  } else if (!value.contains("@")) {
    return missingAtSymbolText;
  } else if (!(value.substring(0, value.indexOf("@")).length > 1)) {
    return missingBeforeAtSymbolText;
  } else if (!(value.substring(value.indexOf("@")).length > 1)) {
    return missingAfterAtSymbolText;
  } else if (value.contains("@") &&
      value.contains("@", value.indexOf("@") + 1)) {
    return tooManyAtSymbolsText;
  } else if (value.contains(" ")) {
    return containsSpacesText;
  } else if (!value.substring(value.indexOf("@")).contains(".")) {
    return topLevelDomainText;
  } else if (value.contains("example.com") ||
      value.contains("example@") ||
      value.contains("@example.org") ||
      value.contains("name@") ||
      value.contains("person@")) {
    return exampleEmailText;
  } else {
    return null;
  }
}
