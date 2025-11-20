import 'package:equatable/equatable.dart';

class Meta extends Equatable {
  final int currentPage;
  final bool isLastPage;
  final bool isFirstPage;
  final int? nextPage;
  final int? previousPage;
  final int pageCount;

  const Meta({
    required this.currentPage,
    required this.isLastPage,
    required this.isFirstPage,
    required this.nextPage,
    required this.previousPage,
    required this.pageCount,
  });

  const Meta.empty()
      : currentPage = 1,
        isLastPage = true,
        isFirstPage = true,
        nextPage = null,
        previousPage = null,
        pageCount = 1;

  @override
  List<Object> get props {
    return [
      currentPage,
      isLastPage,
      isFirstPage,
      nextPage ?? 0,
      previousPage ?? 0,
      pageCount,
    ];
  }
}
