import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// BLoC managing app-wide locale (TR/EN).
class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(const LocaleState()) {
    on<LocaleChanged>(_onChanged);
  }

  void _onChanged(LocaleChanged event, Emitter<LocaleState> emit) {
    emit(LocaleState(locale: event.locale));
  }
}

/// Events for [LocaleBloc].
sealed class LocaleEvent extends Equatable {
  const LocaleEvent();

  @override
  List<Object?> get props => [];
}

/// Change the app locale.
final class LocaleChanged extends LocaleEvent {
  const LocaleChanged(this.locale);
  final Locale locale;

  @override
  List<Object?> get props => [locale];
}

/// State for [LocaleBloc].
class LocaleState extends Equatable {
  const LocaleState({this.locale = const Locale('tr')});
  final Locale locale;

  /// Whether the current locale is Turkish.
  bool get isTurkish => locale.languageCode == 'tr';

  /// Whether the current locale is English.
  bool get isEnglish => locale.languageCode == 'en';

  @override
  List<Object?> get props => [locale];
}
