import 'package:jaspr/jaspr.dart';

import '../../base/ui_component.dart';
import 'hover_gallery_style.dart';

/// A container of images where the first is visible by default, and others
/// are revealed sequentially as the user hovers horizontally across the component.
///
/// This component is a pure CSS implementation that relies on a specific
/// DOM structure for its hover effect to function correctly.
///
/// **IMPORTANT USAGE NOTE:**
/// The hover effect is powered by a CSS selector that targets direct `<img>`
/// children of the `.hover-gallery` container. Therefore, you **must** pass
/// primitive `img()` components directly into the `children` list of this component.
/// Do not wrap the `img()` widgets in other components like `Container` or `div`.
///
/// Styling for the gallery frame, such as rounding corners or setting a max-width,
/// should be applied to the `HoverGallery` component itself via its `style` property.
///
/// ### Example:
/// ```dart
/// HoverGallery(
///   [
///     img(src: '/images/hat-1.webp'),
///     img(src: '/images/hat-2.webp'),
///     img(src: '/images/hat-3.webp'),
///   ],
///   // Apply container styles here
///   style: [Size.maxW(60), Effects.roundedBox, Layout.overflowHidden],
/// )
/// ```
class HoverGallery extends UiComponent {
  /// Creates a HoverGallery component.
  ///
  /// - [children]: The content of the gallery. This **must** be a list of primitive `img()` components.
  /// - [tag]: The HTML tag for the root element, defaults to 'figure' for semantic correctness.
  /// - [style]: A list of [HoverGalleryStyling] instances, used for applying
  ///   general utilities like `Size`, `Effects`, or `Layout` to the container.
  const HoverGallery(
    super.children, {
    super.tag = 'figure',
    List<HoverGalleryStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'hover-gallery';

  @override
  Component build(BuildContext context) {
    // This runtime assertion provides clear feedback to the developer if the
    // component is used incorrectly, preventing a common source of errors.
    assert(
      children?.every((child) => child is DomComponent && child.tag == 'img') ?? true,
      'All direct children of HoverGallery must be primitive img() components for the CSS hover effect to work correctly.',
    );
    return super.build(context);
  }

  @override
  HoverGallery copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return HoverGallery(
      children,
      tag: tag,
      style: style as List<HoverGalleryStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      key: key ?? this.key,
    );
  }
}
