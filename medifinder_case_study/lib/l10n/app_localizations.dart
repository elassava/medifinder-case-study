import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'MediFinder'**
  String get appTitle;

  /// No description provided for @doctorDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Doctor Detail'**
  String get doctorDetailTitle;

  /// No description provided for @clinicDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Clinic Detail'**
  String get clinicDetailTitle;

  /// No description provided for @hospitalDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Hospital Detail'**
  String get hospitalDetailTitle;

  /// No description provided for @tabSpecialists.
  ///
  /// In en, this message translates to:
  /// **'Specialists'**
  String get tabSpecialists;

  /// No description provided for @tabFacilities.
  ///
  /// In en, this message translates to:
  /// **'Facilities'**
  String get tabFacilities;

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search doctor, clinic or treatment'**
  String get searchPlaceholder;

  /// No description provided for @searchFind.
  ///
  /// In en, this message translates to:
  /// **'Find'**
  String get searchFind;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get searchHint;

  /// No description provided for @filterTitle.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filterTitle;

  /// No description provided for @filterCountry.
  ///
  /// In en, this message translates to:
  /// **'Select Country'**
  String get filterCountry;

  /// No description provided for @filterCity.
  ///
  /// In en, this message translates to:
  /// **'Select City'**
  String get filterCity;

  /// No description provided for @filterCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Specialty'**
  String get filterCategory;

  /// No description provided for @filterApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get filterApply;

  /// No description provided for @filterReset.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get filterReset;

  /// No description provided for @filterSelectCountryFirst.
  ///
  /// In en, this message translates to:
  /// **'Select a country first'**
  String get filterSelectCountryFirst;

  /// No description provided for @resultsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} results'**
  String resultsCount(int count);

  /// No description provided for @providerDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Provider Detail'**
  String get providerDetailTitle;

  /// No description provided for @contactInfo.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contactInfo;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @languages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @yearsExperience.
  ///
  /// In en, this message translates to:
  /// **'{count} years experience'**
  String yearsExperience(int count);

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'{count} reviews'**
  String reviews(int count);

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @providerTypeDoctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get providerTypeDoctor;

  /// No description provided for @providerTypeClinic.
  ///
  /// In en, this message translates to:
  /// **'Clinic'**
  String get providerTypeClinic;

  /// No description provided for @providerTypeHospital.
  ///
  /// In en, this message translates to:
  /// **'Hospital'**
  String get providerTypeHospital;

  /// No description provided for @loadingMessage.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loadingMessage;

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorMessage;

  /// No description provided for @errorRetry.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get errorRetry;

  /// No description provided for @emptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No Results Found'**
  String get emptyTitle;

  /// No description provided for @emptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your search or filters'**
  String get emptyMessage;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @popular.
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get popular;

  /// No description provided for @sortMostRelevant.
  ///
  /// In en, this message translates to:
  /// **'Most Relevant'**
  String get sortMostRelevant;

  /// No description provided for @sortHighestRated.
  ///
  /// In en, this message translates to:
  /// **'Highest Rated'**
  String get sortHighestRated;

  /// No description provided for @callNow.
  ///
  /// In en, this message translates to:
  /// **'Call Now'**
  String get callNow;

  /// No description provided for @sendEmail.
  ///
  /// In en, this message translates to:
  /// **'Send Email'**
  String get sendEmail;

  /// No description provided for @getDirections.
  ///
  /// In en, this message translates to:
  /// **'Get Directions'**
  String get getDirections;

  /// No description provided for @tagAngiography.
  ///
  /// In en, this message translates to:
  /// **'Angiography'**
  String get tagAngiography;

  /// No description provided for @tagArthroscopy.
  ///
  /// In en, this message translates to:
  /// **'Arthroscopy'**
  String get tagArthroscopy;

  /// No description provided for @tagBeardTransplant.
  ///
  /// In en, this message translates to:
  /// **'Beard Transplant'**
  String get tagBeardTransplant;

  /// No description provided for @tagBotox.
  ///
  /// In en, this message translates to:
  /// **'Botox'**
  String get tagBotox;

  /// No description provided for @tagBreastSurgery.
  ///
  /// In en, this message translates to:
  /// **'Breast Surgery'**
  String get tagBreastSurgery;

  /// No description provided for @tagCancerCare.
  ///
  /// In en, this message translates to:
  /// **'Cancer Care'**
  String get tagCancerCare;

  /// No description provided for @tagCardiacSurgery.
  ///
  /// In en, this message translates to:
  /// **'Cardiac Surgery'**
  String get tagCardiacSurgery;

  /// No description provided for @tagCardiology.
  ///
  /// In en, this message translates to:
  /// **'Cardiology'**
  String get tagCardiology;

  /// No description provided for @tagCataractSurgery.
  ///
  /// In en, this message translates to:
  /// **'Cataract Surgery'**
  String get tagCataractSurgery;

  /// No description provided for @tagChemicalPeels.
  ///
  /// In en, this message translates to:
  /// **'Chemical Peels'**
  String get tagChemicalPeels;

  /// No description provided for @tagCrowns.
  ///
  /// In en, this message translates to:
  /// **'Crowns'**
  String get tagCrowns;

  /// No description provided for @tagDHI.
  ///
  /// In en, this message translates to:
  /// **'DHI'**
  String get tagDHI;

  /// No description provided for @tagDentalImplants.
  ///
  /// In en, this message translates to:
  /// **'Dental Implants'**
  String get tagDentalImplants;

  /// No description provided for @tagDentalVeneers.
  ///
  /// In en, this message translates to:
  /// **'Dental Veneers'**
  String get tagDentalVeneers;

  /// No description provided for @tagDeutsch.
  ///
  /// In en, this message translates to:
  /// **'Deutsch'**
  String get tagDeutsch;

  /// No description provided for @tagECG.
  ///
  /// In en, this message translates to:
  /// **'ECG'**
  String get tagECG;

  /// No description provided for @tagEchocardiography.
  ///
  /// In en, this message translates to:
  /// **'Echocardiography'**
  String get tagEchocardiography;

  /// No description provided for @tagEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get tagEnglish;

  /// No description provided for @tagEspaol.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get tagEspaol;

  /// No description provided for @tagEyebrowTransplant.
  ///
  /// In en, this message translates to:
  /// **'Eyebrow Transplant'**
  String get tagEyebrowTransplant;

  /// No description provided for @tagFacelift.
  ///
  /// In en, this message translates to:
  /// **'Facelift'**
  String get tagFacelift;

  /// No description provided for @tagFranais.
  ///
  /// In en, this message translates to:
  /// **'Français'**
  String get tagFranais;

  /// No description provided for @tagGastroenterology.
  ///
  /// In en, this message translates to:
  /// **'Gastroenterology'**
  String get tagGastroenterology;

  /// No description provided for @tagGlaucomaTreatment.
  ///
  /// In en, this message translates to:
  /// **'Glaucoma Treatment'**
  String get tagGlaucomaTreatment;

  /// No description provided for @tagHairTransplant.
  ///
  /// In en, this message translates to:
  /// **'Hair Transplant'**
  String get tagHairTransplant;

  /// No description provided for @tagHollywoodSmile.
  ///
  /// In en, this message translates to:
  /// **'Hollywood Smile'**
  String get tagHollywoodSmile;

  /// No description provided for @tagIVF.
  ///
  /// In en, this message translates to:
  /// **'IVF'**
  String get tagIVF;

  /// No description provided for @tagInvisalign.
  ///
  /// In en, this message translates to:
  /// **'Invisalign'**
  String get tagInvisalign;

  /// No description provided for @tagJointReplacement.
  ///
  /// In en, this message translates to:
  /// **'Joint Replacement'**
  String get tagJointReplacement;

  /// No description provided for @tagLASIK.
  ///
  /// In en, this message translates to:
  /// **'LASIK'**
  String get tagLASIK;

  /// No description provided for @tagLaserTherapy.
  ///
  /// In en, this message translates to:
  /// **'Laser Therapy'**
  String get tagLaserTherapy;

  /// No description provided for @tagLaserTreatment.
  ///
  /// In en, this message translates to:
  /// **'Laser Treatment'**
  String get tagLaserTreatment;

  /// No description provided for @tagLiposuction.
  ///
  /// In en, this message translates to:
  /// **'Liposuction'**
  String get tagLiposuction;

  /// No description provided for @tagMicroneedling.
  ///
  /// In en, this message translates to:
  /// **'Micro-needling'**
  String get tagMicroneedling;

  /// No description provided for @tagNeurology.
  ///
  /// In en, this message translates to:
  /// **'Neurology'**
  String get tagNeurology;

  /// No description provided for @tagNeurosurgery.
  ///
  /// In en, this message translates to:
  /// **'Neurosurgery'**
  String get tagNeurosurgery;

  /// No description provided for @tagOncology.
  ///
  /// In en, this message translates to:
  /// **'Oncology'**
  String get tagOncology;

  /// No description provided for @tagOrganTransplant.
  ///
  /// In en, this message translates to:
  /// **'Organ Transplant'**
  String get tagOrganTransplant;

  /// No description provided for @tagOrthodontics.
  ///
  /// In en, this message translates to:
  /// **'Orthodontics'**
  String get tagOrthodontics;

  /// No description provided for @tagOrthopaedics.
  ///
  /// In en, this message translates to:
  /// **'Orthopaedics'**
  String get tagOrthopaedics;

  /// No description provided for @tagOrthopedics.
  ///
  /// In en, this message translates to:
  /// **'Orthopedics'**
  String get tagOrthopedics;

  /// No description provided for @tagPRP.
  ///
  /// In en, this message translates to:
  /// **'PRP'**
  String get tagPRP;

  /// No description provided for @tagRetinaSurgery.
  ///
  /// In en, this message translates to:
  /// **'Retina Surgery'**
  String get tagRetinaSurgery;

  /// No description provided for @tagRhinoplasty.
  ///
  /// In en, this message translates to:
  /// **'Rhinoplasty'**
  String get tagRhinoplasty;

  /// No description provided for @tagRoboticSurgery.
  ///
  /// In en, this message translates to:
  /// **'Robotic Surgery'**
  String get tagRoboticSurgery;

  /// No description provided for @tagRootCanal.
  ///
  /// In en, this message translates to:
  /// **'Root Canal'**
  String get tagRootCanal;

  /// No description provided for @tagSapphireFUE.
  ///
  /// In en, this message translates to:
  /// **'Sapphire FUE'**
  String get tagSapphireFUE;

  /// No description provided for @tagSkinCancerScreening.
  ///
  /// In en, this message translates to:
  /// **'Skin Cancer Screening'**
  String get tagSkinCancerScreening;

  /// No description provided for @tagSpineSurgery.
  ///
  /// In en, this message translates to:
  /// **'Spine Surgery'**
  String get tagSpineSurgery;

  /// No description provided for @tagSportsMedicine.
  ///
  /// In en, this message translates to:
  /// **'Sports Medicine'**
  String get tagSportsMedicine;

  /// No description provided for @tagStressTest.
  ///
  /// In en, this message translates to:
  /// **'Stress Test'**
  String get tagStressTest;

  /// No description provided for @tagSurgery.
  ///
  /// In en, this message translates to:
  /// **'Surgery'**
  String get tagSurgery;

  /// No description provided for @tagTeethWhitening.
  ///
  /// In en, this message translates to:
  /// **'Teeth Whitening'**
  String get tagTeethWhitening;

  /// No description provided for @tagTransplant.
  ///
  /// In en, this message translates to:
  /// **'Transplant'**
  String get tagTransplant;

  /// No description provided for @tagTrke.
  ///
  /// In en, this message translates to:
  /// **'Türkçe'**
  String get tagTrke;

  /// No description provided for @tagVeneers.
  ///
  /// In en, this message translates to:
  /// **'Veneers'**
  String get tagVeneers;

  /// No description provided for @dataTRkiye.
  ///
  /// In en, this message translates to:
  /// **'Türkiye'**
  String get dataTRkiye;

  /// No description provided for @dataUK.
  ///
  /// In en, this message translates to:
  /// **'UK'**
  String get dataUK;

  /// No description provided for @dataUSA.
  ///
  /// In en, this message translates to:
  /// **'USA'**
  String get dataUSA;

  /// No description provided for @dataGermany.
  ///
  /// In en, this message translates to:
  /// **'Germany'**
  String get dataGermany;

  /// No description provided for @dataFrance.
  ///
  /// In en, this message translates to:
  /// **'France'**
  String get dataFrance;

  /// No description provided for @dataItaly.
  ///
  /// In en, this message translates to:
  /// **'Italy'**
  String get dataItaly;

  /// No description provided for @dataSpain.
  ///
  /// In en, this message translates to:
  /// **'Spain'**
  String get dataSpain;

  /// No description provided for @dataCanada.
  ///
  /// In en, this message translates to:
  /// **'Canada'**
  String get dataCanada;

  /// No description provided for @dataAustralia.
  ///
  /// In en, this message translates to:
  /// **'Australia'**
  String get dataAustralia;

  /// No description provided for @datastanbul.
  ///
  /// In en, this message translates to:
  /// **'İstanbul'**
  String get datastanbul;

  /// No description provided for @dataAnkara.
  ///
  /// In en, this message translates to:
  /// **'Ankara'**
  String get dataAnkara;

  /// No description provided for @datazmir.
  ///
  /// In en, this message translates to:
  /// **'İzmir'**
  String get datazmir;

  /// No description provided for @dataAntalya.
  ///
  /// In en, this message translates to:
  /// **'Antalya'**
  String get dataAntalya;

  /// No description provided for @dataBursa.
  ///
  /// In en, this message translates to:
  /// **'Bursa'**
  String get dataBursa;

  /// No description provided for @dataAdana.
  ///
  /// In en, this message translates to:
  /// **'Adana'**
  String get dataAdana;

  /// No description provided for @dataLondon.
  ///
  /// In en, this message translates to:
  /// **'London'**
  String get dataLondon;

  /// No description provided for @dataManchester.
  ///
  /// In en, this message translates to:
  /// **'Manchester'**
  String get dataManchester;

  /// No description provided for @dataBirmingham.
  ///
  /// In en, this message translates to:
  /// **'Birmingham'**
  String get dataBirmingham;

  /// No description provided for @dataEdinburgh.
  ///
  /// In en, this message translates to:
  /// **'Edinburgh'**
  String get dataEdinburgh;

  /// No description provided for @dataGlasgow.
  ///
  /// In en, this message translates to:
  /// **'Glasgow'**
  String get dataGlasgow;

  /// No description provided for @dataNewYork.
  ///
  /// In en, this message translates to:
  /// **'New York'**
  String get dataNewYork;

  /// No description provided for @dataLosAngeles.
  ///
  /// In en, this message translates to:
  /// **'Los Angeles'**
  String get dataLosAngeles;

  /// No description provided for @dataChicago.
  ///
  /// In en, this message translates to:
  /// **'Chicago'**
  String get dataChicago;

  /// No description provided for @dataHouston.
  ///
  /// In en, this message translates to:
  /// **'Houston'**
  String get dataHouston;

  /// No description provided for @dataMiami.
  ///
  /// In en, this message translates to:
  /// **'Miami'**
  String get dataMiami;

  /// No description provided for @dataBoston.
  ///
  /// In en, this message translates to:
  /// **'Boston'**
  String get dataBoston;

  /// No description provided for @dataBerlin.
  ///
  /// In en, this message translates to:
  /// **'Berlin'**
  String get dataBerlin;

  /// No description provided for @dataMunich.
  ///
  /// In en, this message translates to:
  /// **'Munich'**
  String get dataMunich;

  /// No description provided for @dataHamburg.
  ///
  /// In en, this message translates to:
  /// **'Hamburg'**
  String get dataHamburg;

  /// No description provided for @dataFrankfurt.
  ///
  /// In en, this message translates to:
  /// **'Frankfurt'**
  String get dataFrankfurt;

  /// No description provided for @dataCologne.
  ///
  /// In en, this message translates to:
  /// **'Cologne'**
  String get dataCologne;

  /// No description provided for @dataParis.
  ///
  /// In en, this message translates to:
  /// **'Paris'**
  String get dataParis;

  /// No description provided for @dataMarseille.
  ///
  /// In en, this message translates to:
  /// **'Marseille'**
  String get dataMarseille;

  /// No description provided for @dataLyon.
  ///
  /// In en, this message translates to:
  /// **'Lyon'**
  String get dataLyon;

  /// No description provided for @dataToulouse.
  ///
  /// In en, this message translates to:
  /// **'Toulouse'**
  String get dataToulouse;

  /// No description provided for @dataNice.
  ///
  /// In en, this message translates to:
  /// **'Nice'**
  String get dataNice;

  /// No description provided for @dataRome.
  ///
  /// In en, this message translates to:
  /// **'Rome'**
  String get dataRome;

  /// No description provided for @dataMilan.
  ///
  /// In en, this message translates to:
  /// **'Milan'**
  String get dataMilan;

  /// No description provided for @dataNaples.
  ///
  /// In en, this message translates to:
  /// **'Naples'**
  String get dataNaples;

  /// No description provided for @dataTurin.
  ///
  /// In en, this message translates to:
  /// **'Turin'**
  String get dataTurin;

  /// No description provided for @dataFlorence.
  ///
  /// In en, this message translates to:
  /// **'Florence'**
  String get dataFlorence;

  /// No description provided for @dataMadrid.
  ///
  /// In en, this message translates to:
  /// **'Madrid'**
  String get dataMadrid;

  /// No description provided for @dataBarcelona.
  ///
  /// In en, this message translates to:
  /// **'Barcelona'**
  String get dataBarcelona;

  /// No description provided for @dataValencia.
  ///
  /// In en, this message translates to:
  /// **'Valencia'**
  String get dataValencia;

  /// No description provided for @dataSeville.
  ///
  /// In en, this message translates to:
  /// **'Seville'**
  String get dataSeville;

  /// No description provided for @dataZaragoza.
  ///
  /// In en, this message translates to:
  /// **'Zaragoza'**
  String get dataZaragoza;

  /// No description provided for @dataToronto.
  ///
  /// In en, this message translates to:
  /// **'Toronto'**
  String get dataToronto;

  /// No description provided for @dataVancouver.
  ///
  /// In en, this message translates to:
  /// **'Vancouver'**
  String get dataVancouver;

  /// No description provided for @dataMontreal.
  ///
  /// In en, this message translates to:
  /// **'Montreal'**
  String get dataMontreal;

  /// No description provided for @dataCalgary.
  ///
  /// In en, this message translates to:
  /// **'Calgary'**
  String get dataCalgary;

  /// No description provided for @dataOttawa.
  ///
  /// In en, this message translates to:
  /// **'Ottawa'**
  String get dataOttawa;

  /// No description provided for @dataSydney.
  ///
  /// In en, this message translates to:
  /// **'Sydney'**
  String get dataSydney;

  /// No description provided for @dataMelbourne.
  ///
  /// In en, this message translates to:
  /// **'Melbourne'**
  String get dataMelbourne;

  /// No description provided for @dataBrisbane.
  ///
  /// In en, this message translates to:
  /// **'Brisbane'**
  String get dataBrisbane;

  /// No description provided for @dataPerth.
  ///
  /// In en, this message translates to:
  /// **'Perth'**
  String get dataPerth;

  /// No description provided for @dataAdelaide.
  ///
  /// In en, this message translates to:
  /// **'Adelaide'**
  String get dataAdelaide;

  /// No description provided for @dataPsychiatry.
  ///
  /// In en, this message translates to:
  /// **'Psychiatry'**
  String get dataPsychiatry;

  /// No description provided for @dataUrology.
  ///
  /// In en, this message translates to:
  /// **'Urology'**
  String get dataUrology;

  /// No description provided for @dataGynecology.
  ///
  /// In en, this message translates to:
  /// **'Gynecology'**
  String get dataGynecology;

  /// No description provided for @dataGeneralSurgery.
  ///
  /// In en, this message translates to:
  /// **'General Surgery'**
  String get dataGeneralSurgery;

  /// No description provided for @dataOphthalmology.
  ///
  /// In en, this message translates to:
  /// **'Ophthalmology'**
  String get dataOphthalmology;

  /// No description provided for @dataEndocrinology.
  ///
  /// In en, this message translates to:
  /// **'Endocrinology'**
  String get dataEndocrinology;

  /// No description provided for @dataGastroenterology.
  ///
  /// In en, this message translates to:
  /// **'Gastroenterology'**
  String get dataGastroenterology;

  /// No description provided for @dataOncology.
  ///
  /// In en, this message translates to:
  /// **'Oncology'**
  String get dataOncology;

  /// No description provided for @dataRheumatology.
  ///
  /// In en, this message translates to:
  /// **'Rheumatology'**
  String get dataRheumatology;

  /// No description provided for @dataPulmonology.
  ///
  /// In en, this message translates to:
  /// **'Pulmonology'**
  String get dataPulmonology;

  /// No description provided for @dataNephrology.
  ///
  /// In en, this message translates to:
  /// **'Nephrology'**
  String get dataNephrology;

  /// No description provided for @dataOtolaryngology.
  ///
  /// In en, this message translates to:
  /// **'Otolaryngology'**
  String get dataOtolaryngology;

  /// No description provided for @dataPlasticSurgery.
  ///
  /// In en, this message translates to:
  /// **'Plastic Surgery'**
  String get dataPlasticSurgery;

  /// No description provided for @dataAestheticMedicine.
  ///
  /// In en, this message translates to:
  /// **'Aesthetic Medicine'**
  String get dataAestheticMedicine;

  /// No description provided for @dataPediatrics.
  ///
  /// In en, this message translates to:
  /// **'Pediatrics'**
  String get dataPediatrics;

  /// No description provided for @dataNeurology.
  ///
  /// In en, this message translates to:
  /// **'Neurology'**
  String get dataNeurology;

  /// No description provided for @dataDentistry.
  ///
  /// In en, this message translates to:
  /// **'Dentistry'**
  String get dataDentistry;

  /// No description provided for @dataOrthopedics.
  ///
  /// In en, this message translates to:
  /// **'Orthopedics'**
  String get dataOrthopedics;

  /// No description provided for @dataDermatology.
  ///
  /// In en, this message translates to:
  /// **'Dermatology'**
  String get dataDermatology;

  /// No description provided for @dataCardiology.
  ///
  /// In en, this message translates to:
  /// **'Cardiology'**
  String get dataCardiology;

  /// No description provided for @dataHairTransplant.
  ///
  /// In en, this message translates to:
  /// **'Hair Transplant'**
  String get dataHairTransplant;

  /// No description provided for @dataGeneralMedicine.
  ///
  /// In en, this message translates to:
  /// **'General Medicine'**
  String get dataGeneralMedicine;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
