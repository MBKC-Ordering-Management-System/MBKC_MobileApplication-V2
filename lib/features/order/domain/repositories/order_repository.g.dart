// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderRepositoryHash() => r'1a85b28c3469f8935b28842d2e1ab6fbbf255f2a';

/// See also [orderRepository].
@ProviderFor(orderRepository)
final orderRepositoryProvider = Provider<OrderRepository>.internal(
  orderRepository,
  name: r'orderRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$orderRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OrderRepositoryRef = ProviderRef<OrderRepository>;
String _$getOrdersHash() => r'6d3011e2e2af0392c235e326da59b45ede16c1df';

/// See also [getOrders].
@ProviderFor(getOrders)
final getOrdersProvider = AutoDisposeFutureProvider<List<OrderModel>>.internal(
  getOrders,
  name: r'getOrdersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getOrdersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetOrdersRef = AutoDisposeFutureProviderRef<List<OrderModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
