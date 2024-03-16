class User {
  final String id;
  final String name;
  final String email;
  final DateTime dob;
  final List<String> followers;
  final List<String> following;
  final List<String> posts;
  final int version;
  final String pfp; // Profile picture field

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.dob,
    required this.followers,
    required this.following,
    required this.posts,
    required this.version,
    required this.pfp,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? "",
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      dob: json['dob'] != null ? DateTime.parse(json['dob']) : DateTime.now(), // Handling null with a default value (current time)
      followers: json['followers'] != null ? List<String>.from(json['followers'].map((id) => id.toString())) : [],
      following: json['following'] != null ? List<String>.from(json['following'].map((id) => id.toString())) : [],
      posts: json['posts'] != null ? List<String>.from(json['posts'].map((id) => id.toString())) : [],
      version: json['__v'] ?? 0,
      pfp: json['pfp'] ?? "", // Handle null profile picture
    );
  }
}
