import 'package:flutter/material.dart';
import 'package:medifinder_case_study/core/extensions/context_extensions.dart';

/// Searchable dropdown for filter selections.
class FilterDropdown extends StatefulWidget {
  const FilterDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.hint,
    this.disabledHint,
    this.isDisabled = false,
  });

  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String hint;
  final String? disabledHint;
  final bool isDisabled;

  @override
  State<FilterDropdown> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {
  final _textController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncControllerText();
  }

  @override
  void didUpdateWidget(covariant FilterDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value ||
        oldWidget.isDisabled != widget.isDisabled) {
      _syncControllerText();
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _syncControllerText() {
    final display =
        widget.isDisabled || widget.value == null
            ? ''
            : widget.value!.localizeData(context);
    if (_textController.text != display) {
      _textController.text = display;
    }
  }

  List<DropdownMenuEntry<String>> _buildEntries() {
    return widget.items
        .map(
          (item) => DropdownMenuEntry<String>(
            value: item,
            label: item.localizeData(context),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final entries = _buildEntries();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: context.styles.filterFieldLabel),
        const SizedBox(height: 8),
        LayoutBuilder(
          builder: (context, constraints) {
            final canFilter = !widget.isDisabled;

            return DropdownMenu<String>(
              controller: _textController,
              width: constraints.maxWidth,
              enabled: canFilter,
              enableFilter: canFilter,
              requestFocusOnTap: canFilter,
              hintText: widget.isDisabled && widget.disabledHint != null
                  ? widget.disabledHint
                  : widget.hint,
              leadingIcon: widget.isDisabled
                  ? null
                  : Icon(
                      Icons.search_rounded,
                      size: 20,
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.45,
                      ),
                    ),
              filterCallback: canFilter
                  ? (list, filter) {
                      final query = filter.trim().toLowerCase();
                      if (query.isEmpty) return list;

                      return list
                          .where(
                            (entry) =>
                                entry.label.toLowerCase().contains(query) ||
                                entry.value.toLowerCase().contains(query),
                          )
                          .toList();
                    }
                  : null,
              onSelected: (val) {
                widget.onChanged(val);
                if (val != null) {
                  _textController.text = val.localizeData(context);
                }
              },
              dropdownMenuEntries: entries,
              menuHeight: 320,
              menuStyle: MenuStyle(
                backgroundColor: WidgetStateProperty.all(
                  context.colorScheme.surfaceContainerHighest,
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: context.styles.inputRadius,
                  ),
                ),
                elevation: WidgetStateProperty.all(4),
              ),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: widget.isDisabled
                    ? context.colorScheme.onSurface.withValues(alpha: 0.05)
                    : context.colorScheme.surfaceContainerHighest.withValues(
                        alpha: 0.5,
                      ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: context.styles.inputRadius,
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: context.styles.inputRadius,
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: context.styles.inputRadius,
                  borderSide: BorderSide(
                    color: context.colorScheme.primary,
                    width: 1.5,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
