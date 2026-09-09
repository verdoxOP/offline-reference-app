import 'package:flutter/material.dart';

import '../../data/user_db.dart';
import '../../data/user_profile.dart';
import '../../data/personalized_guidance_dataset.dart';
import '../../services/personalization_service.dart';
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
    final guidance = PersonalizationService.getGuidance(profile);

    final groupedGuidance = <String, List<PersonalizedGuidance>>{};

    for (final item in guidance) {
      groupedGuidance
          .putIfAbsent(item.category, () => [])
          .add(item);
    }

    return RefreshIndicator(
      onRefresh: _loadProfile,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(DnpSpace.s4),
        children: [
          Text(
            profile.firstName.trim().isEmpty
                ? 'Voor jou'
                : 'Voor jou, ${profile.firstName}',
            style: DnpType.heading.copyWith(
              color: DnpColors.textPrimary,
            ),
          ),

          const SizedBox(height: DnpSpace.s2),

          Text(
            'Belangrijke informatie op basis van jouw profiel.',
            style: DnpType.body.copyWith(
              color: DnpColors.textSecondary,
            ),
          ),

          const SizedBox(height: DnpSpace.s4),

          if (guidance.isEmpty)
            _buildEmptyGuidance()
          else
            for (final entry in groupedGuidance.entries) ...[
              _GuidanceGroup(
                category: entry.key,
                guidance: entry.value,
              ),
              const SizedBox(height: DnpSpace.s4),
            ],
        ],
      ),
    );
  }

  Widget _buildEmptyGuidance() {
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
          const Icon(
            Icons.info_outline,
            color: DnpColors.accent,
            size: 22,
          ),
          const SizedBox(width: DnpSpace.s3),
          Expanded(
            child: Text(
              'Er zijn op dit moment geen persoonlijke aanbevelingen '
                  'voor de gegevens in je profiel.',
              style: DnpType.body.copyWith(
                color: DnpColors.textBody,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GuidanceGroup extends StatelessWidget {
  const _GuidanceGroup({
    required this.category,
    required this.guidance,
  });

  final String category;
  final List<PersonalizedGuidance> guidance;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Padding(
            padding: const EdgeInsets.all(DnpSpace.s4),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: DnpColors.surface3,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.medical_information_outlined,
                    color: DnpColors.accent,
                    size: 20,
                  ),
                ),

                const SizedBox(width: DnpSpace.s3),

                Expanded(
                  child: Text(
                    category.toUpperCase(),
                    style: DnpType.body.copyWith(
                      color: DnpColors.accent,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(
            height: 1,
            thickness: 1,
            color: DnpColors.borderSubtle,
          ),

          for (int i = 0; i < guidance.length; i++) ...[
            Padding(
              padding: const EdgeInsets.all(DnpSpace.s4),
              child: _GuidanceItem(
                guidance: guidance[i],
              ),
            ),

            if (i != guidance.length - 1)
              Divider(
                height: 1,
                thickness: 1,
                indent: DnpSpace.s4,
                endIndent: DnpSpace.s4,
                color: DnpColors.borderSubtle,
              ),
          ],
        ],
      ),
    );
  }
}
class _GuidanceItem extends StatelessWidget {
  const _GuidanceItem({
    required this.guidance,
  });

  final PersonalizedGuidance guidance;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 7),
          child: Icon(
            Icons.circle,
            size: 6,
            color: DnpColors.accent,
          ),
        ),
        const SizedBox(width: DnpSpace.s3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                guidance.title,
                style: DnpType.body.copyWith(
                  color: DnpColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: DnpSpace.s2),
              Text(
                guidance.description,
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
}