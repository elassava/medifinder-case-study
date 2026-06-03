import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/models/provider_model.dart';
import '../../repos/provider_repository.dart';

part 'provider_detail_event.dart';
part 'provider_detail_state.dart';

/// BLoC managing single provider detail fetching.
class ProviderDetailBloc
    extends Bloc<ProviderDetailEvent, ProviderDetailState> {
  ProviderDetailBloc({required this._repository})
      : super(const ProviderDetailState()) {
    on<ProviderDetailFetched>(_onFetched);
  }

  final ProviderRepository _repository;

  /// Fetches a single provider by ID.
  Future<void> _onFetched(
    ProviderDetailFetched event,
    Emitter<ProviderDetailState> emit,
  ) async {
    emit(state.copyWith(
      status: ProviderDetailStatus.loading,
      providerId: event.id,
      errorMessage: null,
    ));
    try {
      final provider = await _repository.getProviderById(event.id);
      emit(state.copyWith(
        status: ProviderDetailStatus.success,
        provider: provider,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProviderDetailStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
