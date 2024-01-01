enum Flavor {
  residents,
  guards,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.residents:
        return 'RNG management';
      case Flavor.guards:
        return 'RNG security';
      default:
        return 'title';
    }
  }

}
