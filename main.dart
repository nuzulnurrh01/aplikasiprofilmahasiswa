import 'package:flutter/material.dart';
import 'dart:math'; // untuk random gambar

void main() {
  runApp(MyApp());
}

// Stateless widget utama
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ProfilPage(),
    );
  }
}

// Stateful widget untuk interaksi user
class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _jurusanController = TextEditingController();

  String _nama = '';
  String _jurusan = '';
  String _gambar = 'https://via.placeholder.com/150'; // default
  int _gambarSeed = 1; // untuk gambar acak

  // Menampilkan data input user ke UI
  void _tampilkanProfil() {
    setState(() {
      _nama = _namaController.text;
      _jurusan = _jurusanController.text;
      _gambarSeed = Random().nextInt(1000); // gambar baru
      _gambar = 'https://picsum.photos/200?random=$_gambarSeed';
    });

    // Snackbar sebagai feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profil berhasil ditampilkan!')),
    );
  }

  // Mengosongkan input dan tampilan
  void _resetProfil() {
    setState(() {
      _namaController.clear();
      _jurusanController.clear();
      _nama = '';
      _jurusan = '';
      _gambar = 'https://via.placeholder.com/150';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profil berhasil direset!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikasi Profil Mahasiswa'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: isPortrait ? _buildPortrait() : _buildLandscape(),
      ),
    );
  }

  // Tampilan portrait
  Widget _buildPortrait() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _buildContent(),
    );
  }

  // Tampilan landscape
  Widget _buildLandscape() {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildContent(),
          ),
        ),
      ],
    );
  }

  // Komponen utama (form dan output)
  List<Widget> _buildContent() {
    return [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(blurRadius: 6, color: Colors.grey.shade300)],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(_gambar, width: 200, height: 200),
        ),
      ),
      SizedBox(height: 20),
      TextField(
        controller: _namaController,
        decoration: InputDecoration(
          labelText: 'Nama Mahasiswa',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.person),
        ),
      ),
      SizedBox(height: 12),
      TextField(
        controller: _jurusanController,
        decoration: InputDecoration(
          labelText: 'Jurusan',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.school),
        ),
      ),
      SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            onPressed: _tampilkanProfil,
            icon: Icon(Icons.visibility),
            label: Text('Tampilkan'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          ),
          ElevatedButton.icon(
            onPressed: _resetProfil,
            icon: Icon(Icons.refresh),
            label: Text('Reset'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
      SizedBox(height: 24),
      Text(
        _nama.isEmpty ? 'Nama belum diisi' : 'Nama: $_nama',
        style: TextStyle(fontSize: 18),
      ),
      Text(
        _jurusan.isEmpty ? 'Jurusan belum diisi' : 'Jurusan: $_jurusan',
        style: TextStyle(fontSize: 18),
      ),
    ];
  }
}
