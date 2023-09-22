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
String _$getOrdersHash() => r'e9d778e618d2e62fe4e1a4c9fc1074c4894160e2';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getOrders].
@ProviderFor(getOrders)
const getOrdersProvider = GetOrdersFamily();

/// See also [getOrders].
class GetOrdersFamily extends Family<AsyncValue<List<OrderModel>>> {
  /// See also [getOrders].
  const GetOrdersFamily();

  /// See also [getOrders].
  GetOrdersProvider call(
    PagingModel request,
  ) {
    return GetOrdersProvider(
      request,
    );
  }

  @override
  GetOrdersProvider getProviderOverride(
    covariant GetOrdersProvider provider,
  ) {
    return call(
      provider.request,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getOrdersProvider';
}

/// See also [getOrders].
class GetOrdersProvider extends AutoDisposeFutureProvider<List<OrderModel>> {
  /// See also [getOrders].
  GetOrdersProvider(
    PagingModel request,
  ) : this._internal(
          (ref) => getOrders(
            ref as GetOrdersRef,
            request,
          ),
          from: getOrdersProvider,
          name: r'getOrdersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getOrdersHash,
          dependencies: GetOrdersFamily._dependencies,
          allTransitiveDependencies: GetOrdersFamily._allTransitiveDependencies,
          request: request,
        );

  GetOrdersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.request,
  }) : super.internal();

  final PagingModel request;

  @override
  Override overrideWith(
    FutureOr<List<OrderModel>> Function(GetOrdersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetOrdersProvider._internal(
        (ref) => create(ref as GetOrdersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        request: request,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<OrderModel>> createElement() {
    return _GetOrdersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetOrdersProvider && other.request == request;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, request.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetOrdersRef on AutoDisposeFutureProviderRef<List<OrderModel>> {
  /// The parameter `request` of this provider.
  PagingModel get request;
}

class _GetOrdersProviderElement
    extends AutoDisposeFutureProviderElement<List<OrderModel>>
    with GetOrdersRef {
  _GetOrdersProviderElement(super.provider);

  @override
  PagingModel get request => (origin as GetOrdersProvider).request;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
