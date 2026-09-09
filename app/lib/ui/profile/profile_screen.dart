import 'package:flutter/material.dart';

import '../../data/user_db.dart';
import '../../data/user_profile.dart';
import '../../theme/dnp_colors.dart';
import '../../theme/dnp_spacing.dart';
import '../../theme/dnp_typography.dart';
import 'profile_edit_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.userDb,
  });

  final UserDatabase userDb;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfile? _profile;
  bool _loading = true;

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

  Future<void> _editProfile() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProfileEditScreen(
          userDb: widget.userDb,
          profile: _profile,
        ),
      ),
    );

    await _loadProfile();
  }

  Future<void> _deleteProfile() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Profiel verwijderen?'),
          content: const Text(
            'Alle lokaal opgeslagen profielgegevens worden verwijderd.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Annuleren'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Verwijderen'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    await widget.userDb.deleteProfile();

    if (!mounted) return;

    await _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DnpColors.surface1,
      appBar: AppBar(
        title: const Text('Mijn profiel'),
      ),
      body: _loading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : _profile == null
          ? _buildEmptyState()
          : _buildProfile(_profile!),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(DnpSpace.s4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.medical_information_outlined,
              size: 64,
              color: DnpColors.textSecondary,
            ),
            const SizedBox(height: DnpSpace.s4),
            Text(
              'Nog geen profiel ingesteld',
              style: DnpType.heading.copyWith(
                color: DnpColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DnpSpace.s2),
            Text(
              'Vul je persoonlijke en medische gegevens in. '
                  'Deze informatie wordt alleen op dit apparaat opgeslagen.',
              style: DnpType.body.copyWith(
                color: DnpColors.textBody,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DnpSpace.s4),
            FilledButton.icon(
              onPressed: _editProfile,
              icon: const Icon(Icons.add),
              label: const Text('Profiel instellen'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfile(UserProfile profile) {
    final displayName = profile.firstName.trim().isEmpty
        ? 'Mijn profiel'
        : profile.firstName;

    return ListView(
      padding: const EdgeInsets.all(DnpSpace.s4),
      children: [
        Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: DnpColors.surface2,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.person_outline,
                size: 32,
                color: DnpColors.textSecondary,
              ),
            ),
            const SizedBox(width: DnpSpace.s4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: DnpType.heading.copyWith(
                      color: DnpColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: DnpSpace.s1),
                  Text(
                    'Lokaal opgeslagen profiel',
                    style: DnpType.body.copyWith(
                      color: DnpColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: DnpSpace.s5),

        _ProfileSection(
          title: 'Medische informatie',
          children: [
            _ProfileField(
              label: 'Aandoeningen',
              value: _listValue(profile.medicalConditions),
            ),
            _ProfileField(
              label: 'Allergieën',
              value: _listValue(profile.allergies),
            ),
            _ProfileField(
              label: 'Medicatie',
              value: _listValue(profile.medications),
            ),
            _ProfileField(
              label: 'Aanvullende informatie',
              value: _valueOrEmpty(profile.medicalNotes),
            ),
          ],
        ),

        const SizedBox(height: DnpSpace.s4),

        _ProfileSection(
          title: 'Toegankelijkheid',
          children: [
            _ProfileField(
              label: 'Verminderde mobiliteit',
              value: profile.reducedMobility ? 'Ja' : 'Nee',
            ),
            _ProfileField(
              label: 'Visuele beperking',
              value: profile.visualImpairment ? 'Ja' : 'Nee',
            ),
            _ProfileField(
              label: 'Gehoorbeperking',
              value: profile.hearingImpairment ? 'Ja' : 'Nee',
            ),
          ],
        ),

        const SizedBox(height: DnpSpace.s4),

        _ProfileSection(
          title: 'Noodcontact',
          children: [
            _ProfileField(
              label: 'Naam',
              value: _valueOrEmpty(
                profile.emergencyContactName,
              ),
            ),
            _ProfileField(
              label: 'Telefoonnummer',
              value: _valueOrEmpty(
                profile.emergencyContactPhone,
              ),
            ),
          ],
        ),

        const SizedBox(height: DnpSpace.s5),

        FilledButton.icon(
          onPressed: _editProfile,
          icon: const Icon(Icons.edit_outlined),
          label: const Text('Profiel bewerken'),
        ),

        const SizedBox(height: DnpSpace.s2),

        TextButton(
          onPressed: _deleteProfile,
          child: const Text('Profiel verwijderen'),
        ),

        const SizedBox(height: DnpSpace.s5),
      ],
    );
  }

  String _listValue(List<String> values) {
    if (values.isEmpty) {
      return 'Niet ingevuld';
    }

    return values.join(', ');
  }

  String _valueOrEmpty(String value) {
    if (value.trim().isEmpty) {
      return 'Niet ingevuld';
    }

    return value;
  }
}

class _ProfileSection extends StatelessWidget {
  const _ProfileSection({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DnpSpace.s4),
      decoration: BoxDecoration(
        color: DnpColors.surface2,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: DnpType.heading.copyWith(
              color: DnpColors.textPrimary,
            ),
          ),
          const SizedBox(height: DnpSpace.s3),
          ...children,
        ],
      ),
    );
  }
}

class _ProfileField extends StatelessWidget {
  const _ProfileField({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: DnpSpace.s2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: DnpType.body.copyWith(
              color: DnpColors.textSecondary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: DnpType.body.copyWith(
              color: DnpColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}