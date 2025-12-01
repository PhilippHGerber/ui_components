import 'package:jaspr/jaspr.dart';

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_events.dart';
import 'carousel_style.dart';

/// A "smart" container for displaying a scrollable list of items, such as images or cards.
///
/// The `Carousel` component automatically applies the necessary `carousel-item` class
/// to its direct `UiComponent` children, simplifying the creation of carousels.
/// This creates a seamless, scrollable group.
///
/// For primitive components like Jaspr's `img()`, you must manually add the
/// `carousel-item` class via the `classes` property.
///
/// Example:
/// ```dart
/// Carousel(
///   style: [Carousel.center, Effects.roundedBox, Size.w96],
///   [
///     // A UiComponent child, `carousel-item` is added automatically.
///     Container([ img(src: '...') ]),
///
///     // A primitive component, `carousel-item` must be added manually.
///     img(src: '...', classes: 'carousel-item'),
///   ],
/// )
/// ```
class Carousel extends UiComponent {
  /// Creates a "smart" Carousel container component.
  ///
  /// - [children]: A list of components to be displayed in the carousel. The `Carousel`
  ///   component will automatically apply the `carousel-item` class to any direct
  ///   child that is a `deepyr` `UiComponent`.
  /// - [tag]: The HTML tag for the root element, defaults to 'div'.
  /// - [style]: A list of [CarouselStyling] instances to control alignment and direction
  ///   (e.g., `Carousel.center`, `Carousel.vertical`).
  /// - Other parameters are inherited from [UiComponent].
  const Carousel(
    super.children, {
    super.tag = 'div',
    List<CarouselStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'carousel';

  @override
  Component build(BuildContext context) {
    // Smart container logic: Iterate through children and apply the 'carousel-item'
    // class to any direct child that is a UiComponent.
    final processedChildren = children?.map((child) {
      if (child is UiComponent) {
        // Use copyWith to add the class without overwriting existing classes.
        return child.copyWith(classes: 'carousel-item');
      }
      // For primitive components (like img, div), the user is responsible
      // for adding the 'carousel-item' class manually.
      return child;
    }).toList();

    // Use the standard UiComponent build method but with the processed children.
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: this.css,
      attributes: componentAttributes,
      events: eventMap,
      children: processedChildren ?? (child != null ? [child!] : null),
    );
  }

  @override
  Carousel copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Carousel(
      children,
      tag: tag,
      style: style as List<CarouselStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      child: child,
      key: key ?? this.key,
    );
  }

  // --- Static Carousel Style Modifiers ---

  /// Snaps carousel items to the start (default). `carousel-start`
  static const CarouselStyle start = CarouselStyle('carousel-start', type: StyleType.layout);

  /// Snaps carousel items to the center. `carousel-center`
  static const CarouselStyle center = CarouselStyle('carousel-center', type: StyleType.layout);

  /// Snaps carousel items to the end. `carousel-end`
  static const CarouselStyle end = CarouselStyle('carousel-end', type: StyleType.layout);

  /// Arranges items in a vertical layout. `carousel-vertical`
  /// Requires a fixed height on the container (e.g., `Size.h96`).
  static const CarouselStyle vertical = CarouselStyle('carousel-vertical', type: StyleType.layout);

  /// Arranges items in a horizontal layout (default). `carousel-horizontal`
  static const CarouselStyle horizontal = CarouselStyle(
    'carousel-horizontal',
    type: StyleType.layout,
  );
}
