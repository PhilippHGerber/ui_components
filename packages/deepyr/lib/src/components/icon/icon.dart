import 'package:jaspr/jaspr.dart';

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
import 'icon_style.dart';

// It's good practice to have Typography and Sizing utilities available
// for styling icons (color, font-size).
// import '../../base/utilities/typography.dart'; // For text color, font size
// import '../../base/utilities/sizing.dart';    // For explicit width/height if needed

/// A component for displaying icons, typically from an icon font like Material Symbols.
///
/// It renders an HTML `<span>` element with appropriate classes for the icon font
/// and the specified icon name as its text content.
/// Styling (size, color, fill, weight) can be applied via [IconStyling]s or
/// general utility classes.
class Icon extends UiComponent {
  /// Creates an Icon component.
  ///
  /// - [name]: The name of the icon to display (e.g., "home", "settings" for Material Symbols).
  /// - [tag]: The HTML tag for the root element, defaults to 'span'.
  /// - [ariaLabel]: An accessible name for the icon, especially if it's used without visible text.
  ///   If null and [ariaHidden] is false, the icon [name] might be used by assistive tech,
  ///   which may not be ideal.
  /// - [ariaHidden]: If true, hides the icon from assistive technologies. Set to true
  ///   if the icon is purely decorative or if its meaning is conveyed by adjacent text.
  /// - [style]: A list of [IconStyling] (the interface) instances.
  /// - Other parameters are inherited from [UiComponent].
  Icon(
    this.name, {
    super.tag = 'span',
    this.ariaLabel,
    this.ariaHidden,
    List<IconStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(
         // The icon name is the direct text child of the span
         [Component.text(name)],
         style: style,
       );

  /// The name or identifier of the icon (e.g., "search", "settings").
  final String name;

  /// An accessible label for the icon. If provided, `aria-hidden` should typically be `false` or null.
  final String? ariaLabel;

  /// If true, the icon will be hidden from assistive technologies (`aria-hidden="true"`).
  /// Useful for decorative icons or when an adjacent text label exists.
  final bool? ariaHidden;

  @override
  String get baseClass => 'm-symbols'; // Base class for Material Symbols

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);

    if (ariaHidden ?? false) {
      attributes.addAria('hidden', 'true');
      // If hidden, an aria-label is usually not needed or might even be confusing.
      // However, we don't remove a user-provided ariaLabel if ariaHidden is also true.
    } else if (ariaLabel != null && ariaLabel!.isNotEmpty) {
      attributes.addAria('label', ariaLabel!);
    }
    // If neither ariaHidden=true nor ariaLabel is provided, the icon's text content (its name)
    // might be read by screen readers, which can be a fallback but often not optimal.
    // Consider `role="img"` if the icon conveys non-textual information and has an aria-label.
    // if (ariaLabel != null && ariaLabel!.isNotEmpty && ariaHidden != true) {
    //   attributes.addRole('img');
    // }
  }

  @override
  Icon copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Icon(
      name,
      tag: tag,
      ariaLabel: ariaLabel,
      ariaHidden: ariaHidden,
      style: style as List<IconStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }

  //   @override
  //   Component build(BuildContext context) {
  //     // Combine user-provided CSS with our default reset.
  //     final combinedCss = Styles.combine([
  //       const Styles(raw: {'font-size': 'inherit'}), // Our default reset
  //       ?this.css,
  //     ]);
  //
  //     return Component.element(
  //       tag: tag,
  //       id: id,
  //       classes: combinedClasses,
  //       // Use the combined styles.
  //       styles: combinedCss,
  //       attributes: componentAttributes,
  //       events: this.events,
  //       children: children ?? [?child],
  //     );
  //   }

  // --- Static Icon Modifiers (Type: IconModifier interface, Instantiating: IconStyleModifier) ---
  // These would correspond to specific Material Symbols CSS styling classes or font variation settings
  // if they are controlled by classes rather than font-variation-settings CSS.

  /// Applies a "filled" style to the icon (if supported by the icon set).
  /// For Material Symbols, this is often controlled by `font-variation-settings: 'FILL' 1;`
  /// or by using a "Filled" variant of the font/icon name.
  /// If DaisyUI/Tailwind provide a utility class for this, we use it.
  /// Assuming a class like `.icon-fill` or similar.
  static const IconStyle fill = IconStyle('filled', type: StyleType.style);

  // Material Symbols weights are typically 100-700.
  // These can be controlled by `font-variation-settings: 'wght' <value>;`
  // If there are utility classes like `font-weight-thin`, `font-weight-bold` from Typography,
  // those should be preferred. These are examples if specific icon classes existed.
  // For Material Symbols, it's often direct CSS or `font-variation-settings`.
  // If `deepyr` aims to abstract `font-variation-settings` via classes, they'd be defined here.

  /// Thin stroke weight for the icon.
  static const IconStyle weightThin = IconStyle('weight-200', type: StyleType.style);

  /// Regular stroke weight for the icon.
  static const IconStyle weightRegular = IconStyle('weight-400', type: StyleType.style);

  /// Bold stroke weight for the icon.
  static const IconStyle weightBold = IconStyle('weight-700', type: StyleType.style);

  // Sizes: DaisyUI/Tailwind text size utilities are typically used for font icons.
  // e.g., Text(modifiers: [Typography.textLg], [Icon(...)]) or Icon(..., modifiers: [Typography.textLg])
  // If you want dedicated Icon.sizeSm, Icon.sizeMd, etc., they would map to text size classes.
  // Your original example had text-xs, text-sm, etc. These should come from Typography utility.

  // Color: Similarly, text color utilities from Typography/Colors should be used.
  // e.g., Icon(..., modifiers: [Colors.textPrimary])
  // Your original example had text-primary etc.
}
