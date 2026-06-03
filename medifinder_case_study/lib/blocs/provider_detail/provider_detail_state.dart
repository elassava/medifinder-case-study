part of 'provider_detail_bloc.dart';

/// Status of the provider detail fetching.
enum ProviderDetailStatus { initial, loading, success, failure }

/// State for [ProviderDetailBloc].
class ProviderDetailState extends Equatable {
  const ProviderDetailState({
    this.status = ProviderDetailStatus.initial,
    this.providerId,
    this.provider,
    this.errorMessage,
  });

  final ProviderDetailStatus status;
  final String? providerId;
  final ProviderModel? provider;
  final String? errorMessage;

  ProviderDetailState copyWith({
    ProviderDetailStatus? status,
    String? providerId,
    ProviderModel? provider,
    String? errorMessage,
  }) =>
      ProviderDetailState(
        status: status ?? this.status,
        providerId: providerId ?? this.providerId,
        provider: provider ?? this.provider,
        errorMessage: errorMessage,
      );

  @override
  List<Object?> get props => [status, providerId, provider, errorMessage];
}
