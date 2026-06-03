import 'package:flutter/material.dart';
import 'package:medifinder_case_study/core/theme/app_style_extension.dart';
import 'package:medifinder_case_study/l10n/app_localizations.dart';

/// Extension on [BuildContext] for quick access to common theme and l10n.
extension ContextX on BuildContext {
  /// Shortcut for `AppLocalizations.of(this)!`.
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  /// Shortcut for `Theme.of(this)`.
  ThemeData get theme => Theme.of(this);

  /// Shortcut for `Theme.of(this).colorScheme`.
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Shortcut for `Theme.of(this).textTheme`.
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Semantic typography and shape tokens from theme.
  AppStyleExtension get styles =>
      Theme.of(this).extension<AppStyleExtension>()!;

  /// Shortcut for `MediaQuery.sizeOf(this)`.
  Size get screenSize => MediaQuery.sizeOf(this);
}

extension TagLocalizationX on String {
  /// Attempts to translate a dynamic tag (like a service or language).
  /// Falls back to the original string if no translation is found.
  String localizeTag(BuildContext context) {
    switch (toLowerCase().replaceAll(' ', '').replaceAll('-', '')) {
      case 'angiography': return context.l10n.tagAngiography;
      case 'arthroscopy': return context.l10n.tagArthroscopy;
      case 'beardtransplant': return context.l10n.tagBeardTransplant;
      case 'botox': return context.l10n.tagBotox;
      case 'breastsurgery': return context.l10n.tagBreastSurgery;
      case 'cancercare': return context.l10n.tagCancerCare;
      case 'cardiacsurgery': return context.l10n.tagCardiacSurgery;
      case 'cardiology': return context.l10n.tagCardiology;
      case 'cataractsurgery': return context.l10n.tagCataractSurgery;
      case 'chemicalpeels': return context.l10n.tagChemicalPeels;
      case 'crowns': return context.l10n.tagCrowns;
      case 'dhi': return context.l10n.tagDHI;
      case 'dentalimplants': return context.l10n.tagDentalImplants;
      case 'dentalveneers': return context.l10n.tagDentalVeneers;
      case 'deutsch': return context.l10n.tagDeutsch;
      case 'ecg': return context.l10n.tagECG;
      case 'echocardiography': return context.l10n.tagEchocardiography;
      case 'english': return context.l10n.tagEnglish;
      case 'español': return context.l10n.tagEspaol;
      case 'eyebrowtransplant': return context.l10n.tagEyebrowTransplant;
      case 'facelift': return context.l10n.tagFacelift;
      case 'français': return context.l10n.tagFranais;
      case 'gastroenterology': return context.l10n.tagGastroenterology;
      case 'glaucomatreatment': return context.l10n.tagGlaucomaTreatment;
      case 'hairtransplant': return context.l10n.tagHairTransplant;
      case 'hollywoodsmile': return context.l10n.tagHollywoodSmile;
      case 'ivf': return context.l10n.tagIVF;
      case 'invisalign': return context.l10n.tagInvisalign;
      case 'jointreplacement': return context.l10n.tagJointReplacement;
      case 'lasik': return context.l10n.tagLASIK;
      case 'lasertherapy': return context.l10n.tagLaserTherapy;
      case 'lasertreatment': return context.l10n.tagLaserTreatment;
      case 'liposuction': return context.l10n.tagLiposuction;
      case 'microneedling': return context.l10n.tagMicroneedling;
      case 'neurology': return context.l10n.tagNeurology;
      case 'neurosurgery': return context.l10n.tagNeurosurgery;
      case 'oncology': return context.l10n.tagOncology;
      case 'organtransplant': return context.l10n.tagOrganTransplant;
      case 'orthodontics': return context.l10n.tagOrthodontics;
      case 'orthopaedics': return context.l10n.tagOrthopaedics;
      case 'orthopedics': return context.l10n.tagOrthopedics;
      case 'prp': return context.l10n.tagPRP;
      case 'retinasurgery': return context.l10n.tagRetinaSurgery;
      case 'rhinoplasty': return context.l10n.tagRhinoplasty;
      case 'roboticsurgery': return context.l10n.tagRoboticSurgery;
      case 'rootcanal': return context.l10n.tagRootCanal;
      case 'sapphirefue': return context.l10n.tagSapphireFUE;
      case 'skincancerscreening': return context.l10n.tagSkinCancerScreening;
      case 'spinesurgery': return context.l10n.tagSpineSurgery;
      case 'sportsmedicine': return context.l10n.tagSportsMedicine;
      case 'stresstest': return context.l10n.tagStressTest;
      case 'surgery': return context.l10n.tagSurgery;
      case 'teethwhitening': return context.l10n.tagTeethWhitening;
      case 'transplant': return context.l10n.tagTransplant;
      case 'türkçe': return context.l10n.tagTrke;
      case 'veneers': return context.l10n.tagVeneers;
      case 'العربية': return 'العربية';
      case 'русский': return 'Русский';
      default: return this;
    }
  }

