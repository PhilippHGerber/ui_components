import 'package:jaspr/jaspr.dart' show Key, Styles;

import '../base/styling.dart';
import '../base/ui_component.dart';
import '../base/ui_component_attributes.dart';

/// Represents an HTML `<figure>` element, typically used to encapsulate media
/// like images, diagrams, or code snippets, optionally with a caption.
///
/// Styling is achieved by passing general utility classes (instances of [Styling])
/// via the `modifiers` property.
class Figure extends UiComponent {
  /// Creates a Figure component.
  ///
  /// - [children] or [child]: The content of the figure, usually an `img` tag and
  ///   optionally a `Figcaption` (not yet defined in this snippet).
  /// - [tag]: The HTML tag to use, defaults to 'figure'.
  /// - [styles]: A list of general [Styling] instances for styling.
  /// - Other parameters are inherited from [UiComponent].
  const Figure(
    super.children, {
    super.tag = 'figure',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.child,
    super.key,
  });

  @override
  String get baseClass => '';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
  }

  @override
  Figure copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return Figure(
      children,
      tag: tag,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      child: child,
      key: key ?? this.key,
    );
  }

  // Previously, Figure had static padding modifiers like `Figure.px`.
  // These have been removed in favor of using general Spacing utilities, e.g.:
  // Figure([img(src:"")], modifiers: [Spacing.px(10), Spacing.pt(10)])
}
