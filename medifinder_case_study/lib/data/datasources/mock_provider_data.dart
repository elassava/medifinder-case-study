import 'dart:math' as dart_math;

import 'package:medifinder_case_study/core/models/filter_model.dart';
import 'package:medifinder_case_study/core/models/provider_model.dart';
import 'package:medifinder_case_study/core/models/provider_page_result.dart';

/// In-memory mock data source simulating a paginated backend API.
/// Provides realistic healthcare provider data for demo purposes.
class MockProviderDataSource {
  MockProviderDataSource._();
  static final MockProviderDataSource _instance = MockProviderDataSource._();
  static MockProviderDataSource get instance => _instance;

  static const catalogInitDelay = Duration(milliseconds: 300);
  static const pageFetchDelay = Duration(milliseconds: 350);

  /// Simulated network delay duration for detail requests.
  static const _networkDelay = Duration(milliseconds: 500);

  /// Set to true to simulate an API error for retry scenario demo.
  bool simulateError = false;

  bool _catalogReady = false;

  bool get isCatalogReady => _catalogReady;

  List<ProviderModel> get allProviders {
    _ensureDataGenerated();
    return List.unmodifiable(_providers);
  }

  /// Initializes catalog once (simulated bootstrap call).
  Future<void> warmUpCatalog() async {
    if (_catalogReady) return;

    await Future<void>.delayed(catalogInitDelay);

    if (simulateError) {
      throw Exception('Network error: Unable to fetch providers');
    }

    _ensureDataGenerated();
    _catalogReady = true;
  }

  /// Paginated, type-scoped provider query.
  Future<ProviderPageResult> fetchProviderPage({
    required ProviderType type,
    FilterModel filter = const FilterModel(),
    int offset = 0,
    int limit = 12,
  }) async {
    await warmUpCatalog();
    await Future<void>.delayed(pageFetchDelay);

    if (simulateError) {
      throw Exception('Network error: Unable to fetch providers');
    }

    final matched = _query(filter: filter, type: type);
    if (offset >= matched.length) {
      return ProviderPageResult(
        items: const [],
        totalCount: matched.length,
        offset: offset,
        limit: limit,
      );
    }

    final end = offset + limit > matched.length ? matched.length : offset + limit;
    return ProviderPageResult(
      items: matched.sublist(offset, end),
      totalCount: matched.length,
      offset: offset,
      limit: limit,
    );
  }

  Map<ProviderType, int> countByType({FilterModel filter = const FilterModel()}) {
    _ensureDataGenerated();
    return {
      for (final type in ProviderType.values)
        type: _query(filter: filter, type: type).length,
    };
  }

  /// Returns all mock providers after a simulated network delay.
  /// Kept for backwards compatibility in tests and filter catalog warmup.
  Future<List<ProviderModel>> fetchProviders() async {
    await warmUpCatalog();
    return allProviders;
  }

  /// Returns a single provider by [id] after a simulated network delay.
  Future<ProviderModel> fetchProviderById(String id) async {
    await warmUpCatalog();
    await Future<void>.delayed(_networkDelay);

    if (simulateError) {
      throw Exception('Network error: Unable to fetch provider');
    }

    return _providers.firstWhere(
      (p) => p.id == id,
      orElse: () => throw Exception('Provider not found: $id'),
    );
  }

  List<ProviderModel> _query({
    required FilterModel filter,
    required ProviderType type,
  }) {
    var result = _providers.where((p) => p.type == type);

    if (filter.country != null) {
      result = result.where((p) => p.country == filter.country);
    }
    if (filter.city != null) {
      result = result.where((p) => p.city == filter.city);
    }
    if (filter.category != null) {
      result = result.where((p) => p.specialty == filter.category);
    }
    if (filter.searchQuery.isNotEmpty) {
      final query = filter.searchQuery.toLowerCase();
      result = result.where(
        (p) =>
            p.name.toLowerCase().contains(query) ||
            p.specialty.toLowerCase().contains(query) ||
            p.city.toLowerCase().contains(query) ||
            p.country.toLowerCase().contains(query),
      );
    }

    return result.toList(growable: false);
  }