  /// Attempts to translate data like Countries, Cities, and Specialties.
  String localizeData(BuildContext context) {
    switch (this) {
      case 'Türkiye': return context.l10n.dataTRkiye;
      case 'UK': return context.l10n.dataUK;
      case 'USA': return context.l10n.dataUSA;
      case 'Germany': return context.l10n.dataGermany;
      case 'France': return context.l10n.dataFrance;
      case 'Italy': return context.l10n.dataItaly;
      case 'Spain': return context.l10n.dataSpain;
      case 'Canada': return context.l10n.dataCanada;
      case 'Australia': return context.l10n.dataAustralia;
      case 'İstanbul': return context.l10n.datastanbul;
      case 'Ankara': return context.l10n.dataAnkara;
      case 'İzmir': return context.l10n.datazmir;
      case 'Antalya': return context.l10n.dataAntalya;
      case 'Bursa': return context.l10n.dataBursa;
      case 'Adana': return context.l10n.dataAdana;
      case 'London': return context.l10n.dataLondon;
      case 'Manchester': return context.l10n.dataManchester;
      case 'Birmingham': return context.l10n.dataBirmingham;
      case 'Edinburgh': return context.l10n.dataEdinburgh;
      case 'Glasgow': return context.l10n.dataGlasgow;
      case 'New York': return context.l10n.dataNewYork;
      case 'Los Angeles': return context.l10n.dataLosAngeles;
      case 'Chicago': return context.l10n.dataChicago;
      case 'Houston': return context.l10n.dataHouston;
      case 'Miami': return context.l10n.dataMiami;
      case 'Boston': return context.l10n.dataBoston;
      case 'Berlin': return context.l10n.dataBerlin;
      case 'Munich': return context.l10n.dataMunich;
      case 'Hamburg': return context.l10n.dataHamburg;
      case 'Frankfurt': return context.l10n.dataFrankfurt;
      case 'Cologne': return context.l10n.dataCologne;
      case 'Paris': return context.l10n.dataParis;
      case 'Marseille': return context.l10n.dataMarseille;
      case 'Lyon': return context.l10n.dataLyon;
      case 'Toulouse': return context.l10n.dataToulouse;
      case 'Nice': return context.l10n.dataNice;
      case 'Rome': return context.l10n.dataRome;
      case 'Milan': return context.l10n.dataMilan;
      case 'Naples': return context.l10n.dataNaples;
      case 'Turin': return context.l10n.dataTurin;
      case 'Florence': return context.l10n.dataFlorence;
      case 'Madrid': return context.l10n.dataMadrid;
      case 'Barcelona': return context.l10n.dataBarcelona;
      case 'Valencia': return context.l10n.dataValencia;
      case 'Seville': return context.l10n.dataSeville;
      case 'Zaragoza': return context.l10n.dataZaragoza;
      case 'Toronto': return context.l10n.dataToronto;
      case 'Vancouver': return context.l10n.dataVancouver;
      case 'Montreal': return context.l10n.dataMontreal;
      case 'Calgary': return context.l10n.dataCalgary;
      case 'Ottawa': return context.l10n.dataOttawa;
      case 'Sydney': return context.l10n.dataSydney;
      case 'Melbourne': return context.l10n.dataMelbourne;
      case 'Brisbane': return context.l10n.dataBrisbane;
      case 'Perth': return context.l10n.dataPerth;
      case 'Adelaide': return context.l10n.dataAdelaide;
      case 'Psychiatry': return context.l10n.dataPsychiatry;
      case 'Urology': return context.l10n.dataUrology;
      case 'Gynecology': return context.l10n.dataGynecology;
      case 'General Surgery': return context.l10n.dataGeneralSurgery;
      case 'Ophthalmology': return context.l10n.dataOphthalmology;
      case 'Endocrinology': return context.l10n.dataEndocrinology;
      case 'Gastroenterology': return context.l10n.dataGastroenterology;
      case 'Oncology': return context.l10n.dataOncology;
      case 'Rheumatology': return context.l10n.dataRheumatology;
      case 'Pulmonology': return context.l10n.dataPulmonology;
      case 'Nephrology': return context.l10n.dataNephrology;
      case 'Otolaryngology': return context.l10n.dataOtolaryngology;
      case 'Plastic Surgery': return context.l10n.dataPlasticSurgery;
      case 'Aesthetic Medicine': return context.l10n.dataAestheticMedicine;
      case 'Pediatrics': return context.l10n.dataPediatrics;
      case 'Neurology': return context.l10n.dataNeurology;
      case 'Dentistry': return context.l10n.dataDentistry;
      case 'Orthopedics': return context.l10n.dataOrthopedics;
      case 'Dermatology': return context.l10n.dataDermatology;
      case 'Cardiology': return context.l10n.dataCardiology;
      case 'Hair Transplant': return context.l10n.dataHairTransplant;
      case 'General Medicine': return context.l10n.dataGeneralMedicine;
      default: return this;
    }
  }
}
