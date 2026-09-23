📱 Aplikasi Pengaduan Sarana SMP Negeri 3 Bantul

Aplikasi Pengaduan Sarana Sekolah merupakan aplikasi berbasis
Flutter yang dibuat untuk membantu siswa menyampaikan pengaduan mengenai
sarana dan kondisi lingkungan sekolah secara lebih mudah, terstruktur,
dan terdokumentasi.

Aplikasi ini memiliki sisi siswa serta admin/petugas. Siswa
dapat membuat dan memantau pengaduan, sedangkan admin/petugas dapat
melihat, mengelola, memperbarui status, memberikan feedback, dan membuat
laporan pengaduan.

🎯 Tujuan Proyek

Proyek ini dibuat untuk:

Mempermudah siswa menyampaikan keluhan atau laporan mengenai
fasilitas sekolah.

Membantu admin/petugas mengelola pengaduan secara terpusat.

Menyediakan informasi status pengaduan secara jelas.

Menyimpan data pengaduan agar lebih terstruktur.

Memberikan notifikasi ketika terjadi pembaruan pada pengaduan.

Membantu proses evaluasi melalui statistik dan laporan pengaduan.

✨ Fitur Utama

👨‍🎓 Fitur Siswa

Registrasi akun siswa

Login siswa

Halaman beranda siswa

Profil pengguna

Upload dan perubahan foto profil

Buat pengaduan

Pilih kategori pengaduan

Isi judul dan deskripsi masalah

Lampiran foto/video sebagai bukti

Melihat riwayat pengaduan

Melihat detail pengaduan

Melihat status pengaduan

Melihat feedback/tanggapan admin

Notifikasi pembaruan pengaduan

Rating layanan

Panduan penggunaan aplikasi

Mode terang dan mode gelap

Logout

👨‍💼 Fitur Admin/Petugas

Login admin/petugas

Registrasi admin/petugas

Dashboard pengelolaan pengaduan

Melihat daftar pengaduan

Melihat detail pengaduan

Filter/status pengaduan

Mengubah status pengaduan

Memberikan feedback kepada siswa

Melihat statistik pengaduan

Mengirim pembaruan melalui sistem notifikasi

Mencetak laporan pengaduan dalam format PDF

🔔 Sistem Notifikasi

Aplikasi menggunakan dokumen Firestore pada collection notifications
sebagai data notifikasi.

Ketika admin/petugas mengubah status atau memberikan feedback, aplikasi
dapat membuat notifikasi untuk akun siswa terkait. Aplikasi siswa
kemudian memantau notifikasi tersebut dan menampilkan local
notification pada perangkat.

Catatan: mekanisme listener Firestore + local notification pada proyek
ini berbeda dengan push notification FCM yang membutuhkan pengiriman
pesan dari server. Dukungan firebase_messaging tersedia di project,
tetapi alur notifikasi yang digunakan oleh NotificationService
adalah Firestore + local notification.

🛠️ Teknologi yang Digunakan

Teknologi / Package               Fungsi

Flutter                       Framework untuk membangun aplikasi
Dart                          Bahasa pemrograman
Firebase Core                 Inisialisasi dan koneksi Firebase
Firebase Authentication       Login dan registrasi pengguna
Cloud Firestore               Database pengaduan, pengguna, dan notifikasi
Firebase Storage              Penyimpanan foto/file yang di-upload
Firebase Messaging            Dependensi untuk dukungan messaging/FCM
Flutter Local Notifications   Menampilkan notifikasi lokal
Image Picker                  Memilih foto/video dari perangkat
Video Player                  Menampilkan video background/animasi
PDF                           Membuat dokumen laporan PDF
Printing                      Menampilkan/mencetak laporan
FlutLab                       Lingkungan pengembangan Flutter berbasis online

🏗️ Struktur Project

