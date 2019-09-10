import 'package:flutter/material.dart';

/// A convenience widget that wraps a [DropdownButton] in a [FormField].
class CustomDropdownButtonFormField<T> extends FormField<T> {
  /// Creates a [DropdownButton] widget wrapped in an [InputDecorator] and
  /// [FormField].
  ///
  /// The [DropdownButton] [items] parameters must not be null.
  CustomDropdownButtonFormField({
    Key key,
    this.value,
    @required this.items,
    this.hint,
    this.onChanged,
    this.decoration = const InputDecoration(),
    FormFieldSetter<T> onSaved,
    FormFieldValidator<T> validator,
    bool autovalidate = false,
    this.disabledHint,
    this.elevation = 8,
    this.style,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24.0,
    this.isDense = false,
    this.isExpanded = false,
  })  : assert(decoration != null),
        super(
            key: key,
            onSaved: onSaved,
            initialValue: value,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<T> field) {
              final InputDecoration effectiveDecoration = decoration
                  .applyDefaults(Theme.of(field.context).inputDecorationTheme);
              return InputDecorator(
                decoration:
                    effectiveDecoration.copyWith(errorText: field.errorText),
                isEmpty: value == null,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<T>(
                    value: value,
                    items: items,
                    hint: hint,
                    onChanged: field.didChange,
                    disabledHint: disabledHint,
                    elevation: elevation,
                    style: style,
                    icon: icon,
                    iconDisabledColor: iconDisabledColor,
                    iconEnabledColor: iconEnabledColor,
                    iconSize: iconSize,
                    isDense: isDense,
                    isExpanded: isExpanded,
                  ),
                ),
              );
            });

  /// The list of items the user can select.
  ///
  /// If the [onChanged] callback is null or the list of items is null
  /// then the dropdown button will be disabled, i.e. its arrow will be
  /// displayed in grey and it will not respond to input. A disabled button
  /// will display the [disabledHint] widget if it is non-null.
  final List<DropdownMenuItem<T>> items;

  /// The value of the currently selected [DropdownMenuItem], or null if no
  /// item has been selected. If `value` is null then the menu is popped up as
  /// if the first item were selected.
  final T value;

  /// Displayed if [value] is null.
  final Widget hint;

  /// A message to show when the dropdown is disabled.
  ///
  /// Displayed if [items] or [onChanged] is null.
  final Widget disabledHint;

  /// Called when the user selects an item.
  ///
  /// If the [onChanged] callback is null or the list of [items] is null
  /// then the dropdown button will be disabled, i.e. its arrow will be
  /// displayed in grey and it will not respond to input. A disabled button
  /// will display the [disabledHint] widget if it is non-null.
  final ValueChanged<T> onChanged;

  /// The z-coordinate at which to place the menu when open.
  ///
  /// The following elevations have defined shadows: 1, 2, 3, 4, 6, 8, 9, 12,
  /// 16, and 24. See [kElevationToShadow].
  ///
  /// Defaults to 8, the appropriate elevation for dropdown buttons.
  final int elevation;

  /// The text style to use for text in the dropdown button and the dropdown
  /// menu that appears when you tap the button.
  ///
  /// Defaults to the [TextTheme.subhead] value of the current
  /// [ThemeData.textTheme] of the current [Theme].
  final TextStyle style;

  /// The widget to use for the drop-down button's icon.
  ///
  /// Defaults to an [Icon] with the [Icons.arrow_drop_down] glyph.
  final Widget icon;

  /// The color of any [Icon] descendant of [icon] if this button is disabled,
  /// i.e. if [onChanged] is null.
  ///
  /// Defaults to [Colors.grey.shade400] when the theme's
  /// [ThemeData.brightness] is [Brightness.light] and to
  /// [Colors.white10] when it is [Brightness.dark]
  final Color iconDisabledColor;

  /// The color of any [Icon] descendant of [icon] if this button is enabled,
  /// i.e. if [onChanged] is defined.
  ///
  /// Defaults to [Colors.grey.shade700] when the theme's
  /// [ThemeData.brightness] is [Brightness.light] and to
  /// [Colors.white70] when it is [Brightness.dark]
  final Color iconEnabledColor;

  /// The size to use for the drop-down button's down arrow icon button.
  ///
  /// Defaults to 24.0.
  final double iconSize;

  /// Reduce the button's height.
  ///
  /// By default this button's height is the same as its menu items' heights.
  /// If isDense is true, the button's height is reduced by about half. This
  /// can be useful when the button is embedded in a container that adds
  /// its own decorations, like [InputDecorator].
  final bool isDense;

  /// Set the dropdown's inner contents to horizontally fill its parent.
  ///
  /// By default this button's inner width is the minimum size of its contents.
  /// If [isExpanded] is true, the inner width is expanded to fill its
  /// surrounding container.
  final bool isExpanded;

  /// The decoration to show around the dropdown button form field.
  ///
  /// By default, draws a horizontal line under the dropdown button field but can be
  /// configured to show an icon, label, hint text, and error text.
  ///
  /// Specify null to remove the decoration entirely (including the
  /// extra padding introduced by the decoration to save space for the labels).
  final InputDecoration decoration;

  @override
  FormFieldState<T> createState() => _CustomDropdownButtonFormFieldState<T>();
}

class _CustomDropdownButtonFormFieldState<T> extends FormFieldState<T> {
  @override
  CustomDropdownButtonFormField<T> get widget => super.widget;

  @override
  void didChange(T value) {
    super.didChange(value);
    if (widget.onChanged != null) {
      widget.onChanged(value);
    }
  }
}
