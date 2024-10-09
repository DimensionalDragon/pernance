// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cumulativeTotalTransactionHash() =>
    r'4cbabd0d4a6b741930f3090cd494d5c5ebf6e2ba';

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
