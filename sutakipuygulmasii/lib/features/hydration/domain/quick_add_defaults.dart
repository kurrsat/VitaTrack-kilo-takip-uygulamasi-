class QuickAddDefaults {
  const QuickAddDefaults({
    required this.waterMl,
    required this.teaMl,
    required this.coffeeMl,
  });

  final int waterMl;
  final int teaMl;
  final int coffeeMl;

  static const QuickAddDefaults standard = QuickAddDefaults(
    waterMl: 200,
    teaMl: 200,
    coffeeMl: 150,
  );

  QuickAddDefaults copyWith({
    int? waterMl,
    int? teaMl,
    int? coffeeMl,
  }) {
    return QuickAddDefaults(
      waterMl: waterMl ?? this.waterMl,
      teaMl: teaMl ?? this.teaMl,
      coffeeMl: coffeeMl ?? this.coffeeMl,
    );
  }

  Map<String, dynamic> toJson() => {
        'waterMl': waterMl,
        'teaMl': teaMl,
        'coffeeMl': coffeeMl,
      };

  factory QuickAddDefaults.fromJson(Map<String, dynamic> json) {
    return QuickAddDefaults(
      waterMl: _readInt(json, 'waterMl', standard.waterMl),
      teaMl: _readInt(json, 'teaMl', standard.teaMl),
      coffeeMl: _readInt(json, 'coffeeMl', standard.coffeeMl),
    );
  }

  static int _readInt(Map<String, dynamic> json, String key, int fallback) {
    final value = json[key];
    if (value is int) return value;
    if (value is num) return value.round();
    return fallback;
  }
}
