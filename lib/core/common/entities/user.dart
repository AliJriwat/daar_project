class User {
  final String id;
  final String email;
  final String? name;
  final String? avatarUrl;

  const User({
    required this.id,
    required this.email,
    this.name,
    this.avatarUrl,
  });

  // Factory method per creare User da Supabase
  factory User.fromSupabase(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      name: json['name']?.toString(),
      avatarUrl: json['avatar_url']?.toString(),
    );
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name)';
  }
}