part of 'provider_detail_bloc.dart';

/// Events for [ProviderDetailBloc].
sealed class ProviderDetailEvent extends Equatable {
  const ProviderDetailEvent();

  @override
  List<Object?> get props => [];
}

/// Fetch a provider detail by ID.
final class ProviderDetailFetched extends ProviderDetailEvent {
  const ProviderDetailFetched(this.id);
  final String id;

  @override
  List<Object?> get props => [id];
}
