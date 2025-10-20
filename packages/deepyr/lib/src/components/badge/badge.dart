import 'package:jaspr/jaspr.dart';

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
import 'badge_style.dart';

/// A small visual indicator or label, often used for counts, statuses, or categories.
/// It typically renders as an HTML `<span>` with the 'badge' base class.
class Badge extends UiComponent {
  /// Creates a Badge component.
  ///
  /// - [children] or [child]: The content to display within the badge (e.g., text, an icon).
  /// - [tag]: The HTML tag for the root element, defaults to 'span'.
  /// - [style]: A list of [BadgeStyling].
  /// - [ariaLabel]: An optional accessible name for the badge.
  /// - Other parameters are inherited from [UiComponent].
  const Badge(
    super.children, {
    super.tag = 'span',
    List<BadgeStyling>? style,
    this.ariaLabel,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  }) : super(style: style);

  /// An optional string to use as an `aria-label` for the badge.
  final String? ariaLabel;

  @override
  String get baseClass => 'badge';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);

    if (ariaLabel != null) {
      attributes.addAria('label', ariaLabel!);
    }
    // Consider role="status" if the badge content updates dynamically to convey status changes.
    // This is context-dependent and might be better applied by the user.
  }

  @override
  Badge copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Badge(
      children,
      tag: tag,
      style: style as List<BadgeStyling>?,
      ariaLabel: ariaLabel,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      child: child,
      key: key ?? this.key,
    );
  }
  // --- Static Badge Styles ---

  // Styles
  /// Outline style badge. `badge-outline`
  static const BadgeStyle outline = BadgeStyle(
    'badge-outline',
    type: StyleType.border,
  );

  /// Dash outline style badge. `badge-dash` (New in DaisyUI 5)
  static const BadgeStyle dash = BadgeStyle(
    'badge-dash',
    type: StyleType.border,
  );

  /// Soft style badge. `badge-soft` (New in DaisyUI 5)
  static const BadgeStyle soft = BadgeStyle(
    'badge-soft',
    type: StyleType.style,
  );

  /// Ghost style badge (semi-transparent). `badge-ghost`
  static const BadgeStyle ghost = BadgeStyle(
    'badge-ghost',
    type: StyleType.style,
  );

  // Color styles
  /// Neutral color badge. `badge-neutral`
  static const BadgeStyle neutral = BadgeStyle(
    'badge-neutral',
    type: StyleType.style,
  );

  /// Primary color badge. `badge-primary`
  static const BadgeStyle primary = BadgeStyle(
    'badge-primary',
    type: StyleType.style,
  );

  /// Secondary color badge. `badge-secondary`
  static const BadgeStyle secondary = BadgeStyle(
    'badge-secondary',
    type: StyleType.style,
  );

  /// Accent color badge. `badge-accent`
  static const BadgeStyle accent = BadgeStyle(
    'badge-accent',
    type: StyleType.style,
  );

  /// Informational status color badge. `badge-info`
  static const BadgeStyle info = BadgeStyle(
    'badge-info',
    type: StyleType.style,
  );

  /// Success status color badge. `badge-success`
  static const BadgeStyle success = BadgeStyle(
    'badge-success',
    type: StyleType.style,
  );

  /// Warning status color badge. `badge-warning`
  static const BadgeStyle warning = BadgeStyle(
    'badge-warning',
    type: StyleType.style,
  );

  /// Error status color badge. `badge-error`
  static const BadgeStyle error = BadgeStyle(
    'badge-error',
    type: StyleType.style,
  );

  // Size styles
  /// Extra-small size badge. `badge-xs`
  static const BadgeStyle xs = BadgeStyle(
    'badge-xs',
    type: StyleType.sizing,
  );

  /// Small size badge. `badge-sm`
  static const BadgeStyle sm = BadgeStyle(
    'badge-sm',
    type: StyleType.sizing,
  );

  /// Medium size badge (often the default). `badge-md`
  static const BadgeStyle md = BadgeStyle(
    'badge-md',
    type: StyleType.sizing,
  );

  /// Large size badge. `badge-lg`
  static const BadgeStyle lg = BadgeStyle(
    'badge-lg',
    type: StyleType.sizing,
  );

  /// Extra-large size badge. `badge-xl` (New in DaisyUI 5)
  static const BadgeStyle xl = BadgeStyle(
    'badge-xl',
    type: StyleType.sizing,
  );
}

/// Helper methods for creating common badge patterns.
class BadgeHelper {
  /// Creates a badge with an icon and text.
  static Badge createIconBadge({
    required Component icon,
    required String text,
    List<BadgeStyling>? styles,
    String? classes,
    String? ariaLabel,
    Key? key,
  }) {
    return Badge(
      <Component>[icon, Component.text(text)],
      style: styles,
      classes: classes,
      ariaLabel: ariaLabel,
      key: key,
    );
  }

  /// Creates a notification badge, typically displaying a count.
  static Badge createNotificationBadge({
    required String count,
    List<BadgeStyling>? styles,
    String? classes,
    String? ariaLabel,
    Key? key,
  }) {
    return Badge(
      <Component>[Component.text(count)],
      style: styles,
      classes: classes,
      ariaLabel: ariaLabel ?? 'Notification count: $count',
      key: key,
    );
  }

  /// Creates an empty status badge, often used as a colored dot.
  /// An `ariaLabel` is highly recommended for accessibility if the badge's meaning isn't clear from context.
  static Badge createStatusBadge({
    List<BadgeStyling>? styles,
    String? classes,
    String? ariaLabel,
    Key? key,
  }) {
    return Badge(
      const <Component>[],
      style: styles,
      classes: classes,
      ariaLabel: ariaLabel,
      key: key,
    );
  }
}
