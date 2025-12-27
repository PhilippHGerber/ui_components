import 'package:jaspr/dom.dart' show Styles;
import 'package:jaspr/jaspr.dart' show Key;

import '../../base/ui_component.dart';
import '../../base/ui_events.dart';
import '../label/label.dart' show Label;
import 'form_label_style.dart';

/// A component that renders an HTML `<p>` or `<span>` element with the
/// 'label' base class, used for descriptive text within form containers.
///
/// Per DaisyUI patterns, this component is typically used inside a [Label]
/// container (as a `<span>`) to provide descriptive text alongside an input,
/// or inside a `Fieldset` (as a `<p>`) to provide a description. It creates
/// a type-safe abstraction for the common `... class="label"` pattern.
class FormLabel extends UiComponent {
  /// Creates a FormLabel component.
  ///
  /// - [children] or [child]: The content of the label, typically text.
  /// - [tag]: The HTML tag for the root element. Defaults to 'p', which is
  ///   semantically appropriate for descriptions within a `Fieldset`. Can be
  ///   changed to 'span' for inline usage within a `Label`.
  /// - [style]: A list of [FormLabelStyling] (the interface) instances for styling.
  /// - Other parameters are inherited from [UiComponent].
  const FormLabel(
    super.children, {
    List<FormLabelStyling>? style,
    super.tag = 'p',
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'label'; // The DaisyUI base class


  @override
  FormLabel copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return FormLabel(
      children,
      style: style as List<FormLabelStyling>?,
      tag: tag,
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
