import '../data/personalized_guidance_dataset.dart';
import '../data/user_profile.dart';

class PersonalizationService {
  static List<PersonalizedGuidance> getGuidance(
      UserProfile profile,
      ) {
    final guidance = <PersonalizedGuidance>[];

    for (final condition in profile.medicalConditions) {
      guidance.addAll(
        medicalGuidanceDataset[condition] ?? const [],
      );
    }

    for (final allergy in profile.allergies) {
      guidance.addAll(
        allergyGuidanceDataset[allergy] ?? const [],
      );
    }

    if (profile.medications.isNotEmpty) {
      guidance.add(
        const PersonalizedGuidance(
          title: 'Neem voldoende medicatie mee',
          description:
          'Zorg dat belangrijke dagelijkse medicatie onderdeel is van je noodpakket en gemakkelijk bereikbaar is.',
          category: 'Medicatie',
        ),
      );
    }

    if (profile.reducedMobility) {
      guidance.add(
        const PersonalizedGuidance(
          title: 'Maak een evacuatieplan',
          description:
          'Denk vooraf na over hoe je kunt evacueren en wie je kan helpen wanneer zelfstandig verplaatsen moeilijk is.',
          category: 'Toegankelijkheid',
        ),
      );
    }

    if (profile.visualImpairment) {
      guidance.add(
        const PersonalizedGuidance(
          title: 'Houd hulpmiddelen op een vaste plek',
          description:
          'Bewaar belangrijke hulpmiddelen en noodspullen op een vaste en makkelijk herkenbare plek.',
          category: 'Toegankelijkheid',
        ),
      );
    }

    if (profile.hearingImpairment) {
      guidance.add(
        const PersonalizedGuidance(
          title: 'Gebruik visuele waarschuwingen',
          description:
          'Zorg waar mogelijk voor noodinformatie en waarschuwingen die niet uitsluitend afhankelijk zijn van geluid.',
          category: 'Toegankelijkheid',
        ),
      );
    }

    return guidance;
  }
}