import 'package:flutter_test/flutter_test.dart';
import 'package:medifinder_case_study/core/models/provider_model.dart';

void main() {
  group('ProviderType Extension', () {
    test('isDoctor returns true for doctor type', () {
      expect(ProviderType.doctor.isDoctor, isTrue);
      expect(ProviderType.clinic.isDoctor, isFalse);
    });

    test('isClinic returns true for clinic type', () {
      expect(ProviderType.clinic.isClinic, isTrue);
      expect(ProviderType.hospital.isClinic, isFalse);
    });

    test('isHospital returns true for hospital type', () {
      expect(ProviderType.hospital.isHospital, isTrue);
      expect(ProviderType.doctor.isHospital, isFalse);
    });
  });

  group('ProviderModel Serialization', () {
    test('fromJson creates correct model from valid JSON', () {
      final json = {
        'id': '1',
        'name': 'Test Doctor',
        'type': 'doctor',
        'specialty': 'Cardiology',
        'country': 'Türkiye',
        'city': 'İstanbul',
        'rating': 4.5,
        'reviewCount': 100,
      };

      final model = ProviderModel.fromJson(json);

      expect(model.id, '1');
      expect(model.name, 'Test Doctor');
      expect(model.type, ProviderType.doctor);
      expect(model.rating, 4.5);
      // Defaults should be applied
      expect(model.isVerified, isFalse);
      expect(model.yearsOfExperience, 0);
      expect(model.languages, isEmpty);
    });

    test('toJson creates correct JSON map from model', () {
      const model = ProviderModel(
        id: '2',
        name: 'Test Clinic',
        type: ProviderType.clinic,
        specialty: 'Dentistry',
        country: 'Germany',
        city: 'Berlin',
        rating: 4.8,
        reviewCount: 50,
      );

      final json = model.toJson();

      expect(json['id'], '2');
      expect(json['name'], 'Test Clinic');
      expect(json['type'], 'clinic');
      expect(json['specialty'], 'Dentistry');
    });
  });
}
