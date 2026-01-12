import 'package:jaspr/dom.dart' show Styles;
import 'package:jaspr/jaspr.dart' show Key;

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_events.dart';
import 'chat_style.dart';

/// The main container for a single line of conversation.
///
/// This component acts as the root for a chat entry and is responsible for
/// its horizontal alignment. It must be styled with either `Chat.start` or
/// `Chat.end` to function correctly. Its children should be a composition
/// of `ChatImage`, `ChatHeader`, `ChatBubble`, and `ChatFooter`.
///
/// Example:
/// ```dart
/// Chat(
///   style: [Chat.start],
///   [
///     ChatImage([...]),
///     ChatHeader([...]),
///     ChatBubble([...]),
///     ChatFooter([...]),
///   ],
/// )
/// ```
class Chat extends UiComponent {
  /// Creates the main container for a chat message.
  ///
  /// - [children]: The compositional parts of the chat message, such as
  ///   `ChatImage`, `ChatBubble`, etc.
  /// - [style]: A list of [ChatStyling] modifiers, which **must** include
  ///   either `Chat.start` or `Chat.end` for alignment.
  /// - Other parameters are inherited from [UiComponent].
  const Chat(
    super.children, {
    super.tag = 'div',
    List<ChatStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'chat';

  @override
  Chat copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Chat(
      children,
      tag: tag,
      style: style as List<ChatStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      child: child,
      key: key ?? this.key,
    );
  }

  // --- Static Style Modifiers ---

  /// Aligns the chat bubble to the start (left in LTR). `chat-start`
  static const ChatStyle start = ChatStyle('chat-start', type: StyleType.layout);

  /// Aligns the chat bubble to the end (right in LTR). `chat-end`
  static const ChatStyle end = ChatStyle('chat-end', type: StyleType.layout);
}

/// A container for the author's image in a `Chat` component.
///
/// This component is a simple wrapper. Its child should typically be a `deepyr`
/// `Avatar` component to correctly apply the necessary styling.
class ChatImage extends UiComponent {
  /// Creates a container for a chat avatar.
  ///
  /// - [children] or [child]: The content, which should be a `deepyr` `Avatar` component.
  const ChatImage(
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
  String get baseClass => 'chat-image';

  @override
  ChatImage copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return ChatImage(
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

/// A container for the header of a chat bubble, typically containing the author's name and a timestamp.
///
/// Styling (like text size and opacity) should be applied using general utilities.
class ChatHeader extends UiComponent {
  /// Creates a header for a chat bubble.
  ///
  /// - [children]: The content, such as the author's name and a `time()` element.
  const ChatHeader(
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
  String get baseClass => 'chat-header';

  @override
  ChatHeader copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return ChatHeader(
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

/// The main message container in a `Chat` component.
///
/// This is the visual "bubble" that holds the text. It is the only component in
/// the chat family that accepts color modifiers.
class ChatBubble extends UiComponent {
  /// Creates a chat message bubble.
  ///
  /// - [children]: The message content, typically text.
  /// - [style]: A list of [ChatBubbleStyling] modifiers to control the color.
  const ChatBubble(
    super.children, {
    super.tag = 'div',
    List<ChatBubbleStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'chat-bubble';

  @override
  ChatBubble copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return ChatBubble(
      children,
      tag: tag,
      style: style as List<ChatBubbleStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      child: child,
      key: key ?? this.key,
    );
  }

  // --- Static Style Modifiers ---
  static const ChatBubbleStyle neutral = ChatBubbleStyle(
    'chat-bubble-neutral',
    type: StyleType.style,
  );
  static const ChatBubbleStyle primary = ChatBubbleStyle(
    'chat-bubble-primary',
    type: StyleType.style,
  );
  static const ChatBubbleStyle secondary = ChatBubbleStyle(
    'chat-bubble-secondary',
    type: StyleType.style,
  );
  static const ChatBubbleStyle accent = ChatBubbleStyle(
    'chat-bubble-accent',
    type: StyleType.style,
  );
  static const ChatBubbleStyle info = ChatBubbleStyle('chat-bubble-info', type: StyleType.style);
  static const ChatBubbleStyle success = ChatBubbleStyle(
    'chat-bubble-success',
    type: StyleType.style,
  );
  static const ChatBubbleStyle warning = ChatBubbleStyle(
    'chat-bubble-warning',
    type: StyleType.style,
  );
  static const ChatBubbleStyle error = ChatBubbleStyle('chat-bubble-error', type: StyleType.style);
}

/// A container for the footer of a chat bubble, typically containing delivery status.
///
/// Styling (like text size and opacity) should be applied using general utilities.
class ChatFooter extends UiComponent {
  /// Creates a footer for a chat bubble.
  ///
  /// - [children]: The content, such as "Delivered" or "Seen at 12:46".
  const ChatFooter(
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
  String get baseClass => 'chat-footer';

  @override
  ChatFooter copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return ChatFooter(
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
