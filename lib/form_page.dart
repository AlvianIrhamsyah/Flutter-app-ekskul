import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _namaController = TextEditingController();
  final _nisController = TextEditingController();
  final _noHpController = TextEditingController();

  // State pilihan
  String? _selectedKelas;
  String? _selectedGender;
  final List<String> _selectedEkskul = [];
  bool _genderError = false;
  bool _ekskulError = false;

  // Pilihan Kelas
  final List<String> _daftarKelas = [
    'Kelas X RPL 1',
    'Kelas X RPL 2',
    'Kelas X DKV 1',
    'Kelas XI RPL 1',
    'Kelas XI RPL 2',
    'Kelas XI DKV 1',
    'Kelas XI DKV 2',
    'Kelas XII RPL 1',
    'Kelas XII RPL 2',
    'Kelas XII DKV 1',
  ];

  // Pilihan Ekskul
  final List<Map<String, dynamic>> _daftarEkskul = [
    {'nama': '1. Basket', 'value': 'Basket', 'icon': Icons.sports_basketball, 'color': Colors.orange},
    {'nama': '2. Futsal', 'value': 'Futsal', 'icon': Icons.sports_soccer, 'color': Colors.green},
    {'nama': '3. Pramuka', 'value': 'Pramuka', 'icon': Icons.campaign, 'color': Colors.brown},
    {'nama': '4. Taekwondo', 'value': 'Taekwondo', 'icon': Icons.sports_martial_arts, 'color': Colors.red},
    {'nama': '5. Silat', 'value': 'Silat', 'icon': Icons.sports_martial_arts, 'color': Colors.blue},
  ];

  @override
  void dispose() {
    _namaController.dispose();
    _nisController.dispose();
    _noHpController.dispose();
    super.dispose();
  }

  void _simpanData() {
    final isFormValid = _formKey.currentState!.validate();
    final isGenderValid = _selectedGender != null;
    final isEkskulValid = _selectedEkskul.isNotEmpty;

    setState(() {
      _genderError = !isGenderValid;
      _ekskulError = !isEkskulValid;
    });

    if (!isFormValid || !isGenderValid || !isEkskulValid) return;

    // Navigasi ke halaman hasil dengan membawa data
    Navigator.pushNamed(context, '/hasil', arguments: {
      'nama': _namaController.text.trim(),
      'nis': _nisController.text.trim(),
      'kelas': _selectedKelas ?? '',
      'noHp': _noHpController.text.trim(),
      'gender': _selectedGender ?? '',
      'ekskul': _selectedEkskul.join(', '),
    });
  }

  void _resetData() {
    setState(() {
      _namaController.clear();
      _nisController.clear();
      _noHpController.clear();
      _selectedKelas = null;
      _selectedGender = null;
      _selectedEkskul.clear();
      _genderError = false;
      _ekskulError = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Form Pendaftaran Ekskul',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      const Center(
                        child: Column(
                          children: [
                            Icon(Icons.assignment, size: 50, color: Colors.indigo),
                            SizedBox(height: 8),
                            Text(
                              'Formulir Pendaftaran Siswa',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo),
                            ),
                            SizedBox(height: 4),
                            Text('Silakan lengkapi data di bawah ini', style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Input Nama
                      _buildLabel('Nama'),
                      TextFormField(
                        controller: _namaController,
                        decoration: _inputDecoration('Nama', 'Masukkan nama lengkap', Icons.person),
                        validator: (val) => val == null || val.trim().isEmpty ? 'Nama tidak boleh kosong' : null,
                      ),
                      const SizedBox(height: 16),

                      // Input NIS
                      _buildLabel('NIS'),
                      TextFormField(
                        controller: _nisController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration('NIS', 'Masukkan NIS', Icons.badge),
                        validator: (val) => val == null || val.trim().isEmpty ? 'NIS tidak boleh kosong' : null,
                      ),
                      const SizedBox(height: 16),

                      // Dropdown Kelas
                      _buildLabel('Kelas'),
                      DropdownButtonFormField<String>(
                        value: _selectedKelas,
                        decoration: _inputDecoration('Kelas', 'Pilih Kelas', Icons.school),
                        items: _daftarKelas
                            .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                            .toList(),
                        onChanged: (val) => setState(() => _selectedKelas = val),
                        validator: (val) => val == null || val.isEmpty ? 'Kelas tidak boleh kosong' : null,
                      ),
                      const SizedBox(height: 16),

                      // Input Nomor HP
                      _buildLabel('Nomor HP'),
                      TextFormField(
                        controller: _noHpController,
                        keyboardType: TextInputType.phone,
                        decoration: _inputDecoration('Nomor HP', 'Masukkan nomor HP', Icons.phone),
                        validator: (val) => val == null || val.trim().isEmpty ? 'Nomor HP tidak boleh kosong' : null,
                      ),
                      const SizedBox(height: 16),

                      // Jenis Kelamin (RadioListTile)
                      _buildLabel('Jenis Kelamin'),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: _genderError ? Colors.red : Colors.grey.shade300),
                        ),
                        child: Column(
                          children: [
                            RadioListTile<String>(
                              title: const Text('Laki-laki'),
                              secondary: const Icon(Icons.male, color: Colors.blue),
                              value: 'Laki-laki',
                              groupValue: _selectedGender,
                              activeColor: Colors.indigo,
                              onChanged: (val) => setState(() {
                                _selectedGender = val;
                                _genderError = false;
                              }),
                            ),
                            const Divider(height: 1),
                            RadioListTile<String>(
                              title: const Text('Perempuan'),
                              secondary: const Icon(Icons.female, color: Colors.pink),
                              value: 'Perempuan',
                              groupValue: _selectedGender,
                              activeColor: Colors.indigo,
                              onChanged: (val) => setState(() {
                                _selectedGender = val;
                                _genderError = false;
                              }),
                            ),
                          ],
                        ),
                      ),
                      if (_genderError)
                        const Padding(
                          padding: EdgeInsets.only(left: 4, top: 4),
                          child: Text(
                            'Silakan pilih jenis kelamin!',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                      const SizedBox(height: 16),

                      // Pilihan Ekskul (CheckboxListTile)
                      _buildLabel('Jenis Ekskul yang Dipilih'),
                      const Text(
                        '*Bisa memilih lebih dari satu',
                        style: TextStyle(fontSize: 12, color: Colors.black54, fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 8),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: _ekskulError ? Colors.red : Colors.grey.shade300),
                        ),
                        child: Column(
                          children: _daftarEkskul.asMap().entries.map((entry) {
                            final item = entry.value;
                            final isLast = entry.key == _daftarEkskul.length - 1;
                            final isSelected = _selectedEkskul.contains(item['value']);

                            return Column(
                              children: [
                                CheckboxListTile(
                                  title: Text(item['nama'] as String, style: const TextStyle(fontWeight: FontWeight.w500)),
                                  secondary: CircleAvatar(
                                    backgroundColor: (item['color'] as Color).withOpacity(0.15),
                                    child: Icon(item['icon'] as IconData, color: item['color'] as Color, size: 20),
                                  ),
                                  value: isSelected,
                                  activeColor: Colors.indigo,
                                  onChanged: (val) {
                                    setState(() {
                                      if (val == true) {
                                        _selectedEkskul.add(item['value'] as String);
                                      } else {
                                        _selectedEkskul.remove(item['value'] as String);
                                      }
                                      _ekskulError = _selectedEkskul.isEmpty;
                                    });
                                  },
                                ),
                                if (!isLast) const Divider(height: 1),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                      if (_ekskulError)
                        const Padding(
                          padding: EdgeInsets.only(left: 4, top: 4),
                          child: Text(
                            'Silakan pilih minimal satu jenis ekskul!',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                      const SizedBox(height: 24),

                      // Tombol Simpan
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: _simpanData,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          icon: const Icon(Icons.save),
                          label: const Text('Simpan Pendaftaran', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Tombol Reset
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton.icon(
                          onPressed: _resetData,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reset Form', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
    );
  }

  InputDecoration _inputDecoration(String label, String hint, IconData icon) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.indigo),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}