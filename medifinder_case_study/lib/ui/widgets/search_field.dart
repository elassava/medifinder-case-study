import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medifinder_case_study/core/extensions/context_extensions.dart';
import 'package:medifinder_case_study/core/theme/app_colors.dart';

/// Pill-shaped search bar with a subtle blue accent border.
class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    required this.onChanged,
    this.initialValue = '',
  });

  final ValueChanged<String> onChanged;
  final String initialValue;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  Timer? _debounce;

  static const _height = 52.0;
  static const _radius = _height / 2;
  static const _borderRadius = BorderRadius.all(Radius.circular(_radius));

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode()..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _submitSearch([String? value]) {
    _debounce?.cancel();
    widget.onChanged(value ?? _controller.text);
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      widget.onChanged(value);
    });
    setState(() {});
  }

  void _onClear() {
    _controller.clear();
    _submitSearch('');
    setState(() {});
  }

  OutlineInputBorder _outlineBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: _borderRadius,
      borderSide: BorderSide(color: color, width: 1.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    final focused = _focusNode.hasFocus;
    final primary = context.colorScheme.primary;
    final hasText = _controller.text.isNotEmpty;
    final borderColor = primary.withValues(alpha: focused ? 0.85 : 0.35);

    return SizedBox(
      height: _height,
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        onChanged: _onChanged,
        onSubmitted: _submitSearch,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.search,
        style: context.textTheme.bodyMedium,
        decoration: InputDecoration(
          filled: true,
          fillColor: context.colorScheme.surface,
          hintText: context.l10n.searchPlaceholder,
          hintStyle: context.textTheme.bodyMedium?.copyWith(
            color: AppColors.textTertiary(context.colorScheme),
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            size: 20,
            color: primary.withValues(alpha: focused ? 0.85 : 0.45),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 44,
            minHeight: _height,
          ),
          suffixIcon: hasText
              ? IconButton(
                  visualDensity: VisualDensity.compact,
                  icon: Icon(
                    Icons.close_rounded,
                    size: 18,
                    color: AppColors.textTertiary(context.colorScheme),
                  ),
                  onPressed: _onClear,
                )
              : null,
          suffixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: _height,
          ),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          enabledBorder: _outlineBorder(borderColor),
          focusedBorder: _outlineBorder(borderColor),
          border: _outlineBorder(borderColor),
        ),
      ),
    );
  }
}
