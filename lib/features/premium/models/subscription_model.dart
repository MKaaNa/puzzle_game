import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_model.freezed.dart';
part 'subscription_model.g.dart';

enum SubscriptionType {
  monthly,
  quarterly,
  yearly,
}

enum SubscriptionStatus {
  active,
  expired,
  cancelled,
  trial,
}

@freezed
class Subscription with _$Subscription {
  const factory Subscription({
    required String id,
    required SubscriptionType type,
    required SubscriptionStatus status,
    required DateTime startDate,
    required DateTime endDate,
    required double price,
    required List<String> features,
  }) = _Subscription;

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);

  factory Subscription.trial() {
    return Subscription(
      id: 'trial',
      type: SubscriptionType.monthly,
      status: SubscriptionStatus.trial,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 7)),
      price: 0,
      features: [
        'unlimited_hints',
        'all_themes',
        'no_ads',
        'detailed_stats',
      ],
    );
  }
}

extension SubscriptionTypeExtension on SubscriptionType {
  String get label {
    switch (this) {
      case SubscriptionType.monthly:
        return 'Monthly';
      case SubscriptionType.quarterly:
        return 'Quarterly';
      case SubscriptionType.yearly:
        return 'Yearly';
    }
  }

  double get price {
    switch (this) {
      case SubscriptionType.monthly:
        return 4.99;
      case SubscriptionType.quarterly:
        return 12.99;
      case SubscriptionType.yearly:
        return 39.99;
    }
  }

  String get description {
    switch (this) {
      case SubscriptionType.monthly:
        return 'Billed monthly';
      case SubscriptionType.quarterly:
        return 'Save 13% - Billed every 3 months';
      case SubscriptionType.yearly:
        return 'Save 33% - Billed annually';
    }
  }
} 