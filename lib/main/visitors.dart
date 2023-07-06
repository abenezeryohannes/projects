import '../src/flavors.dart';
import 'main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.visitors;
  await runner.main();
}
