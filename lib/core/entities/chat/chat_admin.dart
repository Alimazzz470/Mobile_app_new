import 'package:equatable/equatable.dart';

class ChatAdmin extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String organizationId;
  final String avatar;

  const ChatAdmin({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.organizationId,
    required this.avatar,
  });

  @override
  List<Object?> get props => [id, firstName, lastName, email, avatar, organizationId];
}
