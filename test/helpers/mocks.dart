/// Mocks for testing.
///
/// {@category Testing}
library;

import "package:mocktail/mocktail.dart";
import "package:pirate_code/features/auth/data/auth_data.dart";

class MockAuthRepository extends Mock implements AuthRepository {}
