class PersonalizedGuidance {
  const PersonalizedGuidance({
    required this.title,
    required this.description,
    required this.category,
  });

  final String title;
  final String description;
  final String category;
}

const Map<String, List<PersonalizedGuidance>> medicalGuidanceDataset = {
  'Astma': [
    PersonalizedGuidance(
      title: 'Houd je inhalator bereikbaar',
      description:
      'Bewaar je inhalatiemedicatie op een plek waar je er tijdens een noodsituatie direct bij kunt.',
      category: 'Astma',
    ),
    PersonalizedGuidance(
      title: 'Vermijd rook en stof',
      description:
      'Rook, stof en slechte luchtkwaliteit kunnen ademhalingsklachten verergeren. Zoek indien mogelijk een plek met schone lucht.',
      category: 'Astma',
    ),
  ],

  'Diabetes type 1': [
    PersonalizedGuidance(
      title: 'Neem voldoende diabetesbenodigdheden mee',
      description:
      'Zorg dat insuline, meetmateriaal en andere noodzakelijke benodigdheden onderdeel zijn van je noodpakket.',
      category: 'Diabetes',
    ),
    PersonalizedGuidance(
      title: 'Neem snelle suikers mee',
      description:
      'Bewaar bijvoorbeeld druivensuiker of een andere bron van snelle koolhydraten op een makkelijk bereikbare plek.',
      category: 'Diabetes',
    ),
    PersonalizedGuidance(
      title: 'Let op de opslag van insuline',
      description:
      'Bescherm insuline zoveel mogelijk tegen extreme hitte, direct zonlicht en vorst.',
      category: 'Diabetes',
    ),
  ],

  'Diabetes type 2': [
    PersonalizedGuidance(
      title: 'Houd je medicatie bereikbaar',
      description:
      'Zorg dat je dagelijkse diabetesmedicatie gemakkelijk te vinden is tijdens een noodsituatie.',
      category: 'Diabetes',
    ),
    PersonalizedGuidance(
      title: 'Neem geschikt voedsel mee',
      description:
      'Neem voedsel mee waarvan je weet dat het goed past bij jouw normale voedingspatroon.',
      category: 'Diabetes',
    ),
  ],

  'Epilepsie': [
    PersonalizedGuidance(
      title: 'Houd je medicatie bij de hand',
      description:
      'Zorg dat je epilepsiemedicatie eenvoudig bereikbaar is en probeer je normale innameschema te behouden.',
      category: 'Epilepsie',
    ),
    PersonalizedGuidance(
      title: 'Informeer mensen in je omgeving',
      description:
      'Zorg dat mensen bij je weten dat je epilepsie hebt en weten wat zij moeten doen wanneer je een aanval krijgt.',
      category: 'Epilepsie',
    ),
  ],

  'Hoge bloeddruk': [
    PersonalizedGuidance(
      title: 'Neem je dagelijkse medicatie mee',
      description:
      'Zorg dat bloeddrukmedicatie onderdeel is van je noodvoorraad en bewaar deze op een vaste plek.',
      category: 'Bloeddruk',
    ),
    PersonalizedGuidance(
      title: 'Vermijd overmatige inspanning',
      description:
      'Probeer tijdens een noodsituatie rustmomenten te nemen en zware lichamelijke inspanning te beperken wanneer dat mogelijk is.',
      category: 'Bloeddruk',
    ),
  ],

  'Lage bloeddruk': [
    PersonalizedGuidance(
      title: 'Sta rustig op',
      description:
      'Kom langzaam overeind wanneer je lang hebt gezeten of gelegen om duizeligheid en vallen te helpen voorkomen.',
      category: 'Bloeddruk',
    ),
    PersonalizedGuidance(
      title: 'Let op voldoende drinken',
      description:
      'Zorg dat je voldoende drinkwater beschikbaar hebt, vooral wanneer het warm is of je veel inspanning levert.',
      category: 'Bloeddruk',
    ),
  ],

  'Hartziekte': [
    PersonalizedGuidance(
      title: 'Houd hartmedicatie bereikbaar',
      description:
      'Zorg dat belangrijke medicatie direct beschikbaar is wanneer je je huis moet verlaten.',
      category: 'Hart',
    ),
    PersonalizedGuidance(
      title: 'Plan evacuatie zonder onnodige inspanning',
      description:
      'Probeer zware lichamelijke belasting tijdens evacuatie te beperken en vraag hulp wanneer dat nodig is.',
      category: 'Hart',
    ),
  ],

  'Hartritmestoornis': [
    PersonalizedGuidance(
      title: 'Neem je medicatie mee',
      description:
      'Bewaar medicijnen die je voor je hartritme gebruikt op een vaste en snel bereikbare plek.',
      category: 'Hart',
    ),
    PersonalizedGuidance(
      title: 'Beperk onnodige lichamelijke belasting',
      description:
      'Probeer tijdens evacuatie of langdurige noodsituaties voldoende rustmomenten te nemen.',
      category: 'Hart',
    ),
  ],

  'COPD': [
    PersonalizedGuidance(
      title: 'Vermijd rook en vervuilde lucht',
      description:
      'Rook, fijnstof en slechte luchtkwaliteit kunnen ademhalingsproblemen verergeren. Zoek indien mogelijk een goed geventileerde plek.',
      category: 'COPD',
    ),
    PersonalizedGuidance(
      title: 'Neem ademhalingsmedicatie mee',
      description:
      'Zorg dat inhalatoren en andere belangrijke medicatie onderdeel zijn van je noodpakket.',
      category: 'COPD',
    ),
  ],

  'Migraine': [
    PersonalizedGuidance(
      title: 'Neem je gebruikelijke medicatie mee',
      description:
      'Bewaar medicatie die je normaal gebruikt tegen migraine in je noodpakket.',
      category: 'Migraine',
    ),
    PersonalizedGuidance(
      title: 'Zoek rust wanneer mogelijk',
      description:
      'Fel licht, lawaai, stress en slaaptekort kunnen klachten verergeren. Zoek indien mogelijk een rustige en donkere plek.',
      category: 'Migraine',
    ),
  ],

  'Artrose': [
    PersonalizedGuidance(
      title: 'Plan extra tijd voor verplaatsen',
      description:
      'Pijn en stijfheid kunnen lopen en tillen moeilijker maken. Houd hier rekening mee bij een evacuatie.',
      category: 'Mobiliteit',
    ),
    PersonalizedGuidance(
      title: 'Neem noodzakelijke hulpmiddelen mee',
      description:
      'Zorg dat hulpmiddelen die je dagelijks gebruikt direct bereikbaar zijn.',
      category: 'Mobiliteit',
    ),
  ],

  'Reumatoïde artritis': [
    PersonalizedGuidance(
      title: 'Neem je medicatie mee',
      description:
      'Zorg dat noodzakelijke dagelijkse medicatie onderdeel is van je noodvoorraad.',
      category: 'Mobiliteit',
    ),
    PersonalizedGuidance(
      title: 'Houd rekening met beperkte mobiliteit',
      description:
      'Plan extra tijd voor lopen, traplopen en het dragen van spullen tijdens een evacuatie.',
      category: 'Mobiliteit',
    ),
  ],

  'Osteoporose': [
    PersonalizedGuidance(
      title: 'Voorkom vallen',
      description:
      'Let extra op losse voorwerpen, donkere ruimtes en beschadigde vloeren tijdens een noodsituatie.',
      category: 'Mobiliteit',
    ),
    PersonalizedGuidance(
      title: 'Vraag hulp bij zwaar tillen',
      description:
      'Laat zware noodtassen of andere voorwerpen indien mogelijk door iemand anders dragen.',
      category: 'Mobiliteit',
    ),
  ],

  'Chronische nierziekte': [
    PersonalizedGuidance(
      title: 'Neem noodzakelijke medicatie mee',
      description:
      'Bewaar je dagelijkse medicatie samen met je andere belangrijke noodspullen.',
      category: 'Nierziekte',
    ),
    PersonalizedGuidance(
      title: 'Houd rekening met je normale dieet',
      description:
      'Kies voor je noodvoorraad zoveel mogelijk voedsel dat past bij de voedingsadviezen die je normaal volgt.',
      category: 'Nierziekte',
    ),
  ],

  'Chronische leverziekte': [
    PersonalizedGuidance(
      title: 'Houd je medicatie bereikbaar',
      description:
      'Zorg dat belangrijke medicatie gemakkelijk meegenomen kan worden bij een evacuatie.',
      category: 'Leverziekte',
    ),
    PersonalizedGuidance(
      title: 'Neem vertrouwd voedsel mee',
      description:
      'Kies voor je noodvoorraad voedsel waarvan je weet dat het binnen je normale voedingspatroon past.',
      category: 'Leverziekte',
    ),
  ],

  'Schildklieraandoening': [
    PersonalizedGuidance(
      title: 'Neem voldoende medicatie mee',
      description:
      'Wanneer je dagelijks schildkliermedicatie gebruikt, zorg dan dat deze onderdeel is van je noodvoorraad.',
      category: 'Schildklier',
    ),
    PersonalizedGuidance(
      title: 'Bewaar medicatie op een vaste plek',
      description:
      'Een vaste plek maakt het makkelijker om medicatie snel mee te nemen wanneer je onverwacht moet vertrekken.',
      category: 'Schildklier',
    ),
  ],

  'Bloedarmoede': [
    PersonalizedGuidance(
      title: 'Plan voldoende rust',
      description:
      'Vermoeidheid en kortademigheid kunnen tijdens fysieke inspanning toenemen. Neem waar mogelijk voldoende rust.',
      category: 'Bloedarmoede',
    ),
    PersonalizedGuidance(
      title: 'Vermijd onnodig zware inspanning',
      description:
      'Laat zware spullen indien mogelijk door iemand anders dragen tijdens een evacuatie.',
      category: 'Bloedarmoede',
    ),
  ],

  'Hemofilie': [
    PersonalizedGuidance(
      title: 'Voorkom verwondingen',
      description:
      'Let extra op scherpe voorwerpen, puin en andere situaties waarbij je jezelf kunt verwonden.',
      category: 'Hemofilie',
    ),
    PersonalizedGuidance(
      title: 'Maak je aandoening zichtbaar voor hulpverleners',
      description:
      'Zorg dat belangrijke informatie over je hemofilie gemakkelijk beschikbaar is wanneer je medische hulp nodig hebt.',
      category: 'Hemofilie',
    ),
  ],

  'Coeliakie': [
    PersonalizedGuidance(
      title: 'Neem glutenvrij noodvoedsel mee',
      description:
      'Zorg dat een deel van je noodvoorraad bestaat uit producten waarvan je weet dat ze glutenvrij zijn.',
      category: 'Coeliakie',
    ),
    PersonalizedGuidance(
      title: 'Controleer verpakkingen',
      description:
      'Controleer ingrediënten en allergeneninformatie voordat je onbekende noodvoeding gebruikt.',
      category: 'Coeliakie',
    ),
  ],

  'Ziekte van Crohn': [
    PersonalizedGuidance(
      title: 'Let extra op uitdroging',
      description:
      'Diarree en beperkte toegang tot drinken kunnen het risico op uitdroging vergroten. Zorg voor voldoende drinkwater.',
      category: 'Ziekte van Crohn',
    ),
    PersonalizedGuidance(
      title: 'Neem geschikt voedsel mee',
      description:
      'Bewaar voedsel waarvan je weet dat je het goed verdraagt als onderdeel van je noodvoorraad.',
      category: 'Ziekte van Crohn',
    ),
    PersonalizedGuidance(
      title: 'Houd medicatie bereikbaar',
      description:
      'Zorg dat je noodzakelijke medicatie gemakkelijk meegenomen kan worden bij een evacuatie.',
      category: 'Ziekte van Crohn',
    ),
  ],

  'Colitis ulcerosa': [
    PersonalizedGuidance(
      title: 'Let op voldoende drinken',
      description:
      'Zorg voor voldoende drinkwater, vooral wanneer je last hebt van diarree.',
      category: 'Colitis ulcerosa',
    ),
    PersonalizedGuidance(
      title: 'Neem vertrouwd voedsel mee',
      description:
      'Neem voedsel mee waarvan je weet dat je het normaal goed kunt verdragen.',
      category: 'Colitis ulcerosa',
    ),
  ],

  'Multiple sclerose': [
    PersonalizedGuidance(
      title: 'Plan extra tijd voor evacuatie',
      description:
      'Vermoeidheid of problemen met bewegen kunnen evacuatie vertragen. Vertrek indien mogelijk vroeg en vraag hulp wanneer nodig.',
      category: 'Multiple sclerose',
    ),
    PersonalizedGuidance(
      title: 'Voorkom oververhitting',
      description:
      'Warmte kan bij sommige mensen klachten verergeren. Zoek indien mogelijk een koele plek en zorg voor voldoende drinken.',
      category: 'Multiple sclerose',
    ),
  ],

  'Parkinson': [
    PersonalizedGuidance(
      title: 'Bewaar je medicatie op een vaste plek',
      description:
      'Tijdens stressvolle situaties is het belangrijk dat Parkinsonmedicatie snel te vinden is en op tijd kan worden genomen.',
      category: 'Parkinson',
    ),
    PersonalizedGuidance(
      title: 'Plan extra tijd voor evacuatie',
      description:
      'Beweging kan tijdens stress of vermoeidheid moeilijker worden. Vertrek daarom indien mogelijk eerder en vraag hulp wanneer nodig.',
      category: 'Parkinson',
    ),
    PersonalizedGuidance(
      title: 'Neem noodzakelijke hulpmiddelen mee',
      description:
      'Zorg dat hulpmiddelen die je gebruikt bij lopen of dagelijkse activiteiten snel meegenomen kunnen worden.',
      category: 'Parkinson',
    ),
  ],

  'Dementie': [
    PersonalizedGuidance(
      title: 'Zorg voor begeleiding',
      description:
      'Probeer tijdens een evacuatie samen te blijven met een vertrouwd persoon die ondersteuning kan bieden.',
      category: 'Dementie',
    ),
    PersonalizedGuidance(
      title: 'Bewaar belangrijke gegevens bij elkaar',
      description:
      'Houd contactgegevens, medicatie-informatie en andere belangrijke gegevens op een vaste en herkenbare plek.',
      category: 'Dementie',
    ),
  ],

  'Eczeem': [
    PersonalizedGuidance(
      title: 'Neem verzorgingsproducten mee',
      description:
      'Zorg dat crèmes of andere producten die je regelmatig gebruikt onderdeel zijn van je noodvoorraad.',
      category: 'Eczeem',
    ),
    PersonalizedGuidance(
      title: 'Vermijd bekende irritatiebronnen',
      description:
      'Probeer contact met producten waarvan je weet dat ze huidklachten veroorzaken zoveel mogelijk te voorkomen.',
      category: 'Eczeem',
    ),
  ],

  'Psoriasis': [
    PersonalizedGuidance(
      title: 'Neem noodzakelijke huidverzorging mee',
      description:
      'Bewaar crèmes en andere producten die je regelmatig gebruikt bij je noodvoorraad.',
      category: 'Psoriasis',
    ),
    PersonalizedGuidance(
      title: 'Bescherm je huid',
      description:
      'Probeer beschadiging en langdurige blootstelling aan irriterende stoffen te voorkomen.',
      category: 'Psoriasis',
    ),
  ],

  'Slaapapneu': [
    PersonalizedGuidance(
      title: 'Denk aan je slaapapparatuur',
      description:
      'Wanneer je afhankelijk bent van een CPAP-apparaat of vergelijkbare apparatuur, neem deze indien mogelijk mee.',
      category: 'Slaapapneu',
    ),
    PersonalizedGuidance(
      title: 'Plan voor stroomuitval',
      description:
      'Houd er rekening mee dat elektrische slaapapparatuur mogelijk niet gebruikt kan worden tijdens een langdurige stroomuitval.',
      category: 'Slaapapneu',
    ),
  ],

  'Chronische pijn': [
    PersonalizedGuidance(
      title: 'Neem je gebruikelijke medicatie mee',
      description:
      'Zorg dat noodzakelijke pijnmedicatie of andere hulpmiddelen onderdeel zijn van je noodvoorraad.',
      category: 'Chronische pijn',
    ),
    PersonalizedGuidance(
      title: 'Plan voldoende rustmomenten',
      description:
      'Lang lopen, staan of tillen kan klachten verergeren. Houd hier rekening mee tijdens een evacuatie.',
      category: 'Chronische pijn',
    ),
  ],

  'Immuunstoornis': [
    PersonalizedGuidance(
      title: 'Let extra op hygiëne',
      description:
      'Gebruik waar mogelijk schoon drinkwater en zorg voor goede handhygiëne tijdens een noodsituatie.',
      category: 'Immuunstoornis',
    ),
    PersonalizedGuidance(
      title: 'Houd noodzakelijke medicatie beschikbaar',
      description:
      'Zorg dat dagelijkse of regelmatig gebruikte medicatie eenvoudig meegenomen kan worden.',
      category: 'Immuunstoornis',
    ),
  ],

  'Anders': [
    PersonalizedGuidance(
      title: 'Neem belangrijke medische informatie mee',
      description:
      'Zorg dat informatie over je aandoening, medicatie en relevante contactpersonen beschikbaar is tijdens een noodsituatie.',
      category: 'Medisch',
    ),
    PersonalizedGuidance(
      title: 'Maak je eigen noodplan',
      description:
      'Denk vooraf na over welke medicatie, hulpmiddelen of voorzieningen jij nodig hebt wanneer normale voorzieningen tijdelijk niet beschikbaar zijn.',
      category: 'Medisch',
    ),
  ],
};

