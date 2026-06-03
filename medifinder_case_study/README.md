# MediFinder — Mobile Engineer Case Study

MediFinder, sağlık profesyonelleri ve kuruluşlarını keşfetmeyi hedefleyen bir platformun mobil case study uygulamasıdır. Bu proje, **Provider arama akışının** (Liste → Filtre → Profil Detay) temiz, sürdürülebilir ve üretim kalitesine yakın bir şekilde geliştirilmesini göstermek amacıyla hazırlanmıştır.

**Teknoloji:** Flutter  
**Veri kaynağı:** Mock data (backend entegrasyonu yok)

---

## Uygulama Akışı

| # | Ekran | Açıklama |
|---|-------|----------|
| 1 | **Provider List** | Sağlayıcı listesi, arama alanı ve tip sekmeleri (Doctor / Clinic / Hospital) |
| 2 | **Filter** | Ülke, şehir ve branş/kategori filtreleri (modal bottom sheet) |
| 3 | **Provider Detail** | Temel profil, iletişim bilgileri ve bio |

---

## Mimari ve State Yönetimi

```
lib/
├── blocs/          # İş mantığı ve UI state (BLoC)
├── repos/          # Veri soyutlama katmanı
├── data/           # Mock data source
├── core/           # Modeller, router, tema, extension'lar, utils
└── ui/             # Ekranlar ve yeniden kullanılabilir widget'lar
```

### State yönetimi — BLoC

[`flutter_bloc`](https://pub.dev/packages/flutter_bloc) kullanılmıştır:

| BLoC | Sorumluluk |
|------|------------|
| `ProviderListBloc` | Liste, arama, filtre, sekme bazlı lazy load, pagination, refresh |
| `ProviderFilterBloc` | Filtre form state'i; ülke → şehir cascade |
| `ProviderDetailBloc` | Tekil provider detay yükleme |
| `ThemeBloc` / `LocaleBloc` | Tema ve dil tercihleri |

**Neden BLoC?** Event-driven akış, test edilebilirlik ve UI'dan iş mantığının net ayrımı.

### Veri katmanı

- `MockProviderDataSource` — simüle ağ gecikmesi, paginated mock API, `simulateError` flag'i
- `ProviderRepository` — BLoC'lar ile data source arasında tek giriş noktası
- Gerçek API'ye geçiş için repository sınıfı ince tutulmuştur; HTTP client bu katmana eklenebilir

### Navigation

[`go_router`](https://pub.dev/packages/go_router):

| Route | Ekran |
|-------|-------|
| `/splash` | Splash |
| `/` | Provider List |
| `/provider/:id` | Provider Detail |

Filtre ekranı route değil; liste üzerinden **modal bottom sheet** olarak açılır.

---

## Önemli Teknik Kararlar

**Modeller** — `freezed` + `json_serializable` ile immutable modeller.

**Widget organizasyonu** — Ekranlar private parçalara bölünmüştür (`_provider_list_body.dart`, `_detail_header.dart`). Ortak bileşenler `lib/ui/widgets/` altında (`ProviderCard`, `SearchField`, `ErrorView`, `PolishedSurface`).

**Tema sistemi** — Renk, font ve tipografi token'ları merkezi dosyalarda:
- `app_colors.dart` — marka renkleri + brightness-aware yardımcılar
- `app_typography.dart` — Plus Jakarta Sans
- `app_style_extension.dart` — `context.styles.*` semantic stiller
- `app_shapes.dart` — border radius sabitleri

UI widget'larında doğrudan `Colors.white` / magic `fontSize` kullanımından kaçınılır; `ColorScheme` ve `context.styles` tercih edilir.

**Null / eksik veri** — `phone`, `email`, `bio`, `address`, `imageUrl` nullable; boş alanlar gizlenir veya placeholder gösterilir.

**Loading / empty / error**
- Liste: shimmer skeleton, `EmptyView`, `ErrorView` + retry, pull-to-refresh, load-more spinner
- Detay: loading indicator, `ErrorView` + retry, nullable alan gizleme
- Sekme bazlı hata: `tabErrors` map ile Clinic/Hospital fetch hataları ayrı yönetilir

**Pagination** — `ProviderPageResult` ile offset/limit; sekme başına lazy load (ilk ziyarette yüklenir, geri dönüşte cache korunur).

**Lokalizasyon** — TR/EN `gen-l10n`; ülke, şehir, branş ve tag verileri `localizeData()` / `localizeTag()` ile çevrilir.

**Retry / hata simülasyonu**

```dart
// main.dart — geliştirme sırasında hata senaryosu test etmek için:
MockProviderDataSource.instance.simulateError = true;
```

Liste, sekme ve detay ekranlarında retry butonu ilgili BLoC event'ini yeniden tetikler.

---

## Kurulum

```bash
git clone https://github.com/elassava/medifinder-case-study.git
cd medifinder-case-study
flutter pub get
flutter gen-l10n
dart run build_runner build --delete-conflicting-outputs
flutter run
```

---

## Testler

```bash
flutter test
```

| Test | Kapsam |
|------|--------|
| `test/blocs/provider_list/` | Fetch, search, pagination, hata |
| `test/core/models/` | Model serileştirme |
| `test/ui/screens/provider_list/` | Liste ekranı widget testleri |
| `test/ui/widgets/` | Paylaşılan widget testleri |

---

## CI / iOS Simulator Build

`codemagic.yaml` ile Codemagic CI tanımlıdır:
- **ios-simulator** — simulator `.app` build (Appetize.io için)
- **android-debug** — debug APK

---

## Bilinen Sınırlamalar

- Gerçek ağ / offline algılama yok (mock katman)
- Kart üzerindeki bookmark/mail ikonları dekoratif (case study kapsamı dışı)
- `simulateError` runtime toggle UI'da yok; kod ile aktive edilir

---

## Lisans

Bu proje MediFinder Mobile Engineer Case Study kapsamında geliştirilmiştir.
