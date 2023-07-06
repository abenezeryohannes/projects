enum Flavor {
  visitors,
  guards,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.visitors:
        return 'RNG Supra Avenue management';
      case Flavor.guards:
        return 'RNG Supra Avenue security';
      default:
        return 'title';
    }
  }

}
