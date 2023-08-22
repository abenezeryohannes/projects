enum Flavor {
  residents,
  guards,
}

class FFF {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.residents:
        return 'RNG Supra Avenue management';
      case Flavor.guards:
        return 'RNG Supra Avenue security';
      default:
        return 'RNG Supra Avenue management';
    }
  }
}
