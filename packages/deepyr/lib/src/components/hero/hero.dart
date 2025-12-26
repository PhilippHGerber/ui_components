import 'package:jaspr/dom.dart' show Styles;
import 'package:jaspr/jaspr.dart' show Key;

import '../../base/ui_component.dart';
import '../../base/ui_events.dart';
import 'hero_style.dart';

/// A component for displaying a large box, often with a background image and text content.
///
/// The `Hero` component acts as the main container and should contain a [HeroContent]
/// component and, optionally, a [HeroOverlay]. Styling, such as background color,
/// background image, and minimum height, is applied to the `Hero` component itself
/// using general-purpose utilities.
///
/// Example Usage:
/// ```dart
/// Hero(
///   style: [BgUtil.base200, Size.minHScreen],
///   // The `css` property is used for background images.
///   css: Styles.raw({
///     'background-image': 'url(path/to/image.jpg)',
///   }),
///   [
///     HeroOverlay(style: [BgUtil.opacity50]),
///     HeroContent(
///       style: [TextUtil.center, TextUtil.neutralContent],
///       [
///         Container(
///           style: [Size.maxWmd],
///           [
///             h1([text('Hello there')], style: [TextUtil.xl5, FontUtil.bold]),
///             p([text('Provident cupiditate...')], style: [Spacing.py6]),
///             Button([text('Get Started')], style: [Button.primary]),
///           ],
///         ),
///       ],
///     ),
///   ],
/// )
/// ```
class Hero extends UiComponent {
  /// Creates a Hero container component.
  ///
  /// - [children]: The content of the hero, which must include a [HeroContent]
  ///   component and can optionally include a [HeroOverlay].
  /// - [tag]: The HTML tag for the root element, defaults to 'div'.
  /// - [style]: A list of [HeroStyling] instances. Use this to apply general
  ///   utilities like `BgUtil.base200` or `Size.minHScreen`.
  /// - [css]: The `css` property should be used to apply background images.
  /// - Other parameters are inherited from [UiComponent].
  const Hero(
    super.children, {
    super.tag = 'div',
    List<HeroStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'hero';

  @override
  Hero copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Hero(
      children,
      tag: tag,
      style: style as List<HeroStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }
}

/// The content container within a [Hero] component.
///
/// This component is essential for correctly padding and centering the content
/// inside the `Hero`. All text, images, and buttons should be placed inside this
/// component.
class HeroContent extends UiComponent {
  /// Creates a HeroContent component.
  ///
  /// - [children]: The actual content to be displayed, such as text, images,
  ///   or other components.
  /// - [tag]: The HTML tag for the root element, defaults to 'div'.
  /// - [style]: A list of general utilities for layout and typography,
  ///   like `Layout.flexCol`, `TextUtil.center`, etc.
  /// - Other parameters are inherited from [UiComponent].
  const HeroContent(
    super.children, {
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  }) : super();

  @override
  String get baseClass => 'hero-content';

  @override
  HeroContent copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return HeroContent(
      children,
      tag: tag,
      style: style,
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

/// An overlay component used within a [Hero] to add a colored layer over the
/// background, typically to improve text readability on a background image.
///
/// This component renders a `<div>` with the `hero-overlay` class and is often
/// styled with a background color and opacity.
class HeroOverlay extends UiComponent {
  /// Creates a HeroOverlay component.
  ///
  /// - [tag]: The HTML tag for the root element, defaults to 'div'.
  /// - [style]: A list of general utilities. Most commonly used with `BgUtil`
  ///   to set the color and opacity, for example `[BgUtil.opacity50]`.
  /// - Other parameters are inherited from [UiComponent].
  const HeroOverlay({
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null); // Overlays do not have children.

  @override
  String get baseClass => 'hero-overlay';

  @override
  HeroOverlay copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return HeroOverlay(
      tag: tag,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }
}