pengaduan_sarana_sekolah/
│
├── android/
├── ios/
├── web/
│
├── assets/
│   ├── background1.mp4
│   ├── animasi.mp4
│   ├── logosmp3.jpg
│   └── logosmp3.png
│
├── lib/
│   ├── main.dart
│   │
│   ├── pages/
│   │   ├── splash_page.dart
│   │   ├── login_page.dart
│   │   ├── register_page.dart
│   │   ├── student_home_page.dart
│   │   ├── pengaduan_page.dart
│   │   ├── complaint_form_page.dart
│   │   ├── complaint_detail_page.dart
│   │   ├── history_page.dart
│   │   ├── admin_petugas_login_page.dart
│   │   ├── admin_petugas_register_page.dart
│   │   ├── admin_dashboard_page.dart
│   │   ├── home_page.dart
│   │   ├── dashboard_page.dart
│   │   │
│   │   └── models/
│   │       └── complaint_model.dart
│   │
│   ├── services/
│   │   ├── firebase_options.dart
│   │   ├── firestore_service.dart
│   │   ├── notification_service.dart
│   │   └── print_report_service.dart
│   │
│   └── widgets/
│       └── copyright_watermark.dart
│
├── pubspec.yaml
├── analysis_options.yaml
└── README.md

📂 Penjelasan Folder dan File Penting

lib/main.dart

Merupakan titik awal aplikasi.

Fungsinya antara lain:

Inisialisasi Firebase.

Inisialisasi NotificationService.

Mengatur tema terang dan gelap.

Menentukan halaman awal aplikasi melalui SplashPage.

lib/pages/splash_page.dart

Menampilkan halaman pembuka aplikasi sebelum pengguna masuk ke halaman
utama/login.

lib/pages/login_page.dart

Digunakan untuk proses login siswa.

lib/pages/register_page.dart

Digunakan siswa untuk membuat akun baru.

lib/pages/student_home_page.dart

Merupakan halaman utama siswa setelah berhasil login.

Di dalamnya terdapat akses ke:

profil,

pengaduan,

riwayat,

notifikasi,

panduan,

rating,

pengaturan tema,

logout.

lib/pages/complaint_form_page.dart

Digunakan untuk membuat pengaduan baru, termasuk memasukkan informasi
pengaduan dan lampiran.

lib/pages/history_page.dart

Menampilkan riwayat pengaduan milik siswa yang sedang login.

lib/pages/complaint_detail_page.dart

Menampilkan informasi detail sebuah pengaduan.

lib/pages/admin_dashboard_page.dart

Merupakan pusat pengelolaan pengaduan untuk admin/petugas.

Admin/petugas dapat:

melihat data pengaduan,

melihat statistik,

mengubah status,

memberikan feedback,

membuat notifikasi untuk siswa,

mencetak laporan.

lib/services/firestore_service.dart

Menyediakan fungsi untuk berkomunikasi dengan Cloud Firestore, terutama
untuk:

mengambil semua pengaduan,

mengambil pengaduan milik siswa,

menambahkan pengaduan,

memperbarui status,

memperbarui feedback.

lib/services/notification_service.dart

Mengatur sistem notifikasi lokal dan listener Firestore.

Fungsi utamanya:

inisialisasi local notification,

menampilkan notifikasi,

memantau collection notifications,

membuat notifikasi untuk siswa,

menghentikan listener notifikasi.

lib/services/print_report_service.dart

Berisi fungsi yang berkaitan dengan pembuatan/penanganan laporan cetak.

lib/pages/models/complaint_model.dart

Model data yang digunakan untuk merepresentasikan sebuah pengaduan dari
Firestore.

assets/

Berisi aset visual aplikasi seperti:

logo sekolah,

video background,

video animasi.

🔥 Struktur Data Firebase

Project menggunakan beberapa collection utama di Cloud Firestore.

users

Menyimpan data pengguna aplikasi.

Contoh data yang digunakan oleh aplikasi:

users
└── UID
    ├── nama
    ├── username
    ├── email
    ├── role
    ├── kelas
    └── photoUrl

pengaduan

Menyimpan data laporan/pengaduan siswa.

Contoh field:

pengaduan
└── ID Pengaduan
    ├── userId
    ├── nama
    ├── kategori
    ├── judul
    ├── deskripsi
    ├── fotoUrl
    ├── status
    ├── feedback
    └── tanggal

Status utama yang digunakan:

Menunggu
Diproses
Selesai

notifications

Menyimpan notifikasi yang ditujukan kepada siswa.

Contoh field:

notifications
└── ID Notifikasi
    ├── userId
    ├── complaintId
    ├── title
    ├── body
    ├── status
    ├── feedback
    ├── read
    └── createdAt

🔄 Alur Kerja Aplikasi

Siswa
  │
  ▼
Login / Registrasi
  │
  ▼
Beranda Siswa
  │
  ▼
Buat Pengaduan
  │
  ▼
Data disimpan ke Firestore
  │
  ▼
Admin / Petugas menerima laporan
  │
  ▼
Admin memeriksa pengaduan
  │
  ├── Menunggu
  │
  ├── Diproses
  │
  └── Selesai
  │
  ▼
Admin memberikan feedback
  │
  ▼
Notifikasi dibuat
  │
  ▼
Siswa menerima pembaruan

📊 Dashboard Admin

Dashboard admin/petugas menyediakan ringkasan data pengaduan, seperti:

jumlah pengaduan Menunggu,

jumlah pengaduan Diproses,

jumlah pengaduan Selesai,

daftar pengaduan,

detail pengaduan,

feedback,

serta fasilitas pembuatan laporan PDF.

Laporan dapat diproses menggunakan package pdf dan printing.

🔐 Autentikasi dan Role

Aplikasi menggunakan Firebase Authentication untuk autentikasi
pengguna.

Role pengguna dibedakan untuk kebutuhan akses aplikasi, terutama:

Siswa

Admin

Petugas

Akses halaman dan fitur disesuaikan dengan jenis pengguna yang sedang
login.

📱 Tampilan Aplikasi

Aplikasi menggunakan tema utama bernuansa:

Navy

Teal

Cream

Gold

Tampilan dibuat dengan pendekatan modern dan responsif, serta
menyediakan light mode dan dark mode.

Aplikasi juga menggunakan aset video sebagai background pada beberapa
halaman.

⚙️ Instalasi dan Menjalankan Project

1. Siapkan Flutter

Pastikan Flutter sudah terpasang atau gunakan lingkungan seperti
FlutLab.

2. Buka project

Buka folder project:

pengaduan_sarana_sekolah

3. Install dependencies

Jalankan:

flutter pub get

4. Konfigurasi Firebase

Project menggunakan konfigurasi Firebase pada:

lib/services/firebase_options.dart

Untuk Android, konfigurasi Firebase juga menggunakan:

android/app/google-services.json

Pastikan project Firebase yang digunakan sudah memiliki layanan yang
diperlukan, terutama:

Firebase Authentication

Cloud Firestore

Firebase Storage

5. Jalankan aplikasi

Untuk Android:

flutter run

Atau jalankan project melalui FlutLab.

📦 Dependencies

Beberapa dependency utama pada pubspec.yaml:

firebase_core
firebase_auth
cloud_firestore
firebase_storage
firebase_messaging
flutter_local_notifications
image_picker
video_player
pdf
printing
http

📝 Catatan Pengembangan

Project ini dikembangkan menggunakan Flutter dan Firebase,
dengan fokus pada sistem pengaduan fasilitas sekolah.

Data pengaduan disimpan secara terpusat sehingga siswa dapat memantau
laporan yang pernah dibuat, sedangkan admin/petugas dapat melakukan
pengelolaan dan memberikan tindak lanjut.

Sistem notifikasi pada versi project ini memanfaatkan Firestore
sebagai sumber data notifikasi dan Flutter Local Notifications
untuk menampilkan pemberitahuan pada perangkat.

🚀 Pengembangan Selanjutnya

Beberapa fitur yang dapat dikembangkan lebih lanjut:

Push notification yang tetap berjalan ketika aplikasi benar-benar
tidak aktif.

Sistem prioritas pengaduan.

Upload beberapa foto sekaligus.

Statistik pengaduan yang lebih lengkap.

Filter pengaduan berdasarkan kategori dan waktu.

Riwayat perubahan status pengaduan.

Sistem komentar antara siswa dan petugas.

Peningkatan keamanan Firebase Security Rules.

Pengelolaan akun dan role yang lebih terstruktur.

👨‍💻 Project

Nama Project: Aplikasi Pengaduan Sarana Sekolah
Instansi: SMP Negeri 3 Bantul
Platform: Flutter / Android / Web
Backend: Firebase
IDE: FlutLab

📌 Kesimpulan

Aplikasi Pengaduan Sarana Sekolah dibuat sebagai sarana digital
untuk membantu siswa menyampaikan pengaduan mengenai fasilitas sekolah
dan membantu pihak sekolah mengelola laporan tersebut secara lebih
terstruktur.

Dengan adanya sistem pengaduan, pengelolaan status, feedback,
notifikasi, statistik, dan laporan, proses penyampaian serta tindak
lanjut pengaduan dapat dilakukan melalui satu aplikasi.

"Dari Siswa Untuk Sekolah --- Sekolah Lebih Baik Bersama Kita."
