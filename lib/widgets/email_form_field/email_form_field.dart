import "package:flutter/material.dart";

/// A [TextFormField] that only accepts valid email addresses.
class EmailFormField extends StatelessWidget {
  /// Create a new [EmailFormField].
  const EmailFormField(
    this._controller, {
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // The validator receives the text that the user has entered.
      validator: (value) => null,
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
