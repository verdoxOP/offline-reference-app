import 'package:flutter/material.dart';

import '../theme/dnp_colors.dart';
import '../theme/dnp_typography.dart';

/// First screen shown on launch: brand mark while the pre-packaged Isar
/// dataset opens (see AppDatabase.open — a bundled-asset copy the first
/// time, then a local file after). Purely presentational; no network calls
/// are made, or could be made, to get here.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DnpColors.accent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: DnpColors.slate1000,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.shield_outlined, color: DnpColors.accent, size: 30),
              ),
              const SizedBox(height: 40),
              Text('DNP', style: DnpType.display.copyWith(color: DnpColors.textOnAccent)),
              Container(
                width: 64,
                height: 3,
                margin: const EdgeInsets.symmetric(vertical: 10),
                color: DnpColors.slate1000,
              ),
              Text(
                'MijnNoodpakket',
                style: DnpType.heading.copyWith(color: DnpColors.textOnAccent),
              ),
              const SizedBox(height: 64),
              const Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.bolt, color: DnpColors.slate1000, size: 40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
