class Settings {
  final String userId;
  final String currency;
  final DateTime updatedAt;

  const Settings({
    required this.userId,
    required this.currency,
    required this.updatedAt,
  });

  Settings copyWith({
    String? currency,
    DateTime? updatedAt,
  }) {
    return Settings(
      userId: userId,
      currency: currency ?? this.currency,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}