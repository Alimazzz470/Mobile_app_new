import 'package:equatable/equatable.dart';

class Role extends Equatable {
  final String id;
  final String name;

  const Role({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}
