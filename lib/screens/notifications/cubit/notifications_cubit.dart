// ignore_for_file: avoid_print

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/services/database/notification_service.dart';

import '../../../core/configs/assets/app_format.dart';
import '../../../services/models/notification.dart';
import '../../../services/models/product.dart';

part 'notifications_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this._authenticationRepository) : super(const NotificationState(status: NotifStatus.noNotif));
  final AuthenticationRepository _authenticationRepository;
  final notificationService = NotificationService();

  // Create new notification

  void alertAboutReport(String reportMessage, Product product) {
    notificationService.addUserNotification({
      'category' : 'report',
      'name' : 'NOTICE',
      'description' : 'Your product ${product.name} has received a report: $reportMessage',
      'user_id' : product.userId,
      'timestamp' : AppFormat.euDate.format(DateTime.now()),
    });                                                                                          
  }

  void alertAboutNewOrder(String orderId) {
    notificationService.addUserNotification({
      'category' : 'new order',
      'name' : 'New Order',
      'user_id' : _authenticationRepository.currentUser.id,
      'description' : 'You have just made an order! Order ID: $orderId',
      'timestamp' : AppFormat.euDate.format(DateTime.now()),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getGeneralNotifications() {
    try {
      return notificationService.getNotifications();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getImportantNotifications() {
    try {
      return notificationService.getIndividualNotifications(_authenticationRepository.currentUser.id);
    } catch (e) {
      print(e);
      return null;
    }
  }
                        
}