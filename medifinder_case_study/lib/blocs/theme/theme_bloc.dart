import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// BLoC managing app-wide theme mode (light/dark).
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState()) {
    on<ThemeToggled>(_onToggled);
  }

  void _onToggled(ThemeToggled event, Emitter<ThemeState> emit) {
    final newMode =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(ThemeState(themeMode: newMode));
  }
}

/// Events for [ThemeBloc].
sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

/// Toggle between light and dark mode.
final class ThemeToggled extends ThemeEvent {
  const ThemeToggled();
}

/// State for [ThemeBloc].
class ThemeState extends Equatable {
  const ThemeState({this.themeMode = ThemeMode.light});
  final ThemeMode themeMode;

  /// Whether the current mode is dark.
  bool get isDark => themeMode == ThemeMode.dark;

  @override
  List<Object?> get props => [themeMode];
}
