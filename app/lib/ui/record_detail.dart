import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/db.dart';
import '../i18n/localization.dart';
import '../services/decompress_service.dart';
import '../theme/dnp_colors.dart';
import '../theme/dnp_spacing.dart';
import '../theme/dnp_typography.dart';
import 'category_icons.dart';
import 'widgets/article_body.dart';
import 'widgets/category_badge.dart';
import 'widgets/dnp_app_bar.dart';
import 'widgets/dnp_button.dart';
import 'widgets/dnp_spinner.dart';
import 'widgets/empty_state.dart';
import 'widgets/media_header.dart';

class RecordDetailScreen extends StatefulWidget {
  const RecordDetailScreen({super.key, required this.record, required this.language});

  final Record record;
  final AppLanguage language;

  @override
  State<RecordDetailScreen> createState() => _RecordDetailScreenState();
}

class _RecordDetailScreenState extends State<RecordDetailScreen> {
  final _decompressService = DecompressService();
  Future<String?>? _descriptionFuture;

  @override
  void initState() {
    super.initState();
    final payload = widget.record.compressedPayload;
    _descriptionFuture =
        payload == null ? null : _decompressService.decompress(payload).then(utf8.decode);
  }

  Future<void> _call112() async {
    final uri = Uri(scheme: 'tel', path: '112');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final record = widget.record;
    final imagePath = record.imageUrls?.isNotEmpty == true ? record.imageUrls!.first : null;
    // The Tilburg map is large enough to be worth panning/zooming into (real
    // streets and POIs); regular topic photos don't need that interaction.
    final isMap = imagePath?.endsWith('kaart_tilburg.jpg') ?? false;
    final isEmergency = categoryKeyForLabel(record.category) == CategoryKey.nood;

    return Scaffold(
      backgroundColor: DnpColors.surface1,
      appBar: DnpAppBar(
        title: record.title ?? '',
        subtitle: record.category,
        language: widget.language,
        onBack: () => Navigator.of(context).pop(),
      ),
      // The map's pan/zoom (InteractiveViewer) needs vertical drag gestures
      // for itself, so — as in the original screen — the image header stays
      // outside the scroll region and only the text body scrolls.
      body: Column(
        children: [
          MediaHeader(
            imageAsset: imagePath,
            category: record.category ?? '',
            height: isMap ? 320 : 200,
            interactive: isMap,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                DnpSpace.s4,
                DnpSpace.s4,
                DnpSpace.s4,
                DnpSpace.s10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (record.category != null) CategoryBadge(category: record.category!),
                  const SizedBox(height: DnpSpace.s4),
                  Text(
                    record.title ?? '',
                    style: DnpType.title.copyWith(color: DnpColors.textPrimary),
                  ),
                  const SizedBox(height: DnpSpace.s4),
                  if (_descriptionFuture == null)
                    Text(
                      Strings.of(widget.language, 'noDetails'),
                      style: DnpType.body.copyWith(color: DnpColors.textBody),
                    )
                  else
                    FutureBuilder<String?>(
                      future: _descriptionFuture,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          // Surface the failure instead of leaving the spinner
                          // stuck forever — e.g. a platform missing the
                          // system zstd library decompression depends on.
                          return EmptyState(
                            icon: Icons.error_outline,
                            title: Strings.of(widget.language, 'decompressError'),
                          );
                        }
                        if (!snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: DnpSpace.s6),
                            child: Center(
                              child: DnpSpinner(label: Strings.of(widget.language, 'decompressing')),
                            ),
                          );
                        }
                        return ArticleBody(lead: true, text: snapshot.data ?? '');
                      },
                    ),
                  if (isEmergency) ...[
                    const SizedBox(height: DnpSpace.s4),
                    DnpButton(
                      label: Strings.of(widget.language, 'call112'),
                      variant: DnpButtonVariant.danger,
                      size: DnpButtonSize.lg,
                      icon: Icons.call,
                      fullWidth: true,
                      onPressed: _call112,
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
