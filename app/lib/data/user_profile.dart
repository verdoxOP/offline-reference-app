import 'package:isar_community/isar.dart';

part 'user_profile.g.dart';

@collection
class UserProfile {
  Id id = 1;

  String firstName = '';

  DateTime? dateOfBirth;

  String bloodType = '';

  List<String> medicalConditions = [];
  List<String> allergies = [];
  List<String> medications = [];

  bool reducedMobility = false;
  bool visualImpairment = false;
  bool hearingImpairment = false;

  String emergencyContactName = '';
  String emergencyContactPhone = '';

  String medicalNotes = '';
}