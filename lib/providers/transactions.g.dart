// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recentTransactionsHash() =>
    r'12b66debfb4a301a733b30756c4415d57322c4e3';

/// See also [recentTransactions].
@ProviderFor(recentTransactions)
final recentTransactionsProvider =
    AutoDisposeFutureProvider<List<Transaction>>.internal(
  recentTransactions,
  name: r'recentTransactionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recentTransactionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RecentTransactionsRef = AutoDisposeFutureProviderRef<List<Transaction>>;
String _$groupedTransactionsHash() =>
    r'a310ccd625ac3ba00fb4aaf1114102e22b7fa287';

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
    r'f64b64266bf9d6261efa281751df7df6307c7d36';

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
    r'd775f4b744d19a814c63352df58f710d52ff72e2';

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
