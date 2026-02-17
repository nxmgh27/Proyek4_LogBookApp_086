# logbook_app_086

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Bagaimana prinsip SRP membantu saat menambah fitur History Logger?

Prinsip Single Responsibility Principle (SRP) menyatakan bahwa satu class hanya boleh memiliki satu tanggung jawab utama.

Dalam proyek ini:

CounterController → Bertanggung jawab pada logika bisnis (menghitung nilai, menyimpan history).

CounterView → Bertanggung jawab pada tampilan UI dan interaksi user.

Saat menambahkan fitur History Logger, hanya perlu memodifikasi CounterController untuk menambahkan pencatatan riwayat, tanpa mengubah struktur utama UI secara besar-besaran.

Karena tanggung jawab sudah dipisah dengan jelas:

Perubahan logika tidak merusak tampilan.

Perubahan UI tidak memengaruhi logika bisnis.

Kode menjadi lebih mudah dipahami dan dirawat.

Dengan menerapkan SRP, proses penambahan fitur menjadi lebih terstruktur, minim bug, dan lebih scalable untuk pengembangan selanjutnya.
