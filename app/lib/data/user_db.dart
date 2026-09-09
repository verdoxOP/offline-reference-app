import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'user_profile.dart';

class UserDatabase {
  UserDatabase._(this.isar);

  final Isar isar;

  static const _instanceName = 'user';

  static Future<UserDatabase> open() async {
    final docsDir = await getApplicationDocumentsDirectory();

    final isar = await Isar.open(
      [UserProfileSchema],
      directory: docsDir.path,
      name: _instanceName,
    );

    return UserDatabase._(isar);
  }

  Future<UserProfile?> getProfile() {
    return isar.userProfiles.get(1);
  }

  Future<void> saveProfile(UserProfile profile) async {
    profile.id = 1;

    await isar.writeTxn(() async {
      await isar.userProfiles.put(profile);
    });
  }

  Future<void> deleteProfile() async {
    await isar.writeTxn(() async {
      await isar.userProfiles.delete(1);
    });
  }
}