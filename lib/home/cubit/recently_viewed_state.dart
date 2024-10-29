part of 'recently_viewed_cubit.dart';

final class RecentlyViewedState extends Equatable {
  const RecentlyViewedState({
    required this.recentlyViewedProducts,
  });

  final List<String> recentlyViewedProducts;

  @override
  List<Object?> get props => [
        recentlyViewedProducts,
      ];

  RecentlyViewedState copyWith({
    List<String>? recentlyViewedProducts,
  }) {
    return RecentlyViewedState(
      recentlyViewedProducts: recentlyViewedProducts ?? this.recentlyViewedProducts,
    );
  }
}