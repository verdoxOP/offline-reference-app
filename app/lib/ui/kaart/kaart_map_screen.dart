import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../i18n/localization.dart';
import '../../theme/dnp_colors.dart';
import '../../theme/dnp_motion.dart';
import '../../theme/dnp_spacing.dart';
import '../../theme/dnp_typography.dart';
import '../widgets/dnp_app_bar.dart';
import '../widgets/pressable.dart';
import '../widgets/search_field.dart';
import 'kaart_location.dart';

/// The pre-packaged offline map bundled with the app: a basemap rendered
/// once from real OpenStreetMap road/water/park geometry for the Tilburg
/// city centre (assets/images/kaart_tilburg_map.png — see
/// assets/images/ATTRIBUTION.md), plus a small set of real hospital/police/
/// support-point locations (assets/data/kaart_locations.json), positioned
/// with a plain lat/lng-to-pixel projection over that same bbox. No network
/// access at any point, and no slippy-tile server dependency — everything
/// needed to draw the map ships with the app, per CLAUDE.md's offline
/// requirement.
///
/// Deliberately not a live web-tile map: `tile.openstreetmap.org` returns a
/// "not following the tile usage policy" block page for bulk/automated
/// fetches, so a bundled raster tile pyramid isn't something this app can
/// legitimately ship. A single self-rendered image (the same approach
/// already used for `kaart_tilburg.jpg`) sidesteps that entirely.
///
/// Pan/zoom is hand-rolled with a plain offset+scale (applied via
/// [Positioned]'s left/top/width/height, not a [Transform]/matrix) rather
/// than [InteractiveViewer] — a `Transform`-wrapped [Image] of this size
/// reliably failed to paint at all under this app's software-GL Linux
/// target while every non-`Transform` widget on the same screen rendered
/// fine, so this sidesteps that layer entirely.
class KaartMapScreen extends StatefulWidget {
  const KaartMapScreen({super.key, required this.language, this.initialFilter});

  final AppLanguage language;
  final LocationType? initialFilter;

  @override
  State<KaartMapScreen> createState() => _KaartMapScreenState();
}

class _KaartMapScreenState extends State<KaartMapScreen> {
  // Must match the bbox and pixel size baked into
  // assets/images/kaart_tilburg_map.png exactly (see the rendering note in
  // assets/images/ATTRIBUTION.md).
  static const _latMin = 51.535;
  static const _latMax = 51.585;
  static const _lngMin = 5.030;
  static const _lngMax = 5.140;
  static const _imageSize = 2200.0;
  static const _minScale = 0.3;
  static const _maxScale = 4.0;

  final _viewerKey = GlobalKey();
  final _searchController = TextEditingController();
  LocationType? _filter;
  List<KaartLocation> _locations = [];
  bool _loading = true;
  KaartLocation? _selected;
  String? _locationStatus;
  Offset? _myPixel;
  bool _didInitialCenter = false;

  // Pan/zoom state: `_offset` is where image-pixel (0,0) currently sits in
  // the viewport, `_scale` is image-pixels-to-viewport-pixels.
  Offset _offset = Offset.zero;
  double _scale = 1;
  Offset? _gestureStartFocalPoint;
  Offset? _gestureStartOffset;
  double? _gestureStartScale;

  @override
  void initState() {
    super.initState();
    _filter = widget.initialFilter;
    _searchController.addListener(() => setState(() {}));
    _load();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final locations = await KaartLocation.loadAll();
    if (!mounted) return;
    setState(() {
      _locations = locations;
      _loading = false;
    });
  }

  List<KaartLocation> get _visible {
    final query = _searchController.text.trim().toLowerCase();
    return _locations.where((loc) {
      if (_filter != null && loc.type != _filter) return false;
      if (query.isEmpty) return true;
      return loc.name.toLowerCase().contains(query) || loc.address.toLowerCase().contains(query);
    }).toList();
  }

  static Offset _project(double lat, double lng) {
    final x = (lng - _lngMin) / (_lngMax - _lngMin) * _imageSize;
    final y = (_latMax - lat) / (_latMax - _latMin) * _imageSize;
    return Offset(x, y);
  }

  Size? get _viewportSize {
    final box = _viewerKey.currentContext?.findRenderObject() as RenderBox?;
    return (box != null && box.hasSize) ? box.size : null;
  }

