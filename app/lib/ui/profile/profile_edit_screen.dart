import 'package:flutter/material.dart';

import '../../data/profile_options.dart';
import '../../data/user_db.dart';
import '../../data/user_profile.dart';
import '../../theme/dnp_colors.dart';
import '../../theme/dnp_spacing.dart';
import 'searchable_multi_select.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({
    super.key,
    required this.userDb,
    this.profile,
  });

  final UserDatabase userDb;
  final UserProfile? profile;

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _notesController;
  late final TextEditingController _emergencyNameController;
  late final TextEditingController _emergencyPhoneController;

  DateTime? _dateOfBirth;

  List<String> _medicalConditions = [];
  List<String> _allergies = [];
  List<String> _medications = [];

  String? _bloodType;

  bool _reducedMobility = false;
  bool _visualImpairment = false;
  bool _hearingImpairment = false;

  bool _saving = false;

  @override
  void initState() {
    super.initState();

    final profile = widget.profile;

    _nameController = TextEditingController(
      text: profile?.firstName ?? '',
    );

    _notesController = TextEditingController(
      text: profile?.medicalNotes ?? '',
    );

    _emergencyNameController = TextEditingController(
      text: profile?.emergencyContactName ?? '',
    );

    _emergencyPhoneController = TextEditingController(
      text: profile?.emergencyContactPhone ?? '',
    );

    _dateOfBirth = profile?.dateOfBirth;

    _medicalConditions = List<String>.from(
      profile?.medicalConditions ?? [],
    );

    _allergies = List<String>.from(
      profile?.allergies ?? [],
    );

    _medications = List<String>.from(
      profile?.medications ?? [],
    );

    _bloodType = profile?.bloodType.isNotEmpty == true
        ? profile!.bloodType
        : null;

    _reducedMobility = profile?.reducedMobility ?? false;
    _visualImpairment = profile?.visualImpairment ?? false;
    _hearingImpairment = profile?.hearingImpairment ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    _emergencyNameController.dispose();
    _emergencyPhoneController.dispose();

    super.dispose();
  }

  Future<void> _selectDateOfBirth() async {
    final now = DateTime.now();

    final selected = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime(now.year - 25),
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (selected == null) return;

    setState(() {
      _dateOfBirth = selected;
    });
  }

  Future<void> _save() async {
    if (_saving) return;

    setState(() {
      _saving = true;
    });

    final profile = widget.profile ?? UserProfile();

    profile
      ..firstName = _nameController.text.trim()
      ..dateOfBirth = _dateOfBirth
      ..bloodType = _bloodType ?? ''
      ..medicalConditions = _medicalConditions
      ..allergies = _allergies
      ..medications = _medications
      ..medicalNotes = _notesController.text.trim()
      ..reducedMobility = _reducedMobility
      ..visualImpairment = _visualImpairment
      ..hearingImpairment = _hearingImpairment
      ..emergencyContactName = _emergencyNameController.text.trim()
      ..emergencyContactPhone = _emergencyPhoneController.text.trim();

    await widget.userDb.saveProfile(profile);

    if (!mounted) return;

    Navigator.of(context).pop(true);
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DnpColors.surface1,
      appBar: AppBar(
        title: Text(
          widget.profile == null
              ? 'Profiel instellen'
              : 'Profiel bewerken',
        ),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: const Text('Opslaan'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(DnpSpace.s4),
        children: [
          const _SectionTitle('Persoonlijk'),

          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Voornaam',
            ),
          ),

          const SizedBox(height: DnpSpace.s3),

          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Geboortedatum'),
            subtitle: Text(
              _dateOfBirth == null
                  ? 'Niet ingevuld'
                  : _formatDate(_dateOfBirth!),
            ),
            trailing: const Icon(
              Icons.calendar_today_outlined,
            ),
            onTap: _selectDateOfBirth,
          ),

          const SizedBox(height: DnpSpace.s3),

          DropdownButtonFormField<String>(
            initialValue: _bloodType,
            decoration: const InputDecoration(
              labelText: 'Bloedgroep',
              border: OutlineInputBorder(),
            ),
            items: bloodTypeOptions.map((bloodType) {
              return DropdownMenuItem<String>(
                value: bloodType,
                child: Text(bloodType),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _bloodType = value;
              });
            },
          ),

          const SizedBox(height: DnpSpace.s5),

          const _SectionTitle('Medische informatie'),

          SearchableMultiSelect(
            title: 'Medische aandoeningen',
            options: medicalConditionOptions,
            selectedValues: _medicalConditions,
            onChanged: (values) {
              setState(() {
                _medicalConditions = values;
              });
            },
          ),

          const SizedBox(height: DnpSpace.s3),

          SearchableMultiSelect(
            title: 'Allergieën',
            options: allergyOptions,
            selectedValues: _allergies,
            onChanged: (values) {
              setState(() {
                _allergies = values;
              });
            },
          ),

          const SizedBox(height: DnpSpace.s3),

          SearchableMultiSelect(
            title: 'Medicatie',
            options: medicationOptions,
            selectedValues: _medications,
            onChanged: (values) {
              setState(() {
                _medications = values;
              });
            },
          ),

          const SizedBox(height: DnpSpace.s3),

          TextField(
            controller: _notesController,
            minLines: 3,
            maxLines: 6,
            decoration: const InputDecoration(
              labelText: 'Aanvullende medische informatie',
              alignLabelWithHint: true,
            ),
          ),

          const SizedBox(height: DnpSpace.s5),

          const _SectionTitle('Toegankelijkheid'),

          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Verminderde mobiliteit'),
            value: _reducedMobility,
            onChanged: (value) {
              setState(() {
                _reducedMobility = value;
              });
            },
          ),

          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Visuele beperking'),
            value: _visualImpairment,
            onChanged: (value) {
              setState(() {
                _visualImpairment = value;
              });
            },
          ),

          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Gehoorbeperking'),
            value: _hearingImpairment,
            onChanged: (value) {
              setState(() {
                _hearingImpairment = value;
              });
            },
          ),

          const SizedBox(height: DnpSpace.s5),

          const _SectionTitle('Noodcontact'),

          TextField(
            controller: _emergencyNameController,
            decoration: const InputDecoration(
              labelText: 'Naam',
            ),
          ),

          const SizedBox(height: DnpSpace.s3),

          TextField(
            controller: _emergencyPhoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Telefoonnummer',
            ),
          ),

          const SizedBox(height: DnpSpace.s5),

          FilledButton(
            onPressed: _saving ? null : _save,
            child: Text(
              _saving
                  ? 'Opslaan...'
                  : 'Profiel opslaan',
            ),
          ),

          const SizedBox(height: DnpSpace.s5),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: DnpSpace.s3,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}