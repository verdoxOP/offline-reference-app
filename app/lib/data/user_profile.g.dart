// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserProfileCollection on Isar {
  IsarCollection<UserProfile> get userProfiles => this.collection();
}

const UserProfileSchema = CollectionSchema(
  name: r'UserProfile',
  id: 4738427352541298891,
  properties: {
    r'allergies': PropertySchema(
      id: 0,
      name: r'allergies',
      type: IsarType.stringList,
    ),
    r'bloodType': PropertySchema(
      id: 1,
      name: r'bloodType',
      type: IsarType.string,
    ),
    r'dateOfBirth': PropertySchema(
      id: 2,
      name: r'dateOfBirth',
      type: IsarType.dateTime,
    ),
    r'emergencyContactName': PropertySchema(
      id: 3,
      name: r'emergencyContactName',
      type: IsarType.string,
    ),
    r'emergencyContactPhone': PropertySchema(
      id: 4,
      name: r'emergencyContactPhone',
      type: IsarType.string,
    ),
    r'firstName': PropertySchema(
      id: 5,
      name: r'firstName',
      type: IsarType.string,
    ),
    r'hearingImpairment': PropertySchema(
      id: 6,
      name: r'hearingImpairment',
      type: IsarType.bool,
    ),
    r'medicalConditions': PropertySchema(
      id: 7,
      name: r'medicalConditions',
      type: IsarType.stringList,
    ),
    r'medicalNotes': PropertySchema(
      id: 8,
      name: r'medicalNotes',
      type: IsarType.string,
    ),
    r'medications': PropertySchema(
      id: 9,
      name: r'medications',
      type: IsarType.stringList,
    ),
    r'reducedMobility': PropertySchema(
      id: 10,
      name: r'reducedMobility',
      type: IsarType.bool,
    ),
    r'visualImpairment': PropertySchema(
      id: 11,
      name: r'visualImpairment',
      type: IsarType.bool,
    ),
  },

  estimateSize: _userProfileEstimateSize,
  serialize: _userProfileSerialize,
  deserialize: _userProfileDeserialize,
  deserializeProp: _userProfileDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _userProfileGetId,
  getLinks: _userProfileGetLinks,
  attach: _userProfileAttach,
  version: '3.3.2',
);

int _userProfileEstimateSize(
  UserProfile object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.allergies.length * 3;
  {
    for (var i = 0; i < object.allergies.length; i++) {
      final value = object.allergies[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.bloodType.length * 3;
  bytesCount += 3 + object.emergencyContactName.length * 3;
  bytesCount += 3 + object.emergencyContactPhone.length * 3;
  bytesCount += 3 + object.firstName.length * 3;
  bytesCount += 3 + object.medicalConditions.length * 3;
  {
    for (var i = 0; i < object.medicalConditions.length; i++) {
      final value = object.medicalConditions[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.medicalNotes.length * 3;
  bytesCount += 3 + object.medications.length * 3;
  {
    for (var i = 0; i < object.medications.length; i++) {
      final value = object.medications[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _userProfileSerialize(
  UserProfile object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.allergies);
  writer.writeString(offsets[1], object.bloodType);
  writer.writeDateTime(offsets[2], object.dateOfBirth);
  writer.writeString(offsets[3], object.emergencyContactName);
  writer.writeString(offsets[4], object.emergencyContactPhone);
  writer.writeString(offsets[5], object.firstName);
  writer.writeBool(offsets[6], object.hearingImpairment);
  writer.writeStringList(offsets[7], object.medicalConditions);
  writer.writeString(offsets[8], object.medicalNotes);
  writer.writeStringList(offsets[9], object.medications);
  writer.writeBool(offsets[10], object.reducedMobility);
  writer.writeBool(offsets[11], object.visualImpairment);
}

UserProfile _userProfileDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserProfile();
  object.allergies = reader.readStringList(offsets[0]) ?? [];
  object.bloodType = reader.readString(offsets[1]);
  object.dateOfBirth = reader.readDateTimeOrNull(offsets[2]);
  object.emergencyContactName = reader.readString(offsets[3]);
  object.emergencyContactPhone = reader.readString(offsets[4]);
  object.firstName = reader.readString(offsets[5]);
  object.hearingImpairment = reader.readBool(offsets[6]);
  object.id = id;
  object.medicalConditions = reader.readStringList(offsets[7]) ?? [];
  object.medicalNotes = reader.readString(offsets[8]);
  object.medications = reader.readStringList(offsets[9]) ?? [];
  object.reducedMobility = reader.readBool(offsets[10]);
  object.visualImpairment = reader.readBool(offsets[11]);
  return object;
}

P _userProfileDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? []) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readStringList(offset) ?? []) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readStringList(offset) ?? []) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userProfileGetId(UserProfile object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userProfileGetLinks(UserProfile object) {
  return [];
}

void _userProfileAttach(
  IsarCollection<dynamic> col,
  Id id,
  UserProfile object,
) {
  object.id = id;
}

extension UserProfileQueryWhereSort
    on QueryBuilder<UserProfile, UserProfile, QWhere> {
  QueryBuilder<UserProfile, UserProfile, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserProfileQueryWhere
    on QueryBuilder<UserProfile, UserProfile, QWhereClause> {
  QueryBuilder<UserProfile, UserProfile, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension UserProfileQueryFilter
    on QueryBuilder<UserProfile, UserProfile, QFilterCondition> {
  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  allergiesElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'allergies',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  allergiesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'allergies',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  allergiesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'allergies',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  allergiesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'allergies',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  allergiesElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'allergies',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  allergiesElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'allergies',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  allergiesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'allergies',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  allergiesElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'allergies',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  allergiesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'allergies', value: ''),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  allergiesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'allergies', value: ''),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  allergiesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'allergies', length, true, length, true);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  allergiesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'allergies', 0, true, 0, true);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  allergiesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'allergies', 0, false, 999999, true);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  allergiesLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'allergies', 0, true, length, include);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  allergiesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'allergies', length, include, 999999, true);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  allergiesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allergies',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  bloodTypeEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'bloodType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  bloodTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'bloodType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  bloodTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'bloodType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  bloodTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'bloodType',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  bloodTypeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'bloodType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  bloodTypeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'bloodType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  bloodTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'bloodType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  bloodTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'bloodType',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  bloodTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'bloodType', value: ''),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  bloodTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'bloodType', value: ''),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  dateOfBirthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'dateOfBirth'),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  dateOfBirthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'dateOfBirth'),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  dateOfBirthEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'dateOfBirth', value: value),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  dateOfBirthGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'dateOfBirth',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  dateOfBirthLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'dateOfBirth',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  dateOfBirthBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'dateOfBirth',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  emergencyContactNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'emergencyContactName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  emergencyContactNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'emergencyContactName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  emergencyContactNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'emergencyContactName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  emergencyContactNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'emergencyContactName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  emergencyContactNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'emergencyContactName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  emergencyContactNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'emergencyContactName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  emergencyContactNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'emergencyContactName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  emergencyContactNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'emergencyContactName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  emergencyContactNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'emergencyContactName', value: ''),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  emergencyContactNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'emergencyContactName',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  emergencyContactPhoneEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'emergencyContactPhone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  emergencyContactPhoneGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'emergencyContactPhone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  emergencyContactPhoneLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'emergencyContactPhone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  emergencyContactPhoneBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'emergencyContactPhone',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  emergencyContactPhoneStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'emergencyContactPhone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  emergencyContactPhoneEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'emergencyContactPhone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  emergencyContactPhoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'emergencyContactPhone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  emergencyContactPhoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'emergencyContactPhone',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  emergencyContactPhoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'emergencyContactPhone', value: ''),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  emergencyContactPhoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'emergencyContactPhone',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  firstNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'firstName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  firstNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'firstName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  firstNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'firstName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  firstNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'firstName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  firstNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'firstName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  firstNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'firstName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  firstNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'firstName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  firstNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'firstName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  firstNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'firstName', value: ''),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  firstNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'firstName', value: ''),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  hearingImpairmentEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hearingImpairment', value: value),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalConditionsElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'medicalConditions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalConditionsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'medicalConditions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalConditionsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'medicalConditions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalConditionsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'medicalConditions',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalConditionsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'medicalConditions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalConditionsElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'medicalConditions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalConditionsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'medicalConditions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalConditionsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'medicalConditions',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalConditionsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'medicalConditions', value: ''),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalConditionsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'medicalConditions', value: ''),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalConditionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'medicalConditions', length, true, length, true);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalConditionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'medicalConditions', 0, true, 0, true);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalConditionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'medicalConditions', 0, false, 999999, true);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalConditionsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'medicalConditions', 0, true, length, include);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalConditionsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'medicalConditions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalConditionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'medicalConditions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalNotesEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'medicalNotes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalNotesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'medicalNotes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalNotesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'medicalNotes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalNotesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'medicalNotes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalNotesStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'medicalNotes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalNotesEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'medicalNotes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalNotesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'medicalNotes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalNotesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'medicalNotes',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalNotesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'medicalNotes', value: ''),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicalNotesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'medicalNotes', value: ''),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicationsElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'medications',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicationsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'medications',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicationsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'medications',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicationsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'medications',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicationsElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'medications',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicationsElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'medications',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicationsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'medications',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicationsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'medications',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicationsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'medications', value: ''),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicationsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'medications', value: ''),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicationsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'medications', length, true, length, true);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicationsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'medications', 0, true, 0, true);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicationsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'medications', 0, false, 999999, true);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicationsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'medications', 0, true, length, include);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicationsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'medications', length, include, 999999, true);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  medicationsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'medications',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  reducedMobilityEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'reducedMobility', value: value),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
  visualImpairmentEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'visualImpairment', value: value),
      );
    });
  }
}

extension UserProfileQueryObject
    on QueryBuilder<UserProfile, UserProfile, QFilterCondition> {}

extension UserProfileQueryLinks
    on QueryBuilder<UserProfile, UserProfile, QFilterCondition> {}

