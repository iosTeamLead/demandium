import 'package:flutter/foundation.dart';


class PlatformViewRegistryFix {
  registerViewFactory(dynamic x, dynamic y) {
    if (kIsWeb) {
      // ignore: undefined_prefixed_name
      PlatformViewRegistry.registerViewFactory(
        x,
        y,
      );
    } else {}
  }
}

class UniversalUI {
  PlatformViewRegistryFix platformViewRegistry = PlatformViewRegistryFix();
}

var ui = UniversalUI();
class PlatformViewRegistry {
  static registerViewFactory(String viewId, dynamic cb) {}
}