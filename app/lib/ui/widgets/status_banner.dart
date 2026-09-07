import 'package:flutter/material.dart';

import '../../theme/dnp_colors.dart';
import '../../theme/dnp_spacing.dart';
import '../../theme/dnp_typography.dart';

/// The "Overzicht" status strip: the app's read on the current national
/// situation (e.g. no known power outage right now). This is the
/// wireframe's status card and replaces the old "fully available offline"
/// banner — that one stated a product capability, this states the thing the
/// user actually opens the app to check.
class StatusBanner extends StatelessWidget {
  const StatusBanner({super.key, required this.label, required this.emphasis});

  /// Full status sentence, e.g. "Er is op dit moment geen landelijke
  /// stroomuitval."
  final String label;

  /// The substring of [label] to render emphasized (bold + underline),
  /// matching the wireframe's treatment of the key words in the sentence.
  final String emphasis;

  @override
  Widget build(BuildContext context) {
    final start = label.indexOf(emphasis);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: DnpSpace.s4, vertical: DnpSpace.s3),
      decoration: BoxDecoration(
        color: DnpColors.warningQuiet,
        border: Border.all(color: DnpColors.warning),
        borderRadius: BorderRadius.circular(DnpRadius.md),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.bolt, size: 20, color: DnpColors.warning),
          const SizedBox(width: DnpSpace.s3),
          Expanded(
            child: RichText(
              text: start < 0
                  ? TextSpan(
                      style: DnpType.small.copyWith(color: DnpColors.textPrimary, height: 1.4),
                      text: label,
                    )
                  : TextSpan(
                      style: DnpType.small.copyWith(color: DnpColors.textPrimary, height: 1.4),
                      children: [
                        TextSpan(text: label.substring(0, start)),
                        TextSpan(
                          text: emphasis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(text: label.substring(start + emphasis.length)),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
