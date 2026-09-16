import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final List<Map<String, dynamic>> _daftarEkskul = [
    {
      'title': 'Basket',
      'desc': 'Melatih kekuatan serta daya tahan tubuh.',
      'icon': Icons.sports_basketball,
      'color': Colors.orange,
    },
    {
      'title': 'Futsal',
      'desc': 'Melatih Kekuatan,Kerjasama, Serta daya tahan tubuh.',
      'icon': Icons.sports_soccer,
      'color': Colors.green,
    },
    {
      'title': 'Pramuka',
      'desc': 'Melatih kedisiplinan, kemandirian, dan kerja sama.',
      'icon': Icons.campaign,
      'color': Colors.brown,
    },
    {
      'title': 'Taekwondo',
      'desc': 'Melatih bela diri, kekuatan, dan kedisiplinan.',
      'icon': Icons.sports_martial_arts,
      'color': Colors.red,
    },
    {
      'title': 'Silat',
      'desc': 'Melatih bela diri dan melestarikan budaya Indonesia.',
      'icon': Icons.sports_martial_arts,
      'color': Colors.blue,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Pendaftaran Ekskul',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              accountName: Text(
                'Pendaftaran Ekskul',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              accountEmail: Text('Aplikasi Pendaftaran Siswa'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/logo.png'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.indigo),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.assignment, color: Colors.indigo),
              title: const Text('Form Pendaftaran'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/form');
              },
            ),
            ListTile(
              leading: const Icon(Icons.assignment, color: Colors.indigo),
              title: const Text('Hasil Pendaftaran'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/hasil');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Image.asset(
                  'assets/logo.png',
                  width: 95,
                  height: 95,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Selamat Datang',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Aplikasi Pendaftaran Ekstrakurikuler',
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
                const SizedBox(height: 20),
                const Card(
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'Pendaftaran Ekskul',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Silakan pilih ekstrakurikuler sesuai dengan minat dan bakat kamu.',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Macam-Macam Ekstrakurikuler',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 14),
                ..._daftarEkskul.map((ekskul) => Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              (ekskul['color'] as Color).withOpacity(0.15),
                          child: Icon(
                            ekskul['icon'] as IconData,
                            color: ekskul['color'] as Color,
                          ),
                        ),
                        title: Text(
                          ekskul['title'] as String,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(ekskul['desc'] as String),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}