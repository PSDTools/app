import "app/app.dart";

/// Run the app.
/// This is the main function used in production.
Future<void> main() async {
  await const App().bootstrap();
}
