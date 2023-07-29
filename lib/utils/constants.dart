/// The constants used in the app.
library pirate_code.utils.constants;

import "package:flutter/foundation.dart";
import "../features/utils/domain/device_data.dart";

export "../../dart_define.gen.dart";

/// The current platform.
const BuildMode buildMode = kReleaseMode
    ? BuildMode.release
    : kProfileMode
        ? BuildMode.profile
        : BuildMode.debug;
