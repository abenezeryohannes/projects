import '../src/flavors.dart';
import 'main.dart' as runner;

Future<void> main() async {
  FFF.appFlavor = Flavor.residents;
  await runner.main();
}
