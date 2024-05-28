class Dengue {
  final int casos;

  const Dengue({
    required this.casos,
  });

  factory Dengue.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'casos': int casos,
      } =>
        Dengue(
          casos: casos,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}