part of 'notifications_cubit.dart';

enum NotifStatus { noNotif, unreadNotif }

final class NotificationState extends Equatable {
  const NotificationState({
    required this.status,
  });

  final NotifStatus status;

  @override
  List<Object?> get props => [
        status,
      ];

  NotificationState copyWith({
    NotifStatus? status,
  }) {
    return NotificationState(
      status: status ?? this.status
    );
  }
}