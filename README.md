# MediFinder — Mobile Engineer Case Study

*(English Version)*

MediFinder is a mobile case study application for a platform aimed at discovering healthcare professionals and organizations. This project was prepared to demonstrate the development of the **Provider search flow** (List → Filter → Profile Detail) in a clean, maintainable, and near-production-quality manner.

**Technology:** Flutter  
**Data source:** Mock data (no backend integration)

---

## App Flow

| # | Screen | Description |
|---|--------|-------------|
| 1 | **Provider List** | Provider list, search area, and type tabs (Doctor / Clinic / Hospital) |
| 2 | **Filter** | Country, city, and specialty/category filters (modal bottom sheet) |
| 3 | **Provider Detail** | Basic profile, contact information, and bio |

---

## Architecture and State Management

```
lib/
├── blocs/          # Business logic and UI state (BLoC)
├── repos/          # Data abstraction layer
├── data/           # Mock data source
├── core/           # Models, router, theme, extensions, utils
└── ui/             # Screens and reusable widgets
```

### State Management — BLoC

[`flutter_bloc`](https://pub.dev/packages/flutter_bloc) is used:

| BLoC | Responsibility |
|------|----------------|
| `ProviderListBloc` | List, search, filter, tab-based lazy load, pagination, refresh |
| `ProviderFilterBloc` | Filter form state; country → city cascade |
| `ProviderDetailBloc` | Single provider detail loading |
| `ThemeBloc` / `LocaleBloc` | Theme and language preferences |

**Why BLoC?** Event-driven flow, testability, and clear separation of business logic from UI.

### Data Layer

- `MockProviderDataSource` — simulated network delay, paginated mock API, `simulateError` flag
- `ProviderRepository` — single entry point between BLoCs and data source
- Repository class is kept thin for transition to a real API; HTTP client can be added to this layer

### Navigation

[`go_router`](https://pub.dev/packages/go_router):

| Route | Screen |
|-------|--------|
| `/splash` | Splash |
| `/` | Provider List |
| `/provider/:id` | Provider Detail |

The filter screen is not a route; it opens as a **modal bottom sheet** over the list.

---

## Key Technical Decisions

**Models** — Immutable models with `freezed` + `json_serializable`.

**Widget Organization** — Screens are split into private parts (`_provider_list_body.dart`, `_detail_header.dart`). Common components are under `lib/ui/widgets/` (`ProviderCard`, `SearchField`, `ErrorView`, `PolishedSurface`).

**Theme System** — Color, font, and typography tokens are in central files:
- `app_colors.dart` — brand colors + brightness-aware helpers
- `app_typography.dart` — Plus Jakarta Sans
- `app_style_extension.dart` — semantic styles like `context.styles.*`
- `app_shapes.dart` — border radius constants

Direct use of `Colors.white` or magic `fontSize` is avoided in UI widgets; `ColorScheme` and `context.styles` are preferred.

**Null / Missing Data** — `phone`, `email`, `bio`, `address`, `imageUrl` are nullable; empty fields are hidden or a placeholder is shown.

**Loading / Empty / Error**
- List: shimmer skeleton, `EmptyView`, `ErrorView` + retry, pull-to-refresh, load-more spinner
- Detail: loading indicator, `ErrorView` + retry, nullable field hiding
- Tab-based error: Clinic/Hospital fetch errors are managed separately with a `tabErrors` map

**Pagination** — offset/limit with `ProviderPageResult`; tab-based lazy load (loaded on first visit, cache preserved on return).

**Localization** — TR/EN `gen-l10n`; country, city, specialty, and tag data are translated using `localizeData()` / `localizeTag()`.

**Retry / Error Simulation**

```dart
// main.dart — to test error scenarios during development:
MockProviderDataSource.instance.simulateError = true;
```

The retry button on the list, tab, and detail screens re-triggers the corresponding BLoC event.

---

## Installation

```bash
git clone https://github.com/elassava/medifinder-case-study.git
cd medifinder-case-study
flutter pub get
flutter gen-l10n
dart run build_runner build --delete-conflicting-outputs
flutter run
```

---

## Tests

```bash
flutter test
```

| Test | Coverage |
|------|----------|
| `test/blocs/provider_list/` | Fetch, search, pagination, error |
| `test/core/models/` | Model serialization |
| `test/ui/screens/provider_list/` | List screen widget tests |
| `test/ui/widgets/` | Shared widget tests |

---

## CI / iOS Simulator Build

Codemagic CI is defined with `codemagic.yaml`:
- **ios-simulator** — simulator `.app` build (for Appetize.io)
- **android-debug** — debug APK

---

## Known Limitations

- No real network / offline detection (mock layer)
- Bookmark/mail icons on the card are decorative (out of case study scope)
- `simulateError` runtime toggle is not in the UI; activated via code

---

## License

This project was developed as part of the MediFinder Mobile Engineer Case Study.

---

*(Türkçe Versiyon)*

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
