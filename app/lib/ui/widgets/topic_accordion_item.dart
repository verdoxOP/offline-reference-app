import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/db.dart';
import '../../i18n/localization.dart';
import '../../services/decompress_service.dart';
import '../../theme/dnp_colors.dart';
import '../../theme/dnp_motion.dart';
import '../../theme/dnp_spacing.dart';
import '../../theme/dnp_typography.dart';
import '../category_icons.dart';
import 'article_body.dart';
import 'dnp_button.dart';
import 'dnp_spinner.dart';
import 'empty_state.dart';
import 'pressable.dart';

/// One collapsible topic row for the Basis/Nood/FAQ tabs — the wireframe's
/// accordion list ("Water" expanded to show its full article inline,
/// "Communicatie" collapsed). Decompresses its body only the first time it's
/// expanded, then keeps the result for the life of the widget rather than
/// re-decompressing on every collapse/expand.
class TopicAccordionItem extends StatefulWidget {
  const TopicAccordionItem({
    super.key,
    required this.record,
    required this.language,
    this.initiallyExpanded = false,
  });

  final Record record;
  final AppLanguage language;
  final bool initiallyExpanded;

  @override
  State<TopicAccordionItem> createState() => _TopicAccordionItemState();
}

class _TopicAccordionItemState extends State<TopicAccordionItem> {
  final _decompressService = DecompressService();
  Future<String?>? _bodyFuture;
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
    if (_expanded) _ensureBodyLoading();
  }

  void _ensureBodyLoading() {
    if (_bodyFuture != null) return;
    final payload = widget.record.compressedPayload;
    _bodyFuture = payload == null ? null : _decompressService.decompress(payload).then(utf8.decode);
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) _ensureBodyLoading();
    });
  }

  Future<void> _call112() async {
    final uri = Uri(scheme: 'tel', path: '112');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final record = widget.record;
    final meta = categoryMeta(record.category);
    final isEmergency = categoryKeyForLabel(record.category) == CategoryKey.nood;

    return Container(
      decoration: BoxDecoration(
        color: DnpColors.surface2,
        border: Border.all(color: DnpColors.borderSubtle),
        borderRadius: BorderRadius.circular(DnpRadius.md),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Pressable(
            onTap: _toggle,
            semanticLabel: record.title,
            scaleOnPress: false,
            builder: (context, hovered, pressed) => Container(
              color: hovered ? DnpColors.surface3 : Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: DnpSpace.s4, vertical: DnpSpace.s3),
              child: Row(
                children: [
                  Icon(meta.icon, size: 20, color: meta.color),
                  const SizedBox(width: DnpSpace.s3),
                  Expanded(
                    child: Text(
                      record.title ?? '',
                      style: DnpType.listItemTitle.copyWith(color: DnpColors.textPrimary),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: DnpMotion.durFast,
                    curve: DnpMotion.easeInOut,
                    child: const Icon(Icons.expand_more, size: 22, color: DnpColors.textMuted),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            duration: DnpMotion.durFast,
            sizeCurve: DnpMotion.easeInOut,
            crossFadeState: _expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: Padding(
              padding: const EdgeInsets.fromLTRB(DnpSpace.s4, 0, DnpSpace.s4, DnpSpace.s4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(height: DnpSpace.s4, color: DnpColors.borderSubtle),
                  if (_bodyFuture == null)
                    Text(
                      Strings.of(widget.language, 'noDetails'),
                      style: DnpType.body.copyWith(color: DnpColors.textBody),
                    )
                  else
                    FutureBuilder<String?>(
                      future: _bodyFuture,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return EmptyState(
                            icon: Icons.error_outline,
                            title: Strings.of(widget.language, 'decompressError'),
                          );
                        }
                        if (!snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: DnpSpace.s4),
                            child: Center(
                              child: DnpSpinner(label: Strings.of(widget.language, 'decompressing')),
                            ),
                          );
                        }
                        return ArticleBody(text: snapshot.data ?? '');
                      },
                    ),
                  if (isEmergency) ...[
                    const SizedBox(height: DnpSpace.s4),
                    DnpButton(
                      label: Strings.of(widget.language, 'call112'),
                      variant: DnpButtonVariant.danger,
                      size: DnpButtonSize.md,
                      icon: Icons.call,
                      fullWidth: true,
                      onPressed: _call112,
                    ),
                  ],
                ],
              ),
            ),
            secondChild: const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}
