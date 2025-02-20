import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // To load assets
import 'dart:convert';
import 'package:daftar_karyawan/models/karyawan.dart';

void main() {
  runApp(const MyApp());
}

class NyApp extends StatelessWidget {
  const NyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const NyHomePage(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const NyApp();
  }
}

class NyHomePage extends StatelessWidget {
  const NyHomePage({super.key});

  // Function to read and parse the JSON data from assets
  Future<List<Karyawan>> readJsonData() async {
    final String response = await rootBundle.loadString("assets/karyawan.json");
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Karyawan.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Daftar Karyawan"),
      ),
      body: FutureBuilder<List<Karyawan>>(
        future: readJsonData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    snapshot.data![index].nama,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Umur: ${snapshot.data![index].umur}"),
                      Text(
                        "Alamat: ${snapshot.data![index].alamat.jalan}, ${snapshot.data![index].alamat.kota}, ${snapshot.data![index].alamat.provinsi}",
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
