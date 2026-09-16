import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:apkekskul/main.dart';

void main() {
  testWidgets('Test alur aplikasi dari Home ke Form pendaftaran hingga simpan',
      (WidgetTester tester) async {
    // Jalankan aplikasi
    await tester.pumpWidget(const MyApp());
    expect(find.text('Selamat Datang'), findsOneWidget);

    // Buka Drawer menu
    final ScaffoldState scaffoldState =
        tester.firstState(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    // Klik menu Form Pendaftaran di Drawer
    await tester.tap(find.text('Form Pendaftaran'));
    await tester.pumpAndSettle();

    // Pastikan berada di FormPage
    expect(find.text('Form Pendaftaran Ekskul'), findsOneWidget);
    expect(find.text('Formulir Pendaftaran Siswa'), findsOneWidget);

    // Isi Nama
    final Finder namaField = find.widgetWithText(TextFormField, 'Nama');
    await tester.enterText(namaField, 'Budi Santoso');

    // Isi NIS
    final Finder nisField = find.widgetWithText(TextFormField, 'NIS');
    await tester.enterText(nisField, '123456');

    // Pilih Kelas dari Dropdown
    final Finder dropdownKelas = find.text('Pilih Kelas');
    await tester.tap(dropdownKelas);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kelas X RPL 1').last);
    await tester.pumpAndSettle();

    // Isi Nomor HP
    final Finder hpField = find.widgetWithText(TextFormField, 'Nomor HP');
    await tester.enterText(hpField, '08123456789');

    // Pilih Jenis Kelamin (Laki-laki)
    await tester.tap(find.text('Laki-laki'));
    await tester.pumpAndSettle();

    // Pilih Ekskul (Basket)
    await tester.tap(find.text('1. Basket'));
    await tester.pumpAndSettle();

    // Scroll sampai tombol submit terlihat jika perlu
    await tester.ensureVisible(find.text('Simpan Pendaftaran'));
    await tester.tap(find.text('Simpan Pendaftaran'));
    await tester.pumpAndSettle();

    // Pastikan data berhasil disimpan dan card hasil muncul
    expect(find.text('Pendaftaran berhasil disimpan!'), findsOneWidget);
    expect(find.text('Hasil Pendaftaran Ekskul'), findsWidgets);
    expect(find.text('Budi Santoso'), findsOneWidget);
    expect(find.text('123456'), findsOneWidget);
    expect(find.text('Kelas X RPL 1'), findsWidgets);
    expect(find.text('08123456789'), findsOneWidget);
  });
}
