part of 'notifications_cubit.dart';

enum NotifStatus { noNotif, unreadNotif }

final class NotificationState extends Equatable {
  const NotificationState({
    required this.status,
    this.notifications,
  });

  final NotifStatus status;
  final List<AppNotification> ?notifications;

  @override
  List<Object?> get props => [
        status,
      ];

  NotificationState copyWith({
    NotifStatus? status,
    List<AppNotification>? notifications
  }) {
    return NotificationState(
      status: status ?? this.status, 
      notifications: notifications ?? this.notifications,
    );
  }
}