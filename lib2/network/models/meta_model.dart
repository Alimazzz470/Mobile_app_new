import '../../core/entities/meta.dart';

class MetaModel extends Meta {
  const MetaModel._({
    required super.currentPage,
    required super.isLastPage,
    required super.isFirstPage,
    required super.nextPage,
    required super.previousPage,
    required super.pageCount,
  });

  factory MetaModel.fromJson(Map<String, dynamic> data) {
    return MetaModel._(
      currentPage: data['currentPage'],
      isLastPage: data['isLastPage'],
      isFirstPage: data['isFirstPage'],
      nextPage: data['nextPage'],
      previousPage: data['previousPage'],
      pageCount: data['pageCount'],
    );
  }
}