extension UserProfileQuerySortBy
    on QueryBuilder<UserProfile, UserProfile, QSortBy> {
  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> sortByBloodType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bloodType', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> sortByBloodTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bloodType', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> sortByDateOfBirth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfBirth', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> sortByDateOfBirthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfBirth', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
  sortByEmergencyContactName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emergencyContactName', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
  sortByEmergencyContactNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emergencyContactName', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
  sortByEmergencyContactPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emergencyContactPhone', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
  sortByEmergencyContactPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emergencyContactPhone', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> sortByFirstName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> sortByFirstNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
  sortByHearingImpairment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hearingImpairment', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
  sortByHearingImpairmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hearingImpairment', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> sortByMedicalNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicalNotes', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
  sortByMedicalNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicalNotes', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> sortByReducedMobility() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reducedMobility', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
  sortByReducedMobilityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reducedMobility', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
  sortByVisualImpairment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visualImpairment', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
  sortByVisualImpairmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visualImpairment', Sort.desc);
    });
  }
}

extension UserProfileQuerySortThenBy
    on QueryBuilder<UserProfile, UserProfile, QSortThenBy> {
  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> thenByBloodType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bloodType', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> thenByBloodTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bloodType', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> thenByDateOfBirth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfBirth', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> thenByDateOfBirthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfBirth', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
  thenByEmergencyContactName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emergencyContactName', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
  thenByEmergencyContactNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emergencyContactName', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
  thenByEmergencyContactPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emergencyContactPhone', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
  thenByEmergencyContactPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emergencyContactPhone', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> thenByFirstName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> thenByFirstNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
  thenByHearingImpairment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hearingImpairment', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
  thenByHearingImpairmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hearingImpairment', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> thenByMedicalNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicalNotes', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
  thenByMedicalNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicalNotes', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> thenByReducedMobility() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reducedMobility', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
  thenByReducedMobilityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reducedMobility', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
  thenByVisualImpairment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visualImpairment', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
  thenByVisualImpairmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visualImpairment', Sort.desc);
    });
  }
}

extension UserProfileQueryWhereDistinct
    on QueryBuilder<UserProfile, UserProfile, QDistinct> {
  QueryBuilder<UserProfile, UserProfile, QDistinct> distinctByAllergies() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'allergies');
    });
  }

  QueryBuilder<UserProfile, UserProfile, QDistinct> distinctByBloodType({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bloodType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QDistinct> distinctByDateOfBirth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateOfBirth');
    });
  }

  QueryBuilder<UserProfile, UserProfile, QDistinct>
  distinctByEmergencyContactName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'emergencyContactName',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QDistinct>
  distinctByEmergencyContactPhone({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'emergencyContactPhone',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QDistinct> distinctByFirstName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firstName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QDistinct>
  distinctByHearingImpairment() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hearingImpairment');
    });
  }

  QueryBuilder<UserProfile, UserProfile, QDistinct>
  distinctByMedicalConditions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'medicalConditions');
    });
  }

  QueryBuilder<UserProfile, UserProfile, QDistinct> distinctByMedicalNotes({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'medicalNotes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QDistinct> distinctByMedications() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'medications');
    });
  }

  QueryBuilder<UserProfile, UserProfile, QDistinct>
  distinctByReducedMobility() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reducedMobility');
    });
  }

  QueryBuilder<UserProfile, UserProfile, QDistinct>
  distinctByVisualImpairment() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'visualImpairment');
    });
  }
}

extension UserProfileQueryProperty
    on QueryBuilder<UserProfile, UserProfile, QQueryProperty> {
  QueryBuilder<UserProfile, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserProfile, List<String>, QQueryOperations>
  allergiesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'allergies');
    });
  }

  QueryBuilder<UserProfile, String, QQueryOperations> bloodTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bloodType');
    });
  }

  QueryBuilder<UserProfile, DateTime?, QQueryOperations> dateOfBirthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateOfBirth');
    });
  }

  QueryBuilder<UserProfile, String, QQueryOperations>
  emergencyContactNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emergencyContactName');
    });
  }

  QueryBuilder<UserProfile, String, QQueryOperations>
  emergencyContactPhoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emergencyContactPhone');
    });
  }

  QueryBuilder<UserProfile, String, QQueryOperations> firstNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firstName');
    });
  }

  QueryBuilder<UserProfile, bool, QQueryOperations>
  hearingImpairmentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hearingImpairment');
    });
  }

  QueryBuilder<UserProfile, List<String>, QQueryOperations>
  medicalConditionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'medicalConditions');
    });
  }

  QueryBuilder<UserProfile, String, QQueryOperations> medicalNotesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'medicalNotes');
    });
  }

  QueryBuilder<UserProfile, List<String>, QQueryOperations>
  medicationsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'medications');
    });
  }

  QueryBuilder<UserProfile, bool, QQueryOperations> reducedMobilityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reducedMobility');
    });
  }

  QueryBuilder<UserProfile, bool, QQueryOperations> visualImpairmentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'visualImpairment');
    });
  }
}
