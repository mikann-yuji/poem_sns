import 'package:meta/meta.dart';

@immutable
class SwipePageIndex {
  final int index;

  const SwipePageIndex({
    this.index = 1,
  });

  SwipePageIndex copyWith({
    int? index,
  }) {
    return new SwipePageIndex(
      index: index ?? this.index
    );
  }
}
