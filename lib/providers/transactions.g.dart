// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$groupedTransactionsHash() =>
    r'd5f6a842fdb211a82ded6f59c259a4b0a2e5f27a';

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
    DateTime startDate,
    DateTime endDate,
  ) {
    return GroupedTransactionsProvider(
      startDate,
      endDate,
    );
  }

  @override
  GroupedTransactionsProvider getProviderOverride(
    covariant GroupedTransactionsProvider provider,
  ) {
    return call(
      provider.startDate,
      provider.endDate,
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
    DateTime startDate,
    DateTime endDate,
  ) : this._internal(
          (ref) => groupedTransactions(
            ref as GroupedTransactionsRef,
            startDate,
            endDate,
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
          startDate: startDate,
          endDate: endDate,
        );

  GroupedTransactionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.startDate,
    required this.endDate,
  }) : super.internal();

  final DateTime startDate;
  final DateTime endDate;

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
        startDate: startDate,
        endDate: endDate,
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
    return other is GroupedTransactionsProvider &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, startDate.hashCode);
    hash = _SystemHash.combine(hash, endDate.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GroupedTransactionsRef
    on AutoDisposeFutureProviderRef<Map<String, List<Transaction>>> {
  /// The parameter `startDate` of this provider.
  DateTime get startDate;

  /// The parameter `endDate` of this provider.
  DateTime get endDate;
}

class _GroupedTransactionsProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, List<Transaction>>>
    with GroupedTransactionsRef {
  _GroupedTransactionsProviderElement(super.provider);

  @override
  DateTime get startDate => (origin as GroupedTransactionsProvider).startDate;
  @override
  DateTime get endDate => (origin as GroupedTransactionsProvider).endDate;
}

String _$cumulativeTotalTransactionHash() =>
    r'f98163bd081f87919f4b8d6ad635f03b136edc8f';

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
