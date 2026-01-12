import 'package:jaspr/dom.dart' show Styles, img;
import 'package:jaspr/jaspr.dart';

import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
import '../../base/utilities/alignment.dart';
import '../../elements/figure.dart';
import 'card_style.dart';

/// A content container, often used to display information in a structured layout.
/// It typically renders as an HTML `<div>` element with the 'card' base class.
/// The `modifiers` list accepts instances of [CardStyling] (the interface),
/// which includes specific card styles and general utility classes.
class Card extends UiComponent {
  /// Creates a Card component.
  ///
  /// - [children] or [child]: The content, typically [CardBody], [Figure], [CardActions].
  /// - [tag]: The HTML tag, defaults to 'div'.
  /// - [style]: A list of [CardStyling] (the interface) instances.
  /// - [ariaLabel], [ariaLabelledBy]: For accessibility.
  /// - Other parameters from [UiComponent].
  const Card(
    super.children, {
    super.tag = 'div',
    List<CardStyling>? style,
    this.ariaLabel,
    this.ariaLabelledBy,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.onClick,
    super.key,
  }) : super(style: style);

  final String? ariaLabel;
  final String? ariaLabelledBy;

  @override
  String get baseClass => 'card';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);

    if (ariaLabel != null) {
      attributes.addAria('label', ariaLabel!);
    }
    if (ariaLabelledBy != null) {
      attributes.addAria('labelledby', ariaLabelledBy!);
    }
    // Role "group" or "region" could be applicable depending on context,
    // but not applied by default.
  }

  @override
  Card copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Card(
      children,
      tag: tag,
      style: style as List<CardStyling>?,
      ariaLabel: ariaLabel,
      ariaLabelledBy: ariaLabelledBy,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      child: child,
      onClick: onClick,
      key: key ?? this.key,
    );
  }
  // --- Static Card Modifiers ---

  // Style Modifiers
  /// Adds a solid border to the card. `card-border`
  static const CardStyle border = CardStyle(
    'card-border',
    type: StyleType.style,
  );

  /// Adds a dashed border to the card. `card-dash` (New in DaisyUI 5)
  static const CardStyle dash = CardStyle(
    'card-dash',
    type: StyleType.style,
  );

  /// Styles the card for full-width image display, where the image becomes the background. `image-full`
  static const CardStyle imageFull = CardStyle(
    'image-full',
    type: StyleType.style,
  );

  // Modifier
  /// Styles the card for a side-by-side layout, typically image on one side, body on the other. `card-side`
  static const CardStyle side = CardStyle(
    'card-side',
    type: StyleType.layout,
  );

  // Size Modifiers (padding and overall look)
  /// Extra small card size/padding. `card-xs` (New in DaisyUI 5)
  static const CardStyle xs = CardStyle(
    'card-xs',
    type: StyleType.sizing,
  );

  /// Small card size/padding. `card-sm`
  static const CardStyle sm = CardStyle(
    'card-sm',
    type: StyleType.sizing,
  );

  /// Medium card size/padding (default). `card-md`
  static const CardStyle md = CardStyle(
    'card-md',
    type: StyleType.sizing,
  );

  /// Large card size/padding. `card-lg`
  static const CardStyle lg = CardStyle(
    'card-lg',
    type: StyleType.sizing,
  );

  /// Extra large card size/padding. `card-xl` (New in DaisyUI 5)
  static const CardStyle xl = CardStyle(
    'card-xl',
    type: StyleType.sizing,
  );

  // 'glass' was previously a CardStyleModifier. In DaisyUI 5, 'glass' is a general utility
  // that can be applied to any element, including cards. It should be used as a general Effect.
  // Example: Card([...], styles: [Effects.glass])
}

/// The main content area of a [Card].
/// Typically renders as an HTML `<div>` element with the 'card-body' class.
class CardBody extends UiComponent {
  /// Creates a CardBody component.
  ///
  /// styles can include general utilities like `Spacing` or `Typography`.
  const CardBody(
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
  });

  @override
  String get baseClass => 'card-body';


  @override
  CardBody copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return CardBody(
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

/// The title section of a [Card].
/// Typically renders as an HTML `<h2>` element with the 'card-title' class.
class CardTitle extends UiComponent {
  /// Creates a CardTitle component.
  /// Its `id` can be used by the parent [Card]'s `aria-labelledby` attribute.
  /// modifiers can include general utilities like `Typography`.
  const CardTitle(
    super.children, {
    super.tag = 'h2',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  });

  @override
  String get baseClass => 'card-title';


  @override
  CardTitle copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return CardTitle(
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

/// A container for action elements (like buttons) within a [Card].
/// Typically renders as an HTML `<div>` element with the 'card-actions' class.
class CardActions extends UiComponent {
  /// Creates a CardActions component.
  /// [style] can include general utilities like `Layout` for alignment.
  const CardActions(
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
  });

  @override
  String get baseClass => 'card-actions';


  @override
  CardActions copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return CardActions(
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

/// Helper methods for creating common card patterns.
class CardHelper {
  /// Creates a basic card with title, content, and optional actions.
  static Card createBasicCard({
    required String titleText,
    required List<Component> content,
    String? imageUrl, // Optional image
    String? imageAlt,
    List<Component>? actions,
    List<CardStyling>? cardStyles,
    List<Styling>? figureStyles,
    String? cardClasses = 'w-96 bg-base-100 shadow-sm', // Default classes from DaisyUI examples
    String? cardId,
    String? titleId,
    Key? key,
  }) {
    final cardChildren = <Component>[];

    if (imageUrl != null) {
      cardChildren.add(
        Figure([
          img(src: imageUrl, alt: imageAlt ?? 'Card image'),
        ], style: figureStyles),
      );
    }

    final bodyChildren = <Component>[
      CardTitle([Component.text(titleText)], id: titleId),
      ...content,
    ];
    if (actions != null && actions.isNotEmpty) {
      bodyChildren.add(
        CardActions(
          actions,
          style: const [Alignment.justifyEnd],
        ), // Default to justify-end for actions
      );
    }
    cardChildren.add(CardBody(bodyChildren));

    return Card(
      cardChildren,
      id: cardId,
      style: cardStyles,
      classes: cardClasses,
      ariaLabelledBy: titleId,
      key: key,
    );
  }

  // Other helpers can be added if needed, e.g., for specific complex card layouts.
}
