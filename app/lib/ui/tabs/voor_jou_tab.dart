import 'package:flutter/material.dart';

import '../../data/user_db.dart';
import '../../data/user_profile.dart';
import '../../theme/dnp_colors.dart';
import '../../theme/dnp_spacing.dart';
import '../../theme/dnp_typography.dart';

class VoorJouTab extends StatefulWidget {
  const VoorJouTab({
    super.key,
    required this.userDb,
  });

  final UserDatabase userDb;

  @override
  State<VoorJouTab> createState() => _VoorJouTabState();
}

class _VoorJouTabState extends State<VoorJouTab>
    with AutomaticKeepAliveClientMixin {
  UserProfile? _profile;
  bool _loading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final profile = await widget.userDb.getProfile();

    if (!mounted) return;

    setState(() {
      _profile = profile;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_profile == null) {
      return _buildNoProfile();
    }

    return _buildPersonalizedContent(_profile!);
  }

  Widget _buildNoProfile() {
    return ListView(
      padding: const EdgeInsets.all(DnpSpace.s4),
      children: [
        Container(
          padding: const EdgeInsets.all(DnpSpace.s4),
          decoration: BoxDecoration(
            color: DnpColors.surface2,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: DnpColors.borderSubtle,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.person_outline,
                color: DnpColors.accent,
                size: 28,
              ),
              const SizedBox(height: DnpSpace.s3),
              Text(
                'Stel je profiel in',
                style: DnpType.heading.copyWith(
                  color: DnpColors.textPrimary,
                ),
              ),
              const SizedBox(height: DnpSpace.s2),
              Text(
                'Voeg medische aandoeningen, allergieën en medicatie toe '
                    'om informatie te zien die past bij jouw situatie.',
                style: DnpType.body.copyWith(
                  color: DnpColors.textBody,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalizedContent(UserProfile profile) {
    final hasMedicalInfo =
        profile.medicalConditions.isNotEmpty ||
            profile.allergies.isNotEmpty ||
            profile.medications.isNotEmpty;

    if (!hasMedicalInfo) {
      return ListView(
        padding: const EdgeInsets.all(DnpSpace.s4),
        children: [
          Text(
            'Voor jou',
            style: DnpType.heading.copyWith(
              color: DnpColors.textPrimary,
            ),
          ),
          const SizedBox(height: DnpSpace.s2),
          Text(
            'Je hebt nog geen medische informatie aan je profiel toegevoegd.',
            style: DnpType.body.copyWith(
              color: DnpColors.textBody,
            ),
          ),
        ],
      );
    }

    return ListView(
      padding: const EdgeInsets.all(DnpSpace.s4),
      children: [
        Text(
          profile.firstName.trim().isEmpty
              ? 'Informatie voor jou'
              : 'Voor jou, ${profile.firstName}',
          style: DnpType.heading.copyWith(
            color: DnpColors.textPrimary,
          ),
        ),

        const SizedBox(height: DnpSpace.s2),

        Text(
          'Op basis van de gegevens in je profiel.',
          style: DnpType.body.copyWith(
            color: DnpColors.textSecondary,
          ),
        ),

        const SizedBox(height: DnpSpace.s4),

        if (profile.medicalConditions.isNotEmpty)
          _ProfileOverviewCard(
            icon: Icons.medical_information_outlined,
            title: 'Medische aandoeningen',
            values: profile.medicalConditions,
          ),

        if (profile.medicalConditions.isNotEmpty)
          const SizedBox(height: DnpSpace.s3),

        if (profile.allergies.isNotEmpty)
          _ProfileOverviewCard(
            icon: Icons.warning_amber_outlined,
            title: 'Allergieën',
            values: profile.allergies,
          ),

        if (profile.allergies.isNotEmpty)
          const SizedBox(height: DnpSpace.s3),

        if (profile.medications.isNotEmpty)
          _ProfileOverviewCard(
            icon: Icons.medication_outlined,
            title: 'Medicatie',
            values: profile.medications,
          ),

        const SizedBox(height: DnpSpace.s5),

        Text(
          'Belangrijk voor jou',
          style: DnpType.heading.copyWith(
            color: DnpColors.textPrimary,
          ),
        ),

        const SizedBox(height: DnpSpace.s3),

        Text(
          'Hier komen straks de aanbevelingen en noodinformatie '
              'die horen bij jouw medische situatie.',
          style: DnpType.body.copyWith(
            color: DnpColors.textBody,
          ),
        ),
      ],
    );
  }
}

class _ProfileOverviewCard extends StatelessWidget {
  const _ProfileOverviewCard({
    required this.icon,
    required this.title,
    required this.values,
  });

  final IconData icon;
  final String title;
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DnpSpace.s4),
      decoration: BoxDecoration(
        color: DnpColors.surface2,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: DnpColors.borderSubtle,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: DnpColors.accent,
            size: 22,
          ),

          const SizedBox(width: DnpSpace.s3),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: DnpType.body.copyWith(
                    color: DnpColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: DnpSpace.s2),

                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final value in values)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: DnpColors.surface3,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          value,
                          style: DnpType.body.copyWith(
                            color: DnpColors.textBody,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}