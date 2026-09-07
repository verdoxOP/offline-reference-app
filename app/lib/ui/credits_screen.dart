import 'package:flutter/material.dart';

import '../i18n/localization.dart';
import '../theme/dnp_colors.dart';
import '../theme/dnp_spacing.dart';
import '../theme/dnp_typography.dart';
import 'widgets/article_body.dart';
import 'widgets/dnp_app_bar.dart';

/// A first pass at the credits screen `assets/images/ATTRIBUTION.md` names
/// as a required follow-up ("it isn't yet surfaced in the UI") — not a
/// recreation of an existing screen, since none exists in the app yet.
class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key, required this.language});

  final AppLanguage language;

  // Verbatim from app/assets/images/ATTRIBUTION.md.
  static const _credits = [
    ('water-voedsel.jpg', 'Kerem Delialioğlu', 'CC BY-SA 4.0'),
    ('licht-stroom.jpg', 'Alanelavumkunel', 'CC BY-SA 4.0'),
    ('communicatie.jpg', 'Morn', 'CC BY-SA 4.0'),
    ('documenten-geld.jpg', 'Santeri Viinamäki', 'CC BY-SA 4.0'),
    ('noodplan.jpg', 'Pieria', 'Public domain'),
    ('vluchttas.jpg', 'American Red Cross', 'Public domain'),
    ('gezondheid-ehbo.jpg', 'Friedrich Haag', 'CC BY-SA 4.0'),
    ('nooddiensten.jpg', 'RegionalQueenslander', 'CC BY-SA 4.0'),
    ('noodsteunpunten.jpg', 'G. Edward Johnson', 'CC BY 4.0'),
    ('watertappunten.jpg', 'Donald Trung Quoc Don', 'CC BY-SA 4.0'),
    ('verzamelpunten.jpg', 'Ibrahim Husain Meraj', 'CC BY-SA 4.0'),
    ('faq-112-bellen.jpg', 'Unknown author', 'CC0'),
    ('faq-eten-bewaren.jpg', 'Federal Bureau of Investigation', 'Public domain'),
    ('faq-regenwater.jpg', 'Cornellrockey', 'CC BY-SA 4.0'),
    ('faq-info-zonder-internet.jpg', 'Kaldari', 'CC0'),
    ('kaart_tilburg.jpg', 'OpenStreetMap contributors', 'ODbL'),
    ('assets/tiles (Tilburg, z13-15)', 'OpenStreetMap contributors', 'ODbL'),
    ('assets/data/kaart_locations.json', 'OpenStreetMap contributors', 'ODbL'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DnpColors.surface1,
      appBar: DnpAppBar(
        title: Strings.of(language, 'credits'),
        language: language,
        onBack: () => Navigator.of(context).pop(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(DnpSpace.s4),
        children: [
          ArticleBody(text: Strings.of(language, 'creditsIntro')),
          const SizedBox(height: DnpSpace.s4),
          ClipRRect(
            borderRadius: BorderRadius.circular(DnpRadius.md),
            child: Container(
              color: DnpColors.borderSubtle,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < _credits.length; i++) ...[
                    if (i > 0) const SizedBox(height: 1),
                    _CreditRow(
                      file: _credits[i].$1,
                      author: _credits[i].$2,
                      license: _credits[i].$3,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CreditRow extends StatelessWidget {
  const _CreditRow({required this.file, required this.author, required this.license});

  final String file;
  final String author;
  final String license;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DnpColors.surface2,
      padding: const EdgeInsets.symmetric(horizontal: DnpSpace.s4, vertical: DnpSpace.s3),
      child: Row(
        children: [
          Expanded(
            child: Text(
              file,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: DnpType.smallMedium.copyWith(color: DnpColors.textPrimary, height: 1.3),
            ),
          ),
          const SizedBox(width: DnpSpace.s3),
          Text(
            author,
            style: DnpType.small.copyWith(color: DnpColors.textSecondary, height: 1.3),
          ),
          const SizedBox(width: DnpSpace.s3),
          Text(license, style: DnpType.mono(11).copyWith(color: DnpColors.textMuted)),
        ],
      ),
    );
  }
}
