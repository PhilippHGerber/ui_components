import 'package:jaspr/dom.dart' show Styles;
import 'package:jaspr/jaspr.dart' show Key;

import '../../base/ui_component.dart';
import '../../base/ui_events.dart';
import '../form_label/form_label.dart';
import 'fieldset_style.dart';

/// A component that renders an HTML `<fieldset>` element, used as a container
/// for grouping related form controls and labels.
///
/// It provides a clear semantic structure for forms. Styling is achieved by
/// applying general utility classes through its `style` property.
class Fieldset extends UiComponent {
  /// - [tag]: The HTML tag for the root element, defaults to 'fieldset'.
  /// - [style]: A list of [FieldsetStyling] instances for styling.
  /// - Other parameters are inherited from [UiComponent].
  const Fieldset(
    super.children, {
    super.tag = 'fieldset',
    List<FieldsetStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  }) : super(style: style);

  /// Creates a Fieldset component.
  ///
  /// - [children] or [child]: The content of the fieldset, typically including
  ///   a [Legend], one or more form controls (like `Input`), and optionally
  ///   a descriptive [FormLabel].

  @override
  String get baseClass => 'fieldset';

  @override
  Fieldset copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Fieldset(
      children,
      tag: tag,
      style: style as List<FieldsetStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      child: child,
      key: key ?? this.key,
    );
  }
}

/// A component that renders an HTML `<legend>` element to provide a caption
/// or title for its parent [Fieldset].
///
/// It uses the 'fieldset-legend' base class for styling.
class Legend extends UiComponent {
  /// Creates a Legend component.
  ///
  /// - [children] or [child]: The title text for the fieldset.
  /// - [tag]: The HTML tag for the root element, defaults to 'legend'.
  /// - [style]: A list of [LegendStyling] instances for styling.
  /// - Other parameters are inherited from [UiComponent].
  const Legend(
    super.children, {
    super.tag = 'legend',
    List<LegendStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'fieldset-legend';

  @override
  Legend copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Legend(
      children,
      tag: tag,
      style: style as List<LegendStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      child: child,
      key: key ?? this.key,
    );
  }
}
