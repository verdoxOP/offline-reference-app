import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../i18n/localization.dart';
import '../../theme/dnp_colors.dart';

/// The three kinds of point-of-interest shown on the Kaart tab's map.
enum LocationType { ziekenhuis, politie, noodsteun }

LocationType? _typeFromString(String value) {
  for (final type in LocationType.values) {
    if (type.name == value) return type;
  }
  return null;
}

/// Icon + color for a [LocationType], used for both the map markers and the
/// filter chips.
class LocationTypeMeta {
  const LocationTypeMeta({required this.icon, required this.color, required this.labelKey});

  final IconData icon;
  final Color color;
  final String labelKey;
}

const _locationTypeMeta = {
  LocationType.ziekenhuis: LocationTypeMeta(
    icon: Icons.local_hospital,
    color: DnpColors.danger,
    labelKey: 'mapFilterHospitals',
  ),
  LocationType.politie: LocationTypeMeta(
    icon: Icons.local_police,
    color: DnpColors.info,
    labelKey: 'mapFilterPolice',
  ),
  LocationType.noodsteun: LocationTypeMeta(
    icon: Icons.groups,
    color: DnpColors.catFaq,
    labelKey: 'mapFilterSupport',
  ),
};

LocationTypeMeta locationTypeMeta(LocationType type) => _locationTypeMeta[type]!;

String locationTypeLabel(LocationType type, AppLanguage language) =>
    Strings.of(language, _locationTypeMeta[type]!.labelKey);

/// A single pre-packaged point of interest (hospital, police station, or
/// community support point) shown on the offline Tilburg map. Small and
/// static enough to ship as a plain JSON asset rather than an Isar
/// collection — see CLAUDE.md: don't compress or over-engineer storage for
/// data this small.
class KaartLocation {
  const KaartLocation({
    required this.id,
    required this.type,
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
  });

  final String id;
  final LocationType type;
  final String name;
  final String address;
  final double lat;
  final double lng;

  static KaartLocation? fromJson(Map<String, dynamic> json) {
    final type = _typeFromString(json['type'] as String);
    if (type == null) return null;
    return KaartLocation(
      id: json['id'] as String,
      type: type,
      name: json['name'] as String,
      address: json['address'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }

  static const _assetPath = 'assets/data/kaart_locations.json';

  static Future<List<KaartLocation>> loadAll() async {
    final raw = await rootBundle.loadString(_assetPath);
    final list = jsonDecode(raw) as List;
    return list
        .cast<Map<String, dynamic>>()
        .map(KaartLocation.fromJson)
        .whereType<KaartLocation>()
        .toList(growable: false);
  }
}
