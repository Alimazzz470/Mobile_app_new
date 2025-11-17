import 'package:equatable/equatable.dart';

class Description extends Equatable {
  final String text;
  final Map<String, dynamic> arguments;

  const Description({
    required this.text,
    required this.arguments,
  });

  @override
  List<Object?> get props => [
        text,
        arguments,
      ];
}
