import 'package:equatable/equatable.dart';

class Meta {
  late final int currentPage;
  late final bool isLastPage;
  late final bool isFirstPage;
  late final int? nextPage;
  late final int? previousPage;
  late final int pageCount;

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json["meta"]["currentPage"];
    isLastPage = json["meta"]["isLastPage"];
    isFirstPage = json["meta"]["isFirstPage"];
    nextPage = json["meta"]["nextPage"];
    previousPage = json["meta"]["previousPage"];
    pageCount = json["meta"]["pageCount"];
  }
}

abstract class PaginatedResponse<T> extends Meta {
  PaginatedResponse({
    required Map<String, dynamic> json,
    String nodeKey = "data",
  })  : assert(json.containsKey(nodeKey)),
        super.fromJson(json) {
    data = json[nodeKey] != null
        ? (json[nodeKey] as List<dynamic>).map((e) => parserFunction(e)).toList(growable: false)
        : <T>[];
  }

  /// A generic list of result nodes that has been parsed from the parser func.
  late final List<T> data;

  /// Use a parsing factory method or a subclass parser factory. This will be
  /// the data parser for each individual node
  T parserFunction(Map<String, dynamic> json);
}

abstract class PagingSearchProps {
  const PagingSearchProps({
    this.page = 1,
    this.limit = 10,
  });

  /// Return the first n elements of the list
  final int limit;

  /// Fetch the selected page of the list
  final int page;

  /// Other query params unique to endpoint. These may contain filter, sort etc.
  Map<String, dynamic> get queryParams;

  Map<String, dynamic> get finalQueryParams => {
        "page": page,
        "limit": limit,
        ...queryParams,
      };
}

///
/// Result DTO to be used on the UI
///
class ResponseDTO<T> extends Equatable {
  final List<T> data;
  final bool hasNextPage;
  final int totalPages;

  const ResponseDTO({
    required this.data,
    required this.hasNextPage,
    required this.totalPages,
  });

  ResponseDTO<T> copyWith({
    List<T>? data,
    bool? hasNextPage,
    int? totalPages,
  }) {
    return ResponseDTO(
      data: data ?? this.data,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  factory ResponseDTO.empty() => const ResponseDTO(data: [], totalPages: 0, hasNextPage: false);

  @override
  List<Object> get props => [data, hasNextPage, totalPages];
}
