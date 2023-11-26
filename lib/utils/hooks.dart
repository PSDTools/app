import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

/// Creates a [GlobalKey] that will be disposed automatically.
///
/// See also:
/// - [GlobalKey]
GlobalKey<T> useGlobalKey<T extends State<StatefulWidget>>() {
  return useMemoized(GlobalKey<T>.new);
}

