import "app/app.dart";

/// Run the app.
/// This is the main function used for development.
Future<void> main() async {
  await const App().bootstrap();
}
