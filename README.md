Codelia - Future Tech Learning Center 🚀
Landing page modern dan responsif untuk Codelia, sebuah Pusat Pembelajaran Teknologi untuk Generasi Masa Depan. Proyek ini dikembangkan menggunakan Flutter Web dengan fokus pada pengalaman pengguna (UX) yang interaktif dan kode yang modular.

📸 Tampilan (Terdapat pada folder assets dengan nama masing-masing "web-codelia-dekstop.jpg" dan "web-codelia-mobile.jpg)

✨ Fitur Utama
- Fully Responsive: Layout beradaptasi otomatis antara tampilan Desktop (Row) dan Mobile (Column/Wrap).
- Smooth Scroll Navigation: Navigasi antar-bagian (About, Courses, Program, Contact) tanpa reload halaman.
- Interactive UI: Efek Zoom Hover pada kartu materi dan kontak untuk memberikan feedback visual.
- Modular Architecture: Kode dipisahkan berdasarkan fitur/section untuk kemudahan pemeliharaan (maintenance).
- External Linking: Integrasi langsung ke Email, WhatsApp, dan URL eksternal.

📂 Struktur Proyek
Proyek ini telah di-refactor dari satu file monolitik menjadi struktur modular untuk skalabilitas:
lib/
├── main.dart       # Entry point, Navbar, Hero Section, dan Logic Scroll utama

├── about_us.dart   # Bagian Visi & Misi dengan layout adaptif

├── courses.dart    # Daftar kursus dengan kartu interaktif

├── program.dart    # Pilihan program belajar

└── contact.dart    # Informasi kontak dan tombol aksi (Call to Action)

🛠️ Tech Stack
- Framework: Flutter (Channel Stable)
- Language: Dart
- Packages:
  url_launcher: Untuk membuka link eksternal (WA, Email).

🚀 Cara Menjalankan
1. Clone repository ini:
git clone

2. Masuk ke direktori:
cd codelia-landing-page

3. Install dependencies:
flutter pub get

4.Jalankan di Chrome:
flutter run -d chrome

📝 Catatan Pengembang
Refactoring dilakukan untuk memecah kode >800 baris menjadi 5 komponen terpisah. Setiap komponen (AboutUsSection, CoursesSection, dll) bersifat self-contained namun tetap menerima kontrol dari main.dart (seperti AnimationController untuk maskot).

📄 Lisensi
MIT License
