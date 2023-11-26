import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

/// Creates a [GlobalKey] that will be disposed automatically.
///
/// See also:
/// - [GlobalKey]
GlobalKey<T> useGlobalKey<T extends State<StatefulWidget>>() {
  return useMemoized(GlobalKey<T>.new);
}

/// Creates a [TapGestureRecognizer] that will be disposed automatically.
///
/// See also:
/// - [TapGestureRecognizer]
TapGestureRecognizer useTapGestureRecognizer({
  void Function()? onTap,
  String? debugLabel,
  List<Object?>? keys,
}) {
  return use(_TapGestureRecognizerHook(onTap: onTap, keys: keys));
}

class _TapGestureRecognizerHook extends Hook<TapGestureRecognizer> {
  const _TapGestureRecognizerHook({
    this.onTap,
    super.keys,
  });

  final void Function()? onTap;

  @override
  HookState<TapGestureRecognizer, Hook<TapGestureRecognizer>> createState() =>
      _TapGestureRecognizerHookState();
}

class _TapGestureRecognizerHookState
    extends HookState<TapGestureRecognizer, _TapGestureRecognizerHook> {
  late final recognizer = TapGestureRecognizer();

  @override
  TapGestureRecognizer build(BuildContext context) {
    return recognizer..onTap = hook.onTap;
  }

  @override
  void dispose() => recognizer.dispose();

  @override
  String get debugLabel => "useTapGestureRecognizer";
}
