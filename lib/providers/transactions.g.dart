// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$groupedTransactionsHash() =>
    r'95589bcb707fc89e3af4b51a839de004bd95eada';

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

/// See also [groupedTransactions].
@ProviderFor(groupedTransactions)
const groupedTransactionsProvider = GroupedTransactionsFamily();

/// See also [groupedTransactions].
class GroupedTransactionsFamily
    extends Family<AsyncValue<Map<String, List<Transaction>>>> {
  /// See also [groupedTransactions].
  const GroupedTransactionsFamily();

  /// See also [groupedTransactions].
  GroupedTransactionsProvider call(
    int daysAgo,
  ) {
    return GroupedTransactionsProvider(
      daysAgo,
    );
  }

  @override
  GroupedTransactionsProvider getProviderOverride(
    covariant GroupedTransactionsProvider provider,
  ) {
    return call(
      provider.daysAgo,
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
  String? get name => r'groupedTransactionsProvider';
}

/// See also [groupedTransactions].
class GroupedTransactionsProvider
    extends AutoDisposeFutureProvider<Map<String, List<Transaction>>> {
  /// See also [groupedTransactions].
  GroupedTransactionsProvider(
    int daysAgo,
  ) : this._internal(
          (ref) => groupedTransactions(
            ref as GroupedTransactionsRef,
            daysAgo,
          ),
          from: groupedTransactionsProvider,
          name: r'groupedTransactionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$groupedTransactionsHash,
          dependencies: GroupedTransactionsFamily._dependencies,
          allTransitiveDependencies:
              GroupedTransactionsFamily._allTransitiveDependencies,
          daysAgo: daysAgo,
        );

  GroupedTransactionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.daysAgo,
  }) : super.internal();

  final int daysAgo;

  @override
  Override overrideWith(
    FutureOr<Map<String, List<Transaction>>> Function(
            GroupedTransactionsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GroupedTransactionsProvider._internal(
        (ref) => create(ref as GroupedTransactionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        daysAgo: daysAgo,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, List<Transaction>>>
      createElement() {
    return _GroupedTransactionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GroupedTransactionsProvider && other.daysAgo == daysAgo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, daysAgo.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GroupedTransactionsRef
    on AutoDisposeFutureProviderRef<Map<String, List<Transaction>>> {
  /// The parameter `daysAgo` of this provider.
  int get daysAgo;
}

class _GroupedTransactionsProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, List<Transaction>>>
    with GroupedTransactionsRef {
  _GroupedTransactionsProviderElement(super.provider);

  @override
  int get daysAgo => (origin as GroupedTransactionsProvider).daysAgo;
}

String _$cumulativeTotalTransactionHash() =>
    r'968d3061e60a1174bf94b2647af9a1b7aea96c61';

/// See also [cumulativeTotalTransaction].
@ProviderFor(cumulativeTotalTransaction)
final cumulativeTotalTransactionProvider =
    AutoDisposeFutureProvider<List<DayTotalTransaction>>.internal(
  cumulativeTotalTransaction,
  name: r'cumulativeTotalTransactionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cumulativeTotalTransactionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CumulativeTotalTransactionRef
    = AutoDisposeFutureProviderRef<List<DayTotalTransaction>>;
String _$transactionsNotifierHash() =>
    r'03c2cb24d209ea042bd9762656a5c698e24727b0';

/// See also [TransactionsNotifier].
@ProviderFor(TransactionsNotifier)
final transactionsNotifierProvider = AutoDisposeAsyncNotifierProvider<
    TransactionsNotifier, List<Transaction>>.internal(
  TransactionsNotifier.new,
  name: r'transactionsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transactionsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TransactionsNotifier = AutoDisposeAsyncNotifier<List<Transaction>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
