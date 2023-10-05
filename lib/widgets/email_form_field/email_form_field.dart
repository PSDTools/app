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
      validator: (value) {
        // TODO(lishaduck): Validate this string is a valid email.
        return null;
      },
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
