import 'package:jaspr/jaspr.dart';

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import 'avatar_style.dart';

/// A component for displaying a user's profile image or a placeholder.
///
/// It renders as a `<div>` with the `avatar` base class and typically contains
/// another styled `div` that holds the image or placeholder text.
class Avatar extends UiComponent {
  /// Creates an Avatar component.
  ///
  /// - [children] or [child]: The content of the avatar, usually a styled `div`
  ///   wrapping an `img` or `span` element.
  /// - [isPlaceholder]: If true, applies the `avatar-placeholder` class, styling
  ///   the avatar for use with text initials instead of an image.
  /// - [style]: A list of [AvatarStyling] instances, such as [Avatar.online]
  ///   or [Avatar.offline].
  /// - Other parameters are inherited from [UiComponent].
  const Avatar(
    super.children, {
    this.isPlaceholder = false,
    super.tag = 'div',
    List<AvatarStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.child,
    super.key,
  }) : super(style: style);

  /// Creates an Avatar specifically styled as a placeholder for text.
  ///
  /// This is a convenience factory that sets `isPlaceholder` to true.
  factory Avatar.placeholder(
    List<Component>? children, {
    Component? child,
    List<AvatarStyling>? style,
    Key? key,
  }) {
    return Avatar(
      children,
      child: child,
      isPlaceholder: true,
      style: style,
      key: key,
    );
  }

  /// If true, adds the `avatar-placeholder` class.
  final bool isPlaceholder;

  @override
  String get baseClass => 'avatar';

  @override
  String get combinedClasses {
    // Start with the default combined classes from UiComponent.
    var combined = super.combinedClasses;
    // Prepend the placeholder class if needed.
    if (isPlaceholder) {
      combined = 'avatar-placeholder $combined';
    }
    return combined;
  }

  @override
  Avatar copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return Avatar(
      children,
      isPlaceholder: isPlaceholder,
      tag: tag,
      style: style as List<AvatarStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      child: child,
      key: key ?? this.key,
    );
  }

  // --- Static Style Modifiers ---

  /// Shows a green dot as an online indicator. `avatar-online`
  static const AvatarStyle online = AvatarStyle('avatar-online', type: StyleType.state);

  /// Shows a gray dot as an offline indicator. `avatar-offline`
  static const AvatarStyle offline = AvatarStyle('avatar-offline', type: StyleType.state);
}

/// A container for grouping multiple [Avatar] components.
///
/// It applies stacking and spacing to create a seamless group of avatars.
class AvatarGroup extends UiComponent {
  /// Creates an AvatarGroup component.
  ///
  /// - [children] or [child]: A list of [Avatar] components.
  /// - [style]: A list of general styling utilities.
  /// - Other parameters are inherited from [UiComponent].
  const AvatarGroup(
    super.children, {
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.child,
    super.key,
  });

  @override
  String get baseClass => 'avatar-group';
  @override
  AvatarGroup copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return AvatarGroup(
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
}
