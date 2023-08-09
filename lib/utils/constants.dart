/// The constants used throughout the app.
library;

import "package:flutter/foundation.dart";

import "../features/utils/domain/device_model.dart";

export "../../dart_define.gen.dart";

/// The current platform.
const BuildMode buildMode = kReleaseMode
    ? BuildMode.release
    : kProfileMode
        ? BuildMode.profile
        : BuildMode.debug;
