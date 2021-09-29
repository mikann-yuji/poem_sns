import 'package:meta/meta.dart';

@immutable
class FlashMessageState {
  final bool flag;
  final String content;

  const FlashMessageState({
    this.flag = false,
    this.content = '',
  });

  FlashMessageState copyWith({
    bool? flag,
    String? content,
  }) {
    return new FlashMessageState(
      flag: flag ?? this.flag,
      content: content ?? this.content,
    );
  }
}
