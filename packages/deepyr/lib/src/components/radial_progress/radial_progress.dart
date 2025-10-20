import 'package:jaspr/jaspr.dart';

import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
import 'radial_progress_style.dart';

/// A component to show the progress of a task in a circular "pie chart" style.
///
/// It renders a `<div>` and uses CSS variables to control the presentation.
/// The component is purely presentational; its `value` must be updated by a
/// parent component to show changes in progress.
///
/// Example of a simple progress display:
/// ```dart
/// RadialProgress(
///   value: 75,
///   style: [TextUtil.primary],
///   showValueText: true,
/// )
/// ```
class RadialProgress extends UiComponent {
  /// Creates a RadialProgress component.
  ///
  /// - [value]: The progress value, from 0 to 100.
  /// - [children]: Optional custom content to display inside the circle. If null
  ///   and `showValueText` is true, the percentage value will be displayed.
  /// - [showValueText]: If true and `children` is null, automatically displays
  ///   the value as a percentage (e.g., "70%"). Defaults to false.
  /// - [size]: A CSS string to set the diameter of the circle (e.g., "12rem").
  ///   Corresponds to the `--size` CSS variable.
  /// - [thickness]: A CSS string to set the thickness of the progress ring
  ///   (e.g., "2px", "1rem"). Corresponds to the `--thickness` CSS variable.
  /// - [style]: A list of [RadialProgressStyling] instances, used for applying
  ///   general utilities like `TextUtil` for color or `BgUtil` for background.
  /// - Other parameters are inherited from [UiComponent].
  const RadialProgress({
    required this.value,
    List<Component>? children,
    this.showValueText = false,
    this.size,
    this.thickness,
    List<RadialProgressStyling>? style,
    super.tag = 'div',
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(children, style: style);

  /// The progress value, from 0 to 100.
  final double value;

  /// If true, displays the value as a percentage inside the circle if no
  /// other children are provided.
  final bool showValueText;

  /// The diameter of the circle (e.g., "12rem"). Sets the `--size` CSS variable.
  final String? size;

  /// The thickness of the progress ring (e.g., "2px"). Sets the `--thickness` CSS variable.
  final String? thickness;

  @override
  String get baseClass => 'radial-progress';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    // Add accessibility attributes for screen readers.
    attributes.addRole('progressbar');
    attributes.addAria('valuenow', value.toInt().toString());
  }

  @override
  RadialProgress copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
    double? value,
    bool? showValueText,
    String? size,
    String? thickness,
  }) {
    return RadialProgress(
      value: value ?? this.value,
      showValueText: showValueText ?? this.showValueText,
      size: size ?? this.size,
      thickness: thickness ?? this.thickness,
      children: children,
      style: style as List<RadialProgressStyling>?,
      tag: tag,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }

  @override
  Component build(BuildContext context) {
    final clampedValue = value.clamp(0, 100);

    // Build the map of CSS variables.
    final rawStyles = <String, String>{
      '--value': clampedValue.toString(),
    };
    if (size != null) {
      rawStyles['--size'] = size!;
    }
    if (thickness != null) {
      rawStyles['--thickness'] = thickness!;
    }

    // Combine dynamically generated styles with any user-provided styles.
    final combinedStyles = Styles.combine([
      if (this.css != null) this.css!,
      Styles(raw: rawStyles),
    ]);

    // Determine the children to render.
    var finalChildren = children;
    if (finalChildren == null && showValueText) {
      finalChildren = [text('${clampedValue.toInt()}%')];
    }

    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: combinedStyles,
      attributes: componentAttributes,
      events: this.events,
      children: finalChildren,
    );
  }
}
