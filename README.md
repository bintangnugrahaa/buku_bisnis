# Buku Bisnis

Monorepo ini menyatukan backend **Laravel 12 + Filament 4** dan frontend **Flutter 3.8** untuk membangun sistem pembukuan multi-user yang siap pakai bagi pelaku usaha. Backend menyediakan REST API, otomasi transaksi, serta panel admin, sedangkan aplikasi mobile memberikan pengalaman pengelolaan keuangan yang modern dan responsif.

## Isi Repositori

```
.
├── backend/   # Laravel Bookkeeping API + Filament admin panel
└── frontend/  # Flutter mobile app dengan Clean Architecture
```

## Fitur Utama

- **Multiplatform bookkeeping**: API Laravel dengan autentikasi Sanctum dan aplikasi Flutter berbasis BLoC.
- **Manajemen keuangan lengkap**: akun, kategori bersarang, transaksi transfer, lampiran bukti, dan aturan transaksi berulang.
- **Panel administrasi siap pakai**: Filament 4 untuk CRUD cepat, laporan, dan manajemen pengguna.
- **Arsitektur Clean di mobile**: pemisahan Core → Data → Domain → Presentation dengan dukungan offline cache.
- **Dokumentasi & Postman**: koleksi API, desain database, serta panduan integrasi Flutter ↔ Laravel tersedia di folder `docs/`.

## Teknologi

| Layer    | Stack                                                               |
| -------- | ------------------------------------------------------------------- |
| Backend  | PHP 8.2, Laravel 12, Filament 4, Sanctum, DOMPDF, Pest/PHPUnit      |
| Frontend | Flutter 3.8, Dart 3, flutter_bloc, dio, freezed, shared_preferences |
| Tooling  | Vite, NPM, Composer, Build Runner, Sqflite, Connectivity Plus       |

## Arsitektur Sistem

1. **REST API** – Laravel menyajikan endpoint JSON yang diamankan oleh Laravel Sanctum. Queue worker mengelola job berat (mis. generating laporan) dan scheduler menangani recurring transaction.
2. **Admin Console** – Filament 4 memberi dashboard siap pakai untuk mengelola akun, kategori, transaksi, serta upload lampiran.
3. **Mobile Client** – Flutter app mengonsumsi API tersebut melalui layer repository → usecase → BLoC → UI, lengkap dengan caching lokal via `shared_preferences`/`sqflite`.

Skema basis data, termasuk relasi akun, kategori bersarang, dan pasangan transaksi transfer, tersedia di `backend/DATABASE_DESIGN.md`.

## Persiapan Lingkungan

- PHP 8.2+, Composer 2.x
- Node.js 20+ & NPM 10+ (untuk Vite asset dev)
- MySQL/MariaDB atau PostgreSQL
- Flutter SDK 3.8.1+, Android Studio/Xcode cli tools
- Git, OpenSSL, serta Java 17 (Android build)

## Setup Cepat

```bash
git clone https://github.com/bintangnugrahaa/buku_bisnis.git
cd buku_bisnis
```

### Backend (Laravel)

```bash
cd backend
cp .env.example .env        # sesuaikan DB, APP_URL, SANCTUM stateful domains
composer install
npm install && npm run build
php artisan key:generate
php artisan migrate --seed   # membuat akun, kategori, transaksi contoh
php artisan storage:link
php artisan serve            # http://127.0.0.1:8000
```

Tambahan saat pengembangan:

- Jalankan asset dev server: `npm run dev`
- Worker queue: `php artisan queue:listen --tries=1`
- Scheduler lokal: `php artisan schedule:work`
- Testing: `php artisan test` atau `./vendor/bin/pest`

### Frontend (Flutter)

```bash
cd frontend
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

Konfigurasi base URL API pada `lib/core/constants/app_constants.dart` agar menunjuk ke host backend (mis. `http://10.0.2.2:8000/api` untuk emulator Android). Setelah itu jalankan:

```bash
flutter run                    # pilih device/emulator
flutter test                   # menjalankan widget/unit tests
```

Untuk rilis:

- Android: `flutter build apk --release`
- iOS: `flutter build ipa`

## Menjalankan Stack Lengkap

1. Start backend (`php artisan serve`) dan asset watcher (`npm run dev`) di folder `backend`.
2. Pastikan DB & queue worker aktif.
3. Update base URL di frontend lalu jalankan `flutter run`.
4. Gunakan Postman collection di `backend/postman/` atau `frontend/docs/` untuk menguji endpoint.

## Dokumentasi & Referensi

- `backend/docs/` – API reference, panduan testing, integrasi Flutter.
- `backend/postman/` – Koleksi & lingkungan Postman siap impor.
- `frontend/docs/README_INTEGRATION.md` – Cara menyambungkan Flutter ke API Laravel.
- `frontend/README_STRUCTURE.md` – Penjelasan Clean Architecture dan struktur folder.

## Quality Assurance

- **Backend**: gunakan `php artisan test` atau `composer test` untuk menjalankan suite Feature, Unit, dan Pest.
- **Frontend**: `flutter test` untuk widget/unit, serta jalankan `dart run build_runner watch` saat mengembangkan model Freezed.
- **Linting**: `vendor/bin/pint` untuk Laravel, `flutter analyze` untuk aplikasi mobile.

## Deployment Catatan Penting

- Konfigurasikan `APP_URL`, `SANCTUM_STATEFUL_DOMAINS`, storage persistent, serta cron `* * * * * php artisan schedule:run` di server backend.
- Pastikan queue worker di manajer proses (Supervisor/Systemd) untuk recurring transaction.
- Flutter build release membutuhkan konfigurasi keystore (Android) atau signing certificate (iOS) sesuai standar Flutter.

## Kontribusi

1. Fork → feature branch (`git checkout -b feature/<nama>`).
2. Pastikan lint & test lulus pada backend dan frontend.
3. Buat pull request dengan deskripsi perubahan dan langkah uji.

---

Dikembangkan untuk membantu keuangan melacak arus kas dengan pengalaman modern dan terintegrasi penuh antara Laravel & Flutter. Selamat membangun! 🎯
