import 'package:flutter/material.dart';

enum MapMarkerCategory {
  spawn,
  resource,
  cave,
  obelisk,
}

class MapMarker {
  final String id;
  final String titleUa;
  final String titleEn;
  final MapMarkerCategory category;
  final double lat; // 0.0 to 100.0 (Latitude)
  final double lon; // 0.0 to 100.0 (Longitude)
  final String iconEmoji;
  final Color color;
  final int dangerLevel; // 1 to 5
  final String descriptionUa;
  final String? requiredItemsUa;
  final String subType; // 'rex', 'giga', 'metal', 'crystal', 'oil', etc.

  const MapMarker({
    required this.id,
    required this.titleUa,
    required this.titleEn,
    required this.category,
    required this.lat,
    required this.lon,
    required this.iconEmoji,
    required this.color,
    this.dangerLevel = 1,
    required this.descriptionUa,
    this.requiredItemsUa,
    required this.subType,
  });

  String get gpsText => 'LAT ${lat.toStringAsFixed(1)} | LON ${lon.toStringAsFixed(1)}';

  String get categoryNameUa {
    switch (category) {
      case MapMarkerCategory.spawn:
        return 'Спавн Істоти';
      case MapMarkerCategory.resource:
        return 'Родовище Ресурсів';
      case MapMarkerCategory.cave:
        return 'Печера / Артефакт';
      case MapMarkerCategory.obelisk:
        return 'Обеліск';
    }
  }
}

class ArkMapInfo {
  final String id;
  final String nameUa;
  final String nameEn;
  final String descriptionUa;
  final Color themeColor;
  final String badgeText;
  final List<String> biomesUa;
  final List<MapMarker> markers;

  const ArkMapInfo({
    required this.id,
    required this.nameUa,
    required this.nameEn,
    required this.descriptionUa,
    required this.themeColor,
    required this.badgeText,
    required this.biomesUa,
    required this.markers,
  });
}
