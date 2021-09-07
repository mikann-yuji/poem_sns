import 'package:meta/meta.dart';

@immutable
class PostContent {
  final String content;

  const PostContent({
    this.content = '',
  });

  PostContent copyWith({
    String? content,
  }) {
    return new PostContent(
      content: content ?? this.content
    );
  }
}
