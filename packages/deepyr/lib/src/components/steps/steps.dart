import 'package:jaspr/jaspr.dart' show Key, Styles;

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import 'steps_style.dart';

/// A container for a list of `Step` components to show progress in a process.
///
/// The `Steps` component renders a `<ul>` element and acts as a container for
/// its `Step` children. It controls the overall layout (horizontal or vertical)
/// and can be made responsive.
///
/// Example Usage:
/// ```dart
/// Steps(
///   style: [Steps.vertical, Steps.horizontal.at(Breakpoint.lg)],
///   [
///     Step([text('Register')], style: [Step.primary]),
///     Step([text('Choose plan')], style: [Step.primary]),
///     Step([text('Purchase')]),
///     Step([text('Receive Product')]),
///   ],
/// )
/// ```
class Steps extends UiComponent {
  /// Creates a container for `Step` components.
  ///
  /// - [children]: The content of the component, which should be a list of [Step] components.
  /// - [tag]: The HTML tag for the root element, defaults to 'ul'.
  /// - [style]: A list of [StepsStyling] instances to control the direction
  ///   (e.g., `Steps.vertical`).
  /// - Other parameters are inherited from [UiComponent].
  const Steps(
    super.children, {
    super.tag = 'ul',
    List<StepsStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'steps';

  @override
  Steps copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return Steps(
      children,
      tag: tag,
      style: style as List<StepsStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      key: key ?? this.key,
    );
  }

  // --- Static Style Modifiers ---

  /// Arranges the steps vertically. `steps-vertical`
  static const StepsStyle vertical = StepsStyle('steps-vertical', type: StyleType.layout);

  /// Arranges the steps horizontally. `steps-horizontal`
  static const StepsStyle horizontal = StepsStyle('steps-horizontal', type: StyleType.layout);
}

/// Represents a single step within a [Steps] container.
///
/// This component renders an `<li>` element. Its appearance can be modified
/// with color styles (e.g., `Step.primary` to mark it as completed) and its
/// counter can be customized with the `dataContent` property or a `StepIcon`.
class Step extends UiComponent {
  /// Creates a single Step component.
  ///
  /// - [children]: The text label for the step.
  /// - [dataContent]: An optional string to display inside the step's marker
  ///   (e.g., '✓', '?', '★'). This overrides the default step number.
  /// - [tag]: The HTML tag for the root element, defaults to 'li'.
  /// - [style]: A list of [StepStyling] instances to control the color/state.
  /// - Other parameters are inherited from [UiComponent].
  const Step(
    super.children, {
    this.dataContent,
    super.tag = 'li',
    List<StepStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.child,
    super.key,
  }) : super(style: style);

  /// A string to be displayed inside the step marker, overriding the default number.
  /// This is rendered as a `data-content` attribute in the HTML.
  final String? dataContent;

  @override
  String get baseClass => 'step';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    if (dataContent != null) {
      attributes.add('data-content', dataContent!);
    }
  }

  @override
  Step copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return Step(
      children,
      dataContent: dataContent,
      tag: tag,
      style: style as List<StepStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      child: child,
      key: key ?? this.key,
    );
  }

  // --- Static Style Modifiers ---

  /// Neutral color for the step. `step-neutral`
  static const StepStyle neutral = StepStyle('step-neutral', type: StyleType.style);

  /// Primary color, often used to indicate a completed or active step. `step-primary`
  static const StepStyle primary = StepStyle('step-primary', type: StyleType.style);

  /// Secondary color for the step. `step-secondary`
  static const StepStyle secondary = StepStyle('step-secondary', type: StyleType.style);

  /// Accent color for the step. `step-accent`
  static const StepStyle accent = StepStyle('step-accent', type: StyleType.style);

  /// Info color for the step. `step-info`
  static const StepStyle info = StepStyle('step-info', type: StyleType.style);

  /// Success color for the step. `step-success`
  static const StepStyle success = StepStyle('step-success', type: StyleType.style);

  /// Warning color for the step. `step-warning`
  static const StepStyle warning = StepStyle('step-warning', type: StyleType.style);

  /// Error color for the step. `step-error`
  static const StepStyle error = StepStyle('step-error', type: StyleType.style);
}

/// A wrapper for a custom icon or element to be placed inside a [Step].
///
/// This component renders a `<span>` with the `step-icon` class. It should be
/// placed as a child of a `Step` component alongside the step's text label.
class StepIcon extends UiComponent {
  /// Creates a container for a custom step icon.
  ///
  /// - [children]: The icon or content to display (e.g., an `Icon` component or text).
  /// - [tag]: The HTML tag for the root element, defaults to 'span'.
  /// - Other parameters are inherited from [UiComponent].
  const StepIcon(
    super.children, {
    super.tag = 'span',
    List<StepIconStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.child,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'step-icon';

  @override
  StepIcon copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return StepIcon(
      children,
      tag: tag,
      style: style as List<StepIconStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      child: child,
      key: key ?? this.key,
    );
  }
}
