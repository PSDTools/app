/// This library contains a widget for validating emails in forms.
library;

import "package:flutter/material.dart";

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
    return TextFormField(
      // The validator receives the text that the user has entered.
      validator: validate,
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
// TODO(lishaduck): Add tests.
String? validate(String? value) {
  /*
    I'll probably need a regex for this.
    If so, would it be best to use the regex for all validation?
    It'd have less customized error messages, but it'd be more thorough.
    It'd also be more difficult to maintain, but might be faster to run the validations just once.
  */
  if (value == null || value.isEmpty) {
    return "Please enter your email address.";
  } else if (!value.contains("@")) {
    return "It looks like your email address is missing an '@' symbol.";
  } else if (!(value.substring(0, value.indexOf("@")).length > 1)) {
    return "It looks like your email address is missing content before the '@' symbol.";
  } else if (!(value.substring(value.indexOf("@")).length > 1)) {
    return "It looks like your email address is missing content after the '@' symbol.";
  } else if (value.contains("@") &&
      value.contains("@", value.indexOf("@") + 1)) {
    return "It looks like there are too many '@' symbols in your email address.";
  } else if (value.contains(" ")) {
    return "It looks like there are spaces in your email address.";
  } else if (value.contains("example.com") ||
      value.contains("example@") ||
      value.contains("@example.org")) {
    return "It looks like you're using an example email address. Please enter your real email address.";
  } else {
    return null;
  }
}
