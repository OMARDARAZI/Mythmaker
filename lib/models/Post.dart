import 'User.dart';

class Post {
  final String id;
  final String title;
  final String story;
  final String image;
  final List<String> likes;
  final List<Comment> comments;
  final User postedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  Post({
    required this.id,
    required this.title,
    required this.story,
    required this.image,
    required this.likes,
    required this.comments,
    required this.postedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      title: json['title'],
      story: json['story'],
      image: json['image'],
      likes: List<String>.from(json['likes'].map((id) => id.toString())),
      comments:
          (json['comments'] as List).map((x) => Comment.fromJson(x)).toList(),
      postedBy: User.fromJson(json['postedBy']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Comment {
  final String text;
  final User postedBy;
  final DateTime createdAt;
  final String id;

  Comment({
    required this.text,
    required this.postedBy,
    required this.createdAt,
    required this.id,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      text: json['text'],
      postedBy: User.fromJson(json['postedBy']),
      createdAt: DateTime.parse(json['createdAt']),
      id: json['_id'],
    );
  }
}