  /// Centers the viewer on Tilburg's centre the first time it's laid out.
  void _centerInitialViewIfNeeded() {
    if (_didInitialCenter) return;
    final size = _viewportSize;
    if (size == null) return;
    _didInitialCenter = true;
    _focusOn(_project(51.5591, 5.0828), scale: 1.4, viewportSize: size);
  }

  void _focusOn(Offset imagePoint, {double scale = 2.2, Size? viewportSize}) {
    final size = viewportSize ?? _viewportSize;
    if (size == null) return;
    final clamped = scale.clamp(_minScale, _maxScale);
    setState(() {
      _scale = clamped;
      _offset = Offset(
        size.width / 2 - imagePoint.dx * clamped,
        size.height / 2 - imagePoint.dy * clamped,
      );
    });
  }

  void _onScaleStart(ScaleStartDetails details) {
    _gestureStartFocalPoint = details.localFocalPoint;
    _gestureStartOffset = _offset;
    _gestureStartScale = _scale;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final startFocal = _gestureStartFocalPoint;
    final startOffset = _gestureStartOffset;
    final startScale = _gestureStartScale;
    if (startFocal == null || startOffset == null || startScale == null) return;
    final newScale = (startScale * details.scale).clamp(_minScale, _maxScale);
    // Keep the point under the gesture's focal point fixed on-screen as the
    // scale changes, then apply the pan on top of that.
    final scenePoint = (startFocal - startOffset) / startScale;
    setState(() {
      _scale = newScale;
      _offset = details.localFocalPoint - scenePoint * newScale;
    });
  }

  Future<void> _findMyLocation() async {
    setState(() => _locationStatus = Strings.of(widget.language, 'locating'));
    try {
      final enabled = await Geolocator.isLocationServiceEnabled();
      if (!enabled) throw Exception('disabled');
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception('denied');
      }
      final position = await Geolocator.getCurrentPosition().timeout(const Duration(seconds: 8));
      final point = _project(position.latitude, position.longitude);
      if (!mounted) return;
      setState(() {
        _myPixel = point;
        _locationStatus = null;
      });
      _focusOn(point);
    } catch (_) {
      if (!mounted) return;
      setState(() => _locationStatus = Strings.of(widget.language, 'myLocationUnavailable'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visible;
    return Scaffold(
      backgroundColor: DnpColors.surface1,
      appBar: DnpAppBar(
        title: Strings.of(widget.language, 'kaart'),
        language: widget.language,
        onBack: () => Navigator.of(context).pop(),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(DnpSpace.s4, DnpSpace.s3, DnpSpace.s4, DnpSpace.s3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DnpSearchField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  placeholder: Strings.of(widget.language, 'searchLocation'),
                  clearLabel: Strings.of(widget.language, 'clear'),
                ),
                const SizedBox(height: DnpSpace.s3),
                _FilterRow(
                  language: widget.language,
                  value: _filter,
                  onChanged: (v) => setState(() => _filter = v),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                if (_loading)
                  const Center(child: CircularProgressIndicator(color: DnpColors.accent))
                else
                  LayoutBuilder(
                    builder: (context, constraints) {
                      WidgetsBinding.instance
                          .addPostFrameCallback((_) => _centerInitialViewIfNeeded());
                      return ClipRect(
                        key: _viewerKey,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onScaleStart: _onScaleStart,
                          onScaleUpdate: _onScaleUpdate,
                          onTap: () => setState(() => _selected = null),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: _offset.dx,
                                top: _offset.dy,
                                width: _imageSize * _scale,
                                height: _imageSize * _scale,
                                child: Image.asset(
                                  'assets/images/kaart_tilburg_map.png',
                                  fit: BoxFit.fill,
                                  filterQuality: FilterQuality.medium,
                                ),
                              ),
                              for (final loc in visible)
                                Builder(builder: (context) {
                                  final p = _offset + _project(loc.lat, loc.lng) * _scale;
                                  return Positioned(
                                    left: p.dx - 18,
                                    top: p.dy - 18,
                                    width: 36,
                                    height: 36,
                                    child: _LocationPin(
                                      location: loc,
                                      selected: _selected?.id == loc.id,
                                      onTap: () => setState(() => _selected = loc),
                                    ),
                                  );
                                }),
                              if (_myPixel != null)
                                Builder(builder: (context) {
                                  final p = _offset + _myPixel! * _scale;
                                  return Positioned(
                                    left: p.dx - 11,
                                    top: p.dy - 11,
                                    width: 22,
                                    height: 22,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: DnpColors.info,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: DnpColors.surface1, width: 3),
                                      ),
                                    ),
                                  );
                                }),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                Positioned(
                  right: DnpSpace.s4,
                  bottom: DnpSpace.s4,
                  child: _MyLocationButton(onTap: _findMyLocation),
                ),
                if (_locationStatus != null)
                  Positioned(
                    left: DnpSpace.s4,
                    right: DnpSpace.s4,
                    top: DnpSpace.s3,
                    child: _StatusPill(text: _locationStatus!),
                  ),
                if (_selected != null)
                  Positioned(
                    left: DnpSpace.s4,
                    right: DnpSpace.s4,
                    bottom: DnpSpace.s4,
                    child: _LocationCard(location: _selected!, language: widget.language),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  const _FilterRow({required this.language, required this.value, required this.onChanged});

  final AppLanguage language;
  final LocationType? value;
  final ValueChanged<LocationType?> onChanged;

  @override
  Widget build(BuildContext context) {
    final items = <(LocationType?, String, Color)>[
      (null, Strings.of(language, 'mapFilterAll'), DnpColors.textSecondary),
      for (final type in LocationType.values)
        (type, locationTypeLabel(type, language), locationTypeMeta(type).color),
    ];
    return SizedBox(
      height: 34,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: DnpSpace.s2),
        itemBuilder: (context, i) {
          final (type, label, color) = items[i];
          final active = value == type;
          return Pressable(
            onTap: () => onChanged(type),
            semanticLabel: label,
            scaleOnPress: false,
            builder: (context, hovered, pressed) => AnimatedContainer(
              duration: DnpMotion.durFast,
              curve: DnpMotion.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: DnpSpace.s4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: active ? color.withValues(alpha: 0.16) : DnpColors.surface2,
                border: Border.all(color: active ? color : DnpColors.borderSubtle),
                borderRadius: BorderRadius.circular(DnpRadius.pill),
              ),
              child: Text(
                label,
                style: DnpType.chipLabel.copyWith(color: active ? color : DnpColors.textSecondary),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LocationPin extends StatelessWidget {
  const _LocationPin({required this.location, required this.selected, required this.onTap});

  final KaartLocation location;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final meta = locationTypeMeta(location.type);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: selected ? 1.15 : 1.0,
        duration: DnpMotion.durFast,
        child: Container(
          decoration: BoxDecoration(
            color: meta.color,
            shape: BoxShape.circle,
            border: Border.all(color: DnpColors.surface1, width: 2),
            boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 4)],
          ),
          alignment: Alignment.center,
          child: Icon(meta.icon, size: 18, color: DnpColors.textOnAccent),
        ),
      ),
    );
  }
}

class _MyLocationButton extends StatelessWidget {
  const _MyLocationButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      scaleOnPress: false,
      builder: (context, hovered, pressed) => Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: hovered ? DnpColors.surface3 : DnpColors.surface2,
          shape: BoxShape.circle,
          border: Border.all(color: DnpColors.borderDefault),
          boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 6)],
        ),
        child: const Icon(Icons.my_location, size: 20, color: DnpColors.accent),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: DnpSpace.s4, vertical: DnpSpace.s2),
      decoration: BoxDecoration(
        color: DnpColors.surface2.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(DnpRadius.pill),
        border: Border.all(color: DnpColors.borderDefault),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: DnpType.small.copyWith(color: DnpColors.textSecondary),
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard({required this.location, required this.language});

  final KaartLocation location;
  final AppLanguage language;

  @override
  Widget build(BuildContext context) {
    final meta = locationTypeMeta(location.type);
    return Container(
      padding: const EdgeInsets.all(DnpSpace.s4),
      decoration: BoxDecoration(
        color: DnpColors.surface2,
        borderRadius: BorderRadius.circular(DnpRadius.md),
        border: Border.all(color: DnpColors.borderDefault),
        boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 12)],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: meta.color, shape: BoxShape.circle),
            child: Icon(meta.icon, size: 20, color: DnpColors.textOnAccent),
          ),
          const SizedBox(width: DnpSpace.s3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  location.name,
                  style: DnpType.listItemTitle.copyWith(color: DnpColors.textPrimary),
                ),
                Text(
                  location.address,
                  style: DnpType.small.copyWith(color: DnpColors.textSecondary),
                ),
                Text(
                  locationTypeLabel(location.type, language),
                  style: DnpType.label.copyWith(color: meta.color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
