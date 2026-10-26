import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'game_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FreeToGame API UTS',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const GameListPage(),
    );
  }
}

class GameListPage extends StatefulWidget {
  const GameListPage({super.key});

  @override
  State<GameListPage> createState() => _GameListPageState();
}

class _GameListPageState extends State<GameListPage> {
  late Future<List<Game>> futureGames;

  @override
  void initState() {
    super.initState();
    futureGames = fetchGames();
  }

  // Fungsi HTTP Request GET dari API
  Future<List<Game>> fetchGames() async {
    final response = await http.get(
      Uri.parse('https://www.freetogame.com/api/games?platform=pc'),
    );

    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      return body.map((item) => Game.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat data game dari server');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Game PC Gratis (FreeToGame)'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      // Penerapan FutureBuilder untuk Asynchronous Programming
      body: FutureBuilder<List<Game>>(
        future: futureGames,
        builder: (context, snapshot) {
          // Kondisi 1: Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // Kondisi 2: Error
          else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Terjadi Kesalahan:\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }
          // Kondisi 3: Success tapi data kosong
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Tidak ada data game ditemukan.'),
            );
          }
          // Kondisi 4: Success dan data siap disajikan
          else {
            List<Game> games = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: games.length,
              itemBuilder: (context, index) {
                Game game = games[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        game.thumbnail,
                        width: 100,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 50),
                      ),
                    ),
                    title: Text(
                      game.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text('Genre: ${game.genre}'),
                        Text('Platform: ${game.platform}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}