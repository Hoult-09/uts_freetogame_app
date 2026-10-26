# Aplikasi Katalog Game PC Gratis (FreeToGame)

Aplikasi mobile berbasis Flutter yang menampilkan katalog game PC gratis secara live dengan mengonsumsi REST API dari FreeToGame.

## Fitur Utama
- **Consuming REST API**: Mengambil data game PC menggunakan permintaan HTTP GET.
- **Asynchronous State Handling**: Menangani kondisi Loading, Success, dan Error.
- **Antarmuka Dinamis**: Menampilkan thumbnail, judul, genre, dan platform game.

## Teknologi & Package
- **Framework**: Flutter (Dart)
- **Package**: http (^1.2.0)
- **API**: FreeToGame API (`https://www.freetogame.com/api/games?platform=pc`)

## Cara Menjalankan Aplikasi
1. Clone repositori ini
2. Jalankan `flutter pub get`
3. Jalankan `flutter run`
