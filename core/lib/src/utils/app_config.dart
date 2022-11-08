import 'package:core/src/utils/enumeration.dart';
import 'package:flutter/material.dart';
import '../extentions/string_extentions.dart';

class FlavorValues {
  final String baseUrl;
  final String socketUrl;
  FlavorValues({required this.baseUrl, required this.socketUrl});
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final Color color;
  final FlavorValues values;
  static FlavorConfig? _instance;

  factory FlavorConfig(
      {required Flavor flavor,
      Color color: Colors.blue,
      required FlavorValues values}) {
    _instance ??= FlavorConfig._internal(
        flavor, flavor.toString().flavorString, color, values);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.name, this.color, this.values);
  static FlavorConfig? get instance {
    return _instance;
  }

  static bool isProduction() => _instance!.flavor == Flavor.PRODUCTION;
  static bool isDevelopment() => _instance!.flavor == Flavor.DEV;
  static bool isStage() => _instance!.flavor == Flavor.STAGE;
}
