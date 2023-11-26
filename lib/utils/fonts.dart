import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:google_fonts/google_fonts.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "fonts.freezed.dart";
part "fonts.g.dart";

/// Check if a font's been loaded yet.
@riverpod
Future<void> isFontLoaded(IsFontLoadedRef ref, Fonts fonts) async =>
    GoogleFonts.pendingFonts(fonts.families);

/// A list of fonts to load, for use with [GoogleFonts].
@freezed
class Fonts with _$Fonts {
  /// Create a new, immutable [Fonts].
  const factory Fonts({
    /// The list of font families to load.
    required List<TextStyle> families,
  }) = _Font;
}