  // ── Mock Data ─────────────────────────────────────────────────────

  static final List<ProviderModel> _providers = [];

  static void _ensureDataGenerated() {
    if (_providers.isNotEmpty) return;

    final baseProviders = [
      // ── Doctors ──
    const ProviderModel(
      id: 'doc-001',
      name: 'Dr. Ahmet Yılmaz',
      type: ProviderType.doctor,
      specialty: 'Cardiology',
      country: 'Türkiye',
      city: 'İstanbul',
      rating: 4.9,
      reviewCount: 328,
      imageUrl: 'https://i.pravatar.cc/300?img=11',
      phone: '+90 212 555 0101',
      email: 'ahmet.yilmaz@medifinder.com',
      bio:
          'Dr. Ahmet Yılmaz, 20 yılı aşkın deneyime sahip bir kardiyoloji uzmanıdır. İstanbul Üniversitesi Tıp Fakültesi\'nden mezun olmuş, ardından ABD\'de Johns Hopkins Hastanesi\'nde ileri eğitim almıştır. Girişimsel kardiyoloji ve kalp yetmezliği tedavisi konularında uzmanlaşmıştır.',
      address: 'Nişantaşı, Teşvikiye Cad. No:42, Şişli/İstanbul',
      isVerified: true,
      yearsOfExperience: 22,
      languages: ['Türkçe', 'English', 'Deutsch'],
      services: ['ECG', 'Echocardiography', 'Angiography', 'Stress Test'],
    ),
    const ProviderModel(
      id: 'doc-002',
      name: 'Dr. Elif Demir',
      type: ProviderType.doctor,
      specialty: 'Dermatology',
      country: 'Türkiye',
      city: 'Ankara',
      rating: 4.7,
      reviewCount: 215,
      imageUrl: 'https://i.pravatar.cc/300?img=5',
      phone: '+90 312 555 0202',
      email: 'elif.demir@medifinder.com',
      bio:
          'Dr. Elif Demir, dermatoloji ve kozmetik cilt bakımı alanında 15 yıllık deneyime sahiptir. Hacettepe Üniversitesi\'nden derece ile mezun olmuştur. Lazer tedavileri ve cilt kanseri taraması konularında uzmanlaşmıştır.',
      address: 'Çankaya, Tunalı Hilmi Cad. No:78, Ankara',
      isVerified: true,
      yearsOfExperience: 15,
      languages: ['Türkçe', 'English'],
      services: ['Laser Treatment', 'Skin Cancer Screening', 'Botox', 'PRP'],
    ),
    const ProviderModel(
      id: 'doc-003',
      name: 'Dr. Hans Müller',
      type: ProviderType.doctor,
      specialty: 'Orthopedics',
      country: 'Germany',
      city: 'Berlin',
      rating: 4.8,
      reviewCount: 189,
      imageUrl: 'https://i.pravatar.cc/300?img=12',
      phone: '+49 30 555 0303',
      email: 'hans.mueller@medifinder.com',
      bio:
          'Dr. Hans Müller is a renowned orthopedic surgeon specializing in joint replacement and sports medicine. With over 18 years of experience, he has performed more than 3,000 successful surgeries at Charité Hospital.',
      address: 'Charité Campus Mitte, Charitéplatz 1, 10117 Berlin',
      isVerified: true,
      yearsOfExperience: 18,
      languages: ['Deutsch', 'English', 'Français'],
      services: [
        'Joint Replacement',
        'Arthroscopy',
        'Sports Medicine',
        'Spine Surgery',
      ],
    ),
    const ProviderModel(
      id: 'doc-004',
      name: 'Dr. Sarah Johnson',
      type: ProviderType.doctor,
      specialty: 'Plastic Surgery',
      country: 'USA',
      city: 'New York',
      rating: 4.6,
      reviewCount: 142,
      imageUrl: 'https://i.pravatar.cc/300?img=9',
      phone: '+1 212 555 0404',
      email: 'sarah.johnson@medifinder.com',
      bio:
          'Dr. Sarah Johnson is a board-certified plastic surgeon in Manhattan with expertise in facial rejuvenation and body contouring. She graduated from Harvard Medical School and completed her residency at NYU Langone.',
      address: '5th Avenue, Suite 301, New York, NY 10065',
      isVerified: true,
      yearsOfExperience: 12,
      languages: ['English', 'Español'],
      services: ['Rhinoplasty', 'Facelift', 'Liposuction', 'Breast Surgery'],
    ),
    const ProviderModel(
      id: 'doc-005',
      name: 'Dr. Mehmet Kaya',
      type: ProviderType.doctor,
      specialty: 'Hair Transplant',
      country: 'Türkiye',
      city: 'İstanbul',
      rating: 4.8,
      reviewCount: 467,
      imageUrl: 'https://i.pravatar.cc/300?img=14',
      phone: '+90 212 555 0505',
      email: 'mehmet.kaya@medifinder.com',
      bio:
          'Dr. Mehmet Kaya, saç ekimi alanında Türkiye\'nin en deneyimli uzmanlarından biridir. DHI ve Sapphire FUE yöntemlerinde 10.000\'den fazla başarılı operasyon gerçekleştirmiştir.',
      address: 'Levent, Büyükdere Cad. No:185, Şişli/İstanbul',
      isVerified: true,
      yearsOfExperience: 14,
      languages: ['Türkçe', 'English', 'العربية'],
      services: ['DHI', 'Sapphire FUE', 'Beard Transplant', 'Eyebrow Transplant'],
    ),
    const ProviderModel(
      id: 'doc-006',
      name: 'Dr. James Wilson',
      type: ProviderType.doctor,
      specialty: 'Dentistry',
      country: 'UK',
      city: 'London',
      rating: 4.5,
      reviewCount: 98,
      imageUrl: 'https://i.pravatar.cc/300?img=15',
      phone: '+44 20 555 0606',
      email: 'james.wilson@medifinder.com',
      bio:
          'Dr. James Wilson is a cosmetic dentistry specialist with a focus on smile makeovers and dental implants. He trained at King\'s College London and has been practicing for over 10 years.',
      address: '88 Harley Street, London W1G 7HW',
      isVerified: false,
      yearsOfExperience: 10,
      languages: ['English'],
      services: ['Dental Implants', 'Veneers', 'Teeth Whitening', 'Invisalign'],
    ),
    const ProviderModel(
      id: 'doc-007',
      name: 'Dr. Ayşe Çelik',
      type: ProviderType.doctor,
      specialty: 'Ophthalmology',
      country: 'Türkiye',
      city: 'İzmir',
      rating: 4.9,
      reviewCount: 276,
      imageUrl: 'https://i.pravatar.cc/300?img=1',
      phone: '+90 232 555 0707',
      email: 'ayse.celik@medifinder.com',
      bio:
          'Dr. Ayşe Çelik, göz hastalıkları ve lazer göz cerrahisi alanında 16 yıllık tecrübeye sahiptir. Ege Üniversitesi Tıp Fakültesi\'nden mezun olmuş, LASIK ve katarakt cerrahisinde uzmanlaşmıştır.',
      address: 'Alsancak, Kıbrıs Şehitleri Cad. No:55, İzmir',
      isVerified: true,
      yearsOfExperience: 16,
      languages: ['Türkçe', 'English'],
      services: ['LASIK', 'Cataract Surgery', 'Glaucoma Treatment', 'Retina Surgery'],
    ),

    // ── Clinics ──
    const ProviderModel(
      id: 'cli-001',
      name: 'MediEsthetics Clinic',
      type: ProviderType.clinic,
      specialty: 'Aesthetic Medicine',
      country: 'Türkiye',
      city: 'İstanbul',
      rating: 4.7,
      reviewCount: 534,
      imageUrl: 'https://i.pravatar.cc/300?img=60',
      phone: '+90 212 555 1001',
      email: 'info@mediesthetics.com',
      bio:
          'MediEsthetics, İstanbul\'un kalbinde yer alan, JCI akreditasyonlu bir estetik ve güzellik kliniğidir. Saç ekimi, yüz estetiği ve vücut şekillendirme alanlarında uzman kadrosuyla hizmet vermektedir.',
      address: 'Nişantaşı, Abdi İpekçi Cad. No:20, Şişli/İstanbul',
      isVerified: true,
      yearsOfExperience: 8,
      languages: ['Türkçe', 'English', 'Deutsch', 'العربية'],
      services: ['Hair Transplant', 'Rhinoplasty', 'Dental Veneers', 'Botox'],
    ),
    const ProviderModel(
      id: 'cli-002',
      name: 'Berlin Dental Center',
      type: ProviderType.clinic,
      specialty: 'Dentistry',
      country: 'Germany',
      city: 'Berlin',
      rating: 4.6,
      reviewCount: 187,
      imageUrl: 'https://i.pravatar.cc/300?img=61',
      phone: '+49 30 555 1002',
      email: 'info@berlindentalcenter.de',
      bio:
          'Berlin Dental Center is a state-of-the-art dental clinic offering comprehensive dental care including implants, orthodontics, and cosmetic dentistry. Located in the heart of Mitte district.',
      address: 'Friedrichstraße 95, 10117 Berlin',
      isVerified: true,
      yearsOfExperience: 12,
      languages: ['Deutsch', 'English', 'Türkçe'],
      services: ['Dental Implants', 'Orthodontics', 'Root Canal', 'Crowns'],
    ),
    const ProviderModel(
      id: 'cli-003',
      name: 'NYC Skin & Laser',
      type: ProviderType.clinic,
      specialty: 'Dermatology',
      country: 'USA',
      city: 'New York',
      rating: 4.4,
      reviewCount: 223,
      imageUrl: 'https://i.pravatar.cc/300?img=62',
      phone: '+1 212 555 1003',
      email: 'info@nycskinlaser.com',
      bio:
          'NYC Skin & Laser is a premier dermatology clinic on the Upper East Side, specializing in advanced skin treatments, laser therapy, and anti-aging procedures. Board-certified dermatologists on staff.',
      address: '789 Park Avenue, New York, NY 10021',
      isVerified: false,
      yearsOfExperience: 6,
      languages: ['English', 'Español', 'Français'],
      services: ['Laser Therapy', 'Chemical Peels', 'Micro-needling', 'Botox'],
    ),
    const ProviderModel(
      id: 'cli-004',
      name: 'Smile Academy',
      type: ProviderType.clinic,
      specialty: 'Dentistry',
      country: 'Türkiye',
      city: 'Antalya',
      rating: 4.8,
      reviewCount: 389,
      imageUrl: 'https://i.pravatar.cc/300?img=63',
      phone: '+90 242 555 1004',
      email: 'info@smileacademy.com.tr',
      bio:
          'Smile Academy, Antalya\'da dental turizmin öncü kliniklerinden biridir. Hollywood Smile, implant ve ortodonti alanlarında uluslararası standartlarda hizmet sunmaktadır.',
      address: 'Lara, Güzeloba Mah. No:112, Muratpaşa/Antalya',
      isVerified: true,
      yearsOfExperience: 10,
      languages: ['Türkçe', 'English', 'Deutsch', 'Русский'],
      services: ['Hollywood Smile', 'Dental Implants', 'Orthodontics', 'Veneers'],
    ),

    // ── Hospitals ──
    const ProviderModel(
      id: 'hos-001',
      name: 'Acıbadem Hastanesi',
      type: ProviderType.hospital,
      specialty: 'General Medicine',
      country: 'Türkiye',
      city: 'İstanbul',
      rating: 4.8,
      reviewCount: 1245,
      imageUrl: 'https://i.pravatar.cc/300?img=64',
      phone: '+90 212 555 2001',
      email: 'info@acibadem.com',
      bio:
          'Acıbadem Hastaneler Grubu, Türkiye\'nin en büyük özel sağlık kuruluşlarından biridir. 1991 yılından bu yana JCI akreditasyonlu hastaneleri ile uluslararası standartlarda sağlık hizmeti sunmaktadır.',
      address: 'Altunizade, Fahrettin Kerim Gökay Cad. No:49, Üsküdar/İstanbul',
      isVerified: true,
      yearsOfExperience: 33,
      languages: ['Türkçe', 'English', 'Deutsch', 'العربية', 'Русский'],
      services: ['Cardiology', 'Oncology', 'Neurology', 'Orthopedics', 'IVF'],
    ),
    const ProviderModel(
      id: 'hos-002',
      name: 'Charité Hospital',
      type: ProviderType.hospital,
      specialty: 'General Medicine',
      country: 'Germany',
      city: 'Berlin',
      rating: 4.9,
      reviewCount: 2103,
      imageUrl: 'https://i.pravatar.cc/300?img=65',
      phone: '+49 30 555 2002',
      email: 'info@charite.de',
      bio:
          'Charité – Universitätsmedizin Berlin is one of the largest university hospitals in Europe. With a history spanning over 300 years, it is a leading center for medical research and patient care.',
      address: 'Charitéplatz 1, 10117 Berlin',
      isVerified: true,
      yearsOfExperience: 300,
      languages: ['Deutsch', 'English', 'Français', 'Español'],
      services: ['Surgery', 'Oncology', 'Neurosurgery', 'Transplant', 'Cardiology'],
    ),
    const ProviderModel(
      id: 'hos-003',
      name: 'Memorial Şişli Hastanesi',
      type: ProviderType.hospital,
      specialty: 'General Medicine',
      country: 'Türkiye',
      city: 'İstanbul',
      rating: 4.7,
      reviewCount: 987,
      imageUrl: 'https://i.pravatar.cc/300?img=66',
      phone: '+90 212 555 2003',
      email: 'info@memorial.com.tr',
      bio:
          'Memorial Sağlık Grubu, 2000 yılından bu yana Türkiye\'nin önde gelen sağlık kuruluşlarından biri olarak hizmet vermektedir. 12 hastane ve 10 tıp merkezi ile geniş bir ağa sahiptir.',
      address: 'Piyalepaşa Bulvarı, Şişli/İstanbul',
      isVerified: true,
      yearsOfExperience: 24,
      languages: ['Türkçe', 'English', 'العربية'],
      services: ['Cardiology', 'IVF', 'Oncology', 'Organ Transplant', 'Robotic Surgery'],
    ),
    const ProviderModel(
      id: 'hos-004',
      name: 'London Bridge Hospital',
      type: ProviderType.hospital,
      specialty: 'General Medicine',
      country: 'UK',
      city: 'London',
      rating: 4.6,
      reviewCount: 756,
      imageUrl: 'https://i.pravatar.cc/300?img=67',
      phone: '+44 20 555 2004',
      email: 'info@londonbridgehospital.com',
      bio:
          'London Bridge Hospital is a leading private hospital in Central London, part of HCA Healthcare UK. It offers a wide range of specialist services including cancer care, cardiac services, and orthopaedics.',
      address: '27 Tooley Street, London SE1 2PR',
      isVerified: true,
      yearsOfExperience: 38,
      languages: ['English', 'Français', 'العربية'],
      services: ['Cancer Care', 'Cardiac Surgery', 'Orthopaedics', 'Gastroenterology'],
    ),
  ];

    _providers.addAll(baseProviders);

    const catalogCountries = [
      'Türkiye',
      'Türkiye',
      'Türkiye',
      'Germany',
      'UK',
      'USA',
      'France',
      'Italy',
      'Spain',
      'Canada',
      'Australia',
    ];

    const citiesByCountry = {
      'Türkiye': [
        'İstanbul',
        'Ankara',
        'İzmir',
        'Antalya',
        'Bursa',
        'Adana',
      ],
      'Germany': ['Berlin', 'Munich', 'Hamburg', 'Frankfurt', 'Cologne'],
      'UK': ['London', 'Manchester', 'Birmingham', 'Edinburgh', 'Glasgow'],
      'USA': [
        'New York',
        'Los Angeles',
        'Chicago',
        'Houston',
        'Miami',
        'Boston',
      ],
      'France': ['Paris', 'Marseille', 'Lyon', 'Toulouse', 'Nice'],
      'Italy': ['Rome', 'Milan', 'Naples', 'Turin', 'Florence'],
      'Spain': ['Madrid', 'Barcelona', 'Valencia', 'Seville', 'Zaragoza'],
      'Canada': ['Toronto', 'Vancouver', 'Montreal', 'Calgary', 'Ottawa'],
      'Australia': ['Sydney', 'Melbourne', 'Brisbane', 'Perth', 'Adelaide'],
    };

    const specialties = [
      'Cardiology',
      'Dermatology',
      'Orthopedics',
      'Plastic Surgery',
      'Hair Transplant',
      'Dentistry',
      'Ophthalmology',
      'Aesthetic Medicine',
      'General Medicine',
      'Pediatrics',
      'Neurology',
      'Oncology',
      'Gynecology',
      'Urology',
      'Psychiatry',
      'Gastroenterology',
      'Pulmonology',
      'Endocrinology',
      'Rheumatology',
      'Nephrology',
      'Otolaryngology',
      'General Surgery',
    ];

    final random = dart_math.Random(42);
    final firstNames = [
      'John',
      'Jane',
      'Michael',
      'Sarah',
      'Ahmet',
      'Ayşe',
      'Hans',
      'Maria',
      'Ali',
      'Fatma',
      'James',
      'Emily',
      'Carlos',
      'Sophie',
      'Marco',
      'Elena',
      'Pierre',
      'Yuki',
      'Oliver',
      'Isabella',
    ];
    final lastNames = [
      'Smith',
      'Doe',
      'Yılmaz',
      'Müller',
      'Kaya',
      'Johnson',
      'Williams',
      'Demir',
      'Çelik',
      'Brown',
      'Garcia',
      'Rossi',
      'Martin',
      'Schmidt',
      'Dubois',
      'Wilson',
    ];

    for (var i = 1; i <= 450; i++) {
      final fName = firstNames[random.nextInt(firstNames.length)];
      final lName = lastNames[random.nextInt(lastNames.length)];
      final country = catalogCountries[random.nextInt(catalogCountries.length)];
      final cities = citiesByCountry[country]!;
      final city = cities[random.nextInt(cities.length)];
      final isVerified = random.nextBool();
      final pType = ProviderType.values[random.nextInt(3)];
      final rating = 3.5 + random.nextDouble() * 1.5;

      final String name;
      if (pType == ProviderType.doctor) {
        name = 'Dr. $fName $lName';
      } else if (pType == ProviderType.clinic) {
        name = '$lName Clinic';
      } else {
        name = '$fName Medical Center';
      }

      _providers.add(
        ProviderModel(
          id: 'gen-$i',
          name: name,
          type: pType,
          specialty: specialties[random.nextInt(specialties.length)],
          country: country,
          city: city,
          rating: double.parse(rating.toStringAsFixed(1)),
          reviewCount: random.nextInt(1500) + 10,
          imageUrl: 'https://i.pravatar.cc/300?img=${(i % 70) + 1}',
          phone: '+1 555 01${i.toString().padLeft(2, '0')}',
          email: 'contact$i@medifinder.com',
          bio:
              'Experienced healthcare provider offering top-tier services in modern facilities.',
          address: '123 Main St, $city',
          isVerified: isVerified,
          yearsOfExperience: random.nextInt(30) + 2,
          languages: [
            'English',
            if (random.nextBool()) 'Türkçe',
            if (random.nextBool()) 'Deutsch',
          ],
          services: const ['Consultation', 'Diagnostic'],
        ),
      );
    }
  }
}