const Map<String, List<PersonalizedGuidance>> allergyGuidanceDataset = {
  'Pinda\'s': [
    PersonalizedGuidance(
      title: 'Controleer noodvoedsel op pinda\'s',
      description:
      'Controleer ingrediënten en allergeneninformatie en neem producten mee waarvan je weet dat ze veilig voor je zijn.',
      category: 'Allergie',
    ),
    PersonalizedGuidance(
      title: 'Houd noodmedicatie bereikbaar',
      description:
      'Wanneer je noodmedicatie voor ernstige allergische reacties gebruikt, bewaar deze dan op een snel bereikbare plek.',
      category: 'Allergie',
    ),
  ],

  'Noten': [
    PersonalizedGuidance(
      title: 'Controleer noodvoedsel op noten',
      description:
      'Controleer ingrediënten en allergeneninformatie voordat je producten uit je noodvoorraad gebruikt.',
      category: 'Allergie',
    ),
    PersonalizedGuidance(
      title: 'Neem veilige alternatieven mee',
      description:
      'Zorg dat je voldoende voedsel in voorraad hebt waarvan je weet dat het geen noten bevat.',
      category: 'Allergie',
    ),
  ],

  'Melk': [
    PersonalizedGuidance(
      title: 'Controleer voedsel op melk',
      description:
      'Controleer ingrediënten van houdbare producten en noodvoeding op melkbestanddelen.',
      category: 'Allergie',
    ),
    PersonalizedGuidance(
      title: 'Neem veilige alternatieven mee',
      description:
      'Bewaar producten waarvan je weet dat ze geschikt zijn voor jouw allergie.',
      category: 'Allergie',
    ),
  ],

  'Eieren': [
    PersonalizedGuidance(
      title: 'Controleer voedsel op ei',
      description:
      'Controleer de ingrediënten en allergeneninformatie van voedsel uit je noodvoorraad.',
      category: 'Allergie',
    ),
    PersonalizedGuidance(
      title: 'Neem vertrouwde producten mee',
      description:
      'Zorg voor voldoende houdbaar voedsel waarvan je weet dat het veilig is.',
      category: 'Allergie',
    ),
  ],

  'Tarwe': [
    PersonalizedGuidance(
      title: 'Controleer voedsel op tarwe',
      description:
      'Lees de ingrediënten en allergeneninformatie voordat je noodvoeding gebruikt.',
      category: 'Allergie',
    ),
    PersonalizedGuidance(
      title: 'Neem geschikte alternatieven mee',
      description:
      'Zorg voor houdbaar voedsel waarvan je weet dat het geen tarwe bevat.',
      category: 'Allergie',
    ),
  ],

  'Soja': [
    PersonalizedGuidance(
      title: 'Controleer voedsel op soja',
      description:
      'Soja kan in veel samengestelde producten voorkomen. Controleer daarom altijd de ingrediënten.',
      category: 'Allergie',
    ),
    PersonalizedGuidance(
      title: 'Neem bekende veilige producten mee',
      description:
      'Gebruik voor je noodvoorraad producten waarvan je weet dat ze geschikt voor je zijn.',
      category: 'Allergie',
    ),
  ],

  'Vis': [
    PersonalizedGuidance(
      title: 'Controleer noodvoedsel op vis',
      description:
      'Let vooral op ingeblikt voedsel, kant-en-klare maaltijden en producten met visbestanddelen.',
      category: 'Allergie',
    ),
    PersonalizedGuidance(
      title: 'Voorkom kruiscontact',
      description:
      'Gebruik indien mogelijk apart verpakt voedsel wanneer andere mensen visproducten gebruiken.',
      category: 'Allergie',
    ),
  ],

  'Schaaldieren': [
    PersonalizedGuidance(
      title: 'Controleer noodvoedsel op schaaldieren',
      description:
      'Controleer ingrediënten van houdbare maaltijden en andere noodvoeding voordat je ze gebruikt.',
      category: 'Allergie',
    ),
    PersonalizedGuidance(
      title: 'Voorkom kruiscontact',
      description:
      'Wees voorzichtig met voedsel dat samen met schaaldieren is bereid of opgeslagen.',
      category: 'Allergie',
    ),
  ],

  'Sesam': [
    PersonalizedGuidance(
      title: 'Controleer voedsel op sesam',
      description:
      'Sesam kan voorkomen in brood, crackers, sauzen en andere houdbare producten.',
      category: 'Allergie',
    ),
    PersonalizedGuidance(
      title: 'Neem veilige alternatieven mee',
      description:
      'Zorg dat je noodvoorraad voldoende producten bevat waarvan je weet dat ze veilig zijn.',
      category: 'Allergie',
    ),
  ],

  'Pollen': [
    PersonalizedGuidance(
      title: 'Houd allergiemedicatie bereikbaar',
      description:
      'Wanneer je medicatie gebruikt tegen hooikoorts of andere pollenallergieën, neem deze dan mee in je noodvoorraad.',
      category: 'Allergie',
    ),
    PersonalizedGuidance(
      title: 'Beperk blootstelling wanneer mogelijk',
      description:
      'Houd ramen en deuren gesloten wanneer buiten veel pollen aanwezig zijn en dit praktisch mogelijk is.',
      category: 'Allergie',
    ),
  ],

  'Huisstofmijt': [
    PersonalizedGuidance(
      title: 'Vermijd stoffige ruimtes',
      description:
      'Probeer bij opvang of evacuatie een zo schoon mogelijke slaap- en verblijfsplek te kiezen.',
      category: 'Allergie',
    ),
    PersonalizedGuidance(
      title: 'Neem allergiemedicatie mee',
      description:
      'Bewaar medicatie die je normaal voor allergische klachten gebruikt bij je noodspullen.',
      category: 'Allergie',
    ),
  ],

  'Dieren': [
    PersonalizedGuidance(
      title: 'Beperk contact met dieren',
      description:
      'Bij tijdelijke opvang kunnen huisdieren aanwezig zijn. Houd waar mogelijk voldoende afstand wanneer je hier allergisch op reageert.',
      category: 'Allergie',
    ),
    PersonalizedGuidance(
      title: 'Neem allergiemedicatie mee',
      description:
      'Houd medicatie die je normaal gebruikt tegen allergische klachten bereikbaar.',
      category: 'Allergie',
    ),
  ],

  'Schimmel': [
    PersonalizedGuidance(
      title: 'Vermijd vochtige ruimtes',
      description:
      'Na wateroverlast kan schimmel ontstaan. Vermijd indien mogelijk zichtbaar beschimmelde of sterk vochtige ruimtes.',
      category: 'Allergie',
    ),
    PersonalizedGuidance(
      title: 'Let op ventilatie',
      description:
      'Kies indien mogelijk voor een droge en goed geventileerde verblijfsruimte.',
      category: 'Allergie',
    ),
  ],

  'Latex': [
    PersonalizedGuidance(
      title: 'Maak je latexallergie kenbaar',
      description:
      'Vertel hulpverleners wanneer je allergisch bent voor latex, vooral wanneer medische behandeling nodig is.',
      category: 'Allergie',
    ),
    PersonalizedGuidance(
      title: 'Neem latexvrije benodigdheden mee',
      description:
      'Wanneer je specifieke latexvrije medische producten gebruikt, neem deze dan indien mogelijk mee.',
      category: 'Allergie',
    ),
  ],

  'Bijensteken': [
    PersonalizedGuidance(
      title: 'Houd noodmedicatie direct bereikbaar',
      description:
      'Als je noodmedicatie voor ernstige allergische reacties gebruikt, bewaar deze dan op een plek waar je er onmiddellijk bij kunt.',
      category: 'Allergie',
    ),
    PersonalizedGuidance(
      title: 'Informeer mensen om je heen',
      description:
      'Laat mensen bij je weten dat je ernstig op bijensteken kunt reageren en waar je noodmedicatie ligt.',
      category: 'Allergie',
    ),
  ],

  'Wespensteken': [
    PersonalizedGuidance(
      title: 'Houd noodmedicatie direct bereikbaar',
      description:
      'Als je noodmedicatie voor ernstige allergische reacties gebruikt, bewaar deze dan op een plek waar je er onmiddellijk bij kunt.',
      category: 'Allergie',
    ),
    PersonalizedGuidance(
      title: 'Informeer mensen om je heen',
      description:
      'Laat mensen bij je weten dat je ernstig op wespensteken kunt reageren en waar je noodmedicatie ligt.',
      category: 'Allergie',
    ),
  ],

  'Penicilline': [
    PersonalizedGuidance(
      title: 'Maak je penicillineallergie duidelijk',
      description:
      'Zorg dat hulpverleners weten dat je allergisch bent voor penicilline voordat je medicatie krijgt.',
      category: 'Medicatieallergie',
    ),
    PersonalizedGuidance(
      title: 'Bewaar je allergie in je medische gegevens',
      description:
      'Zorg dat deze allergie duidelijk vermeld staat in de medische informatie op je telefoon of noodkaart.',
      category: 'Medicatieallergie',
    ),
  ],

  'Antibiotica': [
    PersonalizedGuidance(
      title: 'Vermeld je antibiotica-allergie',
      description:
      'Vertel hulpverleners altijd op welke antibiotica je eerder allergisch hebt gereageerd wanneer dat bekend is.',
      category: 'Medicatieallergie',
    ),
    PersonalizedGuidance(
      title: 'Bewaar de exacte naam wanneer bekend',
      description:
      'Wanneer je weet welk antibioticum de reactie veroorzaakte, sla die informatie dan op in je profiel of noodinformatie.',
      category: 'Medicatieallergie',
    ),
  ],

  'Ibuprofen': [
    PersonalizedGuidance(
      title: 'Vermeld je ibuprofenallergie',
      description:
      'Laat hulpverleners weten dat je allergisch bent voor ibuprofen voordat pijnstilling wordt gegeven.',
      category: 'Medicatieallergie',
    ),
    PersonalizedGuidance(
      title: 'Controleer pijnstillers',
      description:
      'Gebruik bij twijfel geen onbekende pijnstiller zonder de werkzame stof te controleren.',
      category: 'Medicatieallergie',
    ),
  ],

  'Aspirine': [
    PersonalizedGuidance(
      title: 'Vermeld je aspirineallergie',
      description:
      'Laat hulpverleners weten dat je allergisch bent voor aspirine voordat medicatie wordt gegeven.',
      category: 'Medicatieallergie',
    ),
    PersonalizedGuidance(
      title: 'Controleer de werkzame stof',
      description:
      'Controleer medicijnen uit een noodvoorraad voordat je ze gebruikt wanneer je niet zeker weet wat erin zit.',
      category: 'Medicatieallergie',
    ),
  ],

  'Paracetamol': [
    PersonalizedGuidance(
      title: 'Vermeld je paracetamolallergie',
      description:
      'Laat hulpverleners weten dat je allergisch bent voor paracetamol voordat pijnstilling wordt gegeven.',
      category: 'Medicatieallergie',
    ),
    PersonalizedGuidance(
      title: 'Controleer pijnstillers voor gebruik',
      description:
      'Controleer de werkzame stof voordat je pijnstillers uit een noodvoorraad gebruikt.',
      category: 'Medicatieallergie',
    ),
  ],

  'Contrastmiddel': [
    PersonalizedGuidance(
      title: 'Meld je reactie op contrastmiddel',
      description:
      'Vertel medisch personeel vóór onderzoek of behandeling dat je eerder allergisch hebt gereageerd op contrastmiddel.',
      category: 'Medicatieallergie',
    ),
    PersonalizedGuidance(
      title: 'Bewaar deze informatie in je profiel',
      description:
      'Zorg dat informatie over je eerdere reactie snel beschikbaar is wanneer je zelf niet goed kunt communiceren.',
      category: 'Medicatieallergie',
    ),
  ],

  'Nikkel': [
    PersonalizedGuidance(
      title: 'Vermijd langdurig huidcontact met nikkel',
      description:
      'Let bij tijdelijke hulpmiddelen, sieraden en metalen voorwerpen op materialen waarvan je weet dat ze klachten veroorzaken.',
      category: 'Allergie',
    ),
    PersonalizedGuidance(
      title: 'Neem huidverzorging mee',
      description:
      'Wanneer je normaal een crème gebruikt bij huidreacties, zorg dan dat deze onderdeel is van je noodvoorraad.',
      category: 'Allergie',
    ),
  ],

  'Parfum': [
    PersonalizedGuidance(
      title: 'Vermijd sterk geparfumeerde ruimtes',
      description:
      'Bij opvanglocaties kunnen schoonmaakmiddelen of verzorgingsproducten sterke geuren bevatten. Zoek indien mogelijk een plek met minder blootstelling.',
      category: 'Allergie',
    ),
    PersonalizedGuidance(
      title: 'Neem vertrouwde verzorgingsproducten mee',
      description:
      'Gebruik indien mogelijk je eigen ongeparfumeerde of bekende verzorgingsproducten.',
      category: 'Allergie',
    ),
  ],

  'Anders': [
    PersonalizedGuidance(
      title: 'Maak je allergie duidelijk',
      description:
      'Zorg dat mensen om je heen en hulpverleners weten waarvoor je allergisch bent.',
      category: 'Allergie',
    ),
    PersonalizedGuidance(
      title: 'Neem noodzakelijke noodmedicatie mee',
      description:
      'Wanneer je medicatie gebruikt voor allergische reacties, zorg dan dat deze makkelijk bereikbaar is.',
      category: 'Allergie',
    ),
  ],
};