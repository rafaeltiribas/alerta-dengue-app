class Dengue {
  final int casos;
  final double casosEst;
  final int casosNot;
  final int nivel;
  final double tempMin;
  final double tempMax;

  const Dengue({
    required this.casos,
    required this.casosEst,
    required this.casosNot,
    required this.nivel,
    required this.tempMin,
    required this.tempMax,
  });

  factory Dengue.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'casos_est': double casosEst,
        'casos': int casos,
        'notif_accum_year': int casosNot,
        'nivel': int nivel,
        'tempmin': double tempMin,
        'tempmax': double tempMax,
      } =>
        Dengue(
          casos: casos,
          casosEst: casosEst,
          casosNot: casosNot,
          nivel: nivel,
          tempMin: tempMin,
          tempMax: tempMax,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}