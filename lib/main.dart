import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Set<String> _favoriteMovies = <String>{};

  bool _isFavorite(MovieItem movie) {
    return _favoriteMovies.contains(movie.title);
  }

  void _toggleFavorite(MovieItem movie) {
    setState(() {
      if (_favoriteMovies.contains(movie.title)) {
        _favoriteMovies.remove(movie.title);
      } else {
        _favoriteMovies.add(movie.title);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Movie Catalog',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1F2937)),
        scaffoldBackgroundColor: const Color(0xFFF5F5F7),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Color(0xFFF5F5F7),
          foregroundColor: Color(0xFF222222),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF222222),
          ),
          bodyMedium: TextStyle(
            fontSize: 13,
            color: Color(0xFF7A7A7A),
          ),
        ),
      ),
      home: MovieCatalogPage(
        isFavorite: _isFavorite,
        onToggleFavorite: _toggleFavorite,
      ),
    );
  }
}

class MovieCatalogPage extends StatelessWidget {
  const MovieCatalogPage({
    super.key,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  final bool Function(MovieItem movie) isFavorite;
  final ValueChanged<MovieItem> onToggleFavorite;

  static const List<MovieItem> movies = [
    MovieItem(
      title: 'Inception',
      releaseDate: '2010',
      rating: '8.8',
      genre: 'Sci-Fi, Thriller',
      duration: '2h 28m',
      synopsis:
          'Seorang pencuri memasuki mimpi untuk menanam ide, lalu menghadapi misi yang menguji batas antara realitas dan ilusi.',
      imageUrl:
          'https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_.jpg',
    ),
    MovieItem(
      title: 'Interstellar',
      releaseDate: '2014',
      rating: '8.7',
      genre: 'Sci-Fi, Adventure',
      duration: '2h 49m',
      synopsis:
          'Tim penjelajah menempuh ruang angkasa demi mencari dunia baru saat Bumi mulai tak lagi layak dihuni.',
      imageUrl: 'https://m.media-amazon.com/images/M/MV5BNTE0MmZiNGEtOGY3NS00NDcyLWFiYTItM2IwMWI4YzBkMzk3XkEyXkFqcGc@._V1_FMjpg_UY4134_.jpg',
    ),
    MovieItem(
      title: 'Tenet',
      releaseDate: '2020',
      rating: '7.3',
      genre: 'Action, Sci-Fi',
      duration: '2h 30m',
      synopsis:
          'Seorang agen menjalankan operasi berbahaya untuk mencegah bencana global dengan manipulasi waktu yang terbalik.',
      imageUrl: 'https://m.media-amazon.com/images/M/MV5BMjk2Y2M2MWEtYWQxNS00Y2U0LTlhZWQtN2EwM2Q0ODhmMzQ1XkEyXkFqcGc@._V1_QL75_UX220.5_.jpg',
    ),
    MovieItem(
      title: 'The Dark Knight Rises',
      releaseDate: '2012',
      rating: '8.4',
      genre: 'Action, Crime',
      duration: '2h 44m',
      synopsis:
          'Batman kembali muncul untuk menghadapi ancaman baru yang memaksa Gotham bertahan di titik terendahnya.',
      imageUrl: 'https://m.media-amazon.com/images/M/MV5BMTk4ODQzNDY3Ml5BMl5BanBnXkFtZTcwODA0NTM4Nw@@._V1_SL200_QL1.jpg',
    ),
    MovieItem(
      title: 'Avatar: The Way of Water',
      releaseDate: '2022',
      rating: '7.5',
      genre: 'Adventure, Fantasy',
      duration: '3h 12m',
      synopsis:
          'Keluarga Sully mencari perlindungan baru sambil mempertahankan ikatan mereka dengan alam dan laut Pandora.',
      imageUrl: 'https://m.media-amazon.com/images/M/MV5BNWI0Y2NkOWEtMmM2OC00MjQ3LWI1YzItZGQxYzQ3NzI4NWZmXkEyXkFqcGc@._V1_QL75_UY562_CR6,0,380,562_.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Catalog'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 4),
              Expanded(
                child: ListView.separated(
                  itemCount: movies.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 22),
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    final favorite = isFavorite(movie);
                    return MovieCard(
                      movie: movie,
                      isFavorite: favorite,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MovieDetailPage(
                              movie: movie,
                              isFavorite: isFavorite(movie),
                              onToggleFavorite: onToggleFavorite,
                            ),
                          ),
                        );
                      },
                      onToggleFavorite: () => onToggleFavorite(movie),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieItem {
  const MovieItem({
    required this.title,
    required this.releaseDate,
    required this.rating,
    required this.genre,
    required this.duration,
    required this.synopsis,
    required this.imageUrl,
  });

  final String title;
  final String releaseDate;
  final String rating;
  final String genre;
  final String duration;
  final String synopsis;
  final String imageUrl;
}

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.movie,
    required this.isFavorite,
    required this.onTap,
    required this.onToggleFavorite,
  });

  final MovieItem movie;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F000000),
                blurRadius: 16,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 68,
                height: 92,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E6E9),
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: movie.imageUrl.isEmpty
                    ? const Center(
                        child: Icon(
                          Icons.movie_creation_outlined,
                          color: Colors.white,
                          size: 26,
                        ),
                      )
                    : Image.network(
                        movie.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.broken_image_outlined,
                              color: Colors.white,
                              size: 26,
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            movie.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        IconButton(
                          key: ValueKey('list-favorite-${movie.title}'),
                          onPressed: onToggleFavorite,
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? const Color(0xFFE05D5D) : const Color(0xFF8E8E98),
                          ),
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${movie.releaseDate} • ${movie.genre}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 18,
                          color: Color(0xFFF6C344),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          movie.rating,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: const Color(0xFF444444),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({
    super.key,
    required this.movie,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  final MovieItem movie;
  final bool isFavorite;
  final ValueChanged<MovieItem> onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        actions: [
          IconButton(
            key: ValueKey('detail-favorite-${movie.title}'),
            onPressed: () => onToggleFavorite(movie),
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? const Color(0xFFE05D5D) : null,
            ),
            tooltip: isFavorite ? 'Hapus dari favorite' : 'Tambah ke favorite',
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            Container(
              height: 360,
              decoration: BoxDecoration(
                color: const Color(0xFFE6E6E9),
                borderRadius: BorderRadius.circular(24),
              ),
              clipBehavior: Clip.antiAlias,
              child: movie.imageUrl.isEmpty
                  ? const Center(
                      child: Icon(
                        Icons.movie_creation_outlined,
                        color: Colors.white,
                        size: 60,
                      ),
                    )
                  : Image.network(
                      movie.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: SizedBox(
                            width: 28,
                            height: 28,
                            child: CircularProgressIndicator(strokeWidth: 2.5),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.broken_image_outlined,
                            color: Colors.white,
                            size: 60,
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: Text(
                    movie.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF222222),
                        ),
                  ),
                ),
                const SizedBox(width: 12),
                _InfoChip(label: movie.releaseDate),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _InfoChip(label: movie.genre),
                _InfoChip(label: movie.duration),
                _InfoChip(label: 'Rating ${movie.rating}'),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              'Sinopsis',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              movie.synopsis,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                    color: const Color(0xFF5F5F66),
                  ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              key: ValueKey('detail-favorite-action-${movie.title}'),
              onPressed: () => onToggleFavorite(movie),
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              label: Text(
                isFavorite ? 'Hapus dari favorite' : 'Tambah ke favorite',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFECECF1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF444444),
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
