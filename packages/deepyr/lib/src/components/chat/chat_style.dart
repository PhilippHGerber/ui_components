import '../../base/component_style.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'chat.dart' show Chat, ChatBubble, ChatFooter, ChatHeader, ChatImage;

// These abstract classes are used for type-safe styling, allowing only relevant
// modifiers to be passed to each component's `style` property.

/// A marker interface for utilities applicable to the main [Chat] container.
abstract class ChatStyling implements Styling {}

/// A marker interface for utilities applicable to the [ChatBubble] component.
abstract class ChatBubbleStyling implements Styling {}

/// A marker interface for utilities applicable to the [ChatImage] component.
abstract class ChatImageStyling implements Styling {}

/// A marker interface for utilities applicable to the [ChatHeader] component.
abstract class ChatHeaderStyling implements Styling {}

/// A marker interface for utilities applicable to the [ChatFooter] component.
abstract class ChatFooterStyling implements Styling {}

/// Defines specific styling options for a [Chat] container, primarily its alignment.
class ChatStyle extends ComponentStyle<ChatStyle>
    with Breakpoints<ChatStyle>
    implements ChatStyling {
  /// Constructs a [ChatStyle].
  const ChatStyle(super.cssClass, {required super.type, super.modifiers});

  @override
  ChatStyle create(List<PrefixModifier> modifiers) {
    return ChatStyle(cssClass, type: type, modifiers: modifiers);
  }
}

/// Defines specific styling options for a [ChatBubble], primarily its color.
class ChatBubbleStyle extends ComponentStyle<ChatBubbleStyle>
    with Breakpoints<ChatBubbleStyle>
    implements ChatBubbleStyling {
  /// Constructs a [ChatBubbleStyle].
  const ChatBubbleStyle(super.cssClass, {required super.type, super.modifiers});

  @override
  ChatBubbleStyle create(List<PrefixModifier> modifiers) {
    return ChatBubbleStyle(cssClass, type: type, modifiers: modifiers);
  }
}
