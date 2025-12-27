import 'package:deepyr/deepyr.dart';
import 'package:jaspr/dom.dart' show div, img, h1, p, label, a, h2;
import 'package:jaspr/jaspr.dart';

@client
class DeepyrShowcase extends StatelessComponent {
  const DeepyrShowcase({super.key});

  @override
  Component build(BuildContext context) {
    return div(classes: 'min-h-screen bg-base-100 p-8', [
      // Header
      div(classes: 'max-w-6xl mx-auto', [
        h1(classes: 'text-4xl font-bold text-center mb-2', [Component.text('🎨 Deepyr Component Showcase')]),
        p(classes: 'text-center text-base-content/70 mb-12', [
          Component.text('Type-safe DaisyUI components for Jaspr'),
        ]),

        // Alert Examples
        _buildSection('Alert Components', 'User notifications and feedback messages', [
          Alert([Component.text('🎉 Welcome to Deepyr! This is a success message.')], style: [Alert.success]),

          Alert([Component.text('⚠️ Please check your input. This is a warning.')], style: [Alert.warning]),

          Alert([Component.text('❌ Something went wrong. This is an error message.')], style: [Alert.error]),

          Alert([Component.text('ℹ️ Here\'s some helpful information for you.')], style: [Alert.info]),

          // Outlined style
          Alert(
            [Component.text('🔄 Processing your request... (outlined style)')],
            style: [Alert.info, Alert.outline],
          ),
        ]),

        // Card Examples
        _buildSection('Card Components', 'Content containers and layout blocks', [
          div(classes: 'grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4', [
            // Basic card
            Card(
              style: [BgUtil.base300, Effects.shadowLg],
              [
                CardBody([
                  CardTitle([Component.text('Basic Card')]),
                  p([Component.text('This is a simple card with some content inside.')]),
                  CardActions([
                    Button([Component.text('Action')], style: [Button.primary, Button.sm]),
                  ]),
                ]),
              ],
            ),

            // Card with image
            Card(
              style: [BgUtil.base300, Effects.shadowLg],
              [
                Figure([img(src: 'https://picsum.photos/400/200?random=1', alt: 'Random image')]),
                CardBody([
                  CardTitle([
                    Component.text('Image Card'),
                    Badge([Component.text('NEW')], style: [Badge.secondary]),
                  ]),
                  p([Component.text('Card with a beautiful image and badge.')]),
                  CardActions([
                    Button([Component.text('View')], style: [Button.ghost]),
                    Button([Component.text('Buy Now')], style: [Button.primary]),
                  ]),
                ]),
              ],
            ),

            // Compact card
            Card(
              style: [Card.border, Effects.shadowLg, Card.xs],
              [
                CardBody([
                  CardTitle([Component.text('Compact Card')]),
                  p([Component.text('Smaller card perfect for dashboards.')]),
                ]),
              ],
            ),
          ]),
        ]),

        // Button Examples
        _buildSection('Button Components', 'Interactive elements with various styles and states', [
          // Color variants
          div(classes: 'flex flex-wrap gap-2 mb-4', [
            Button([Component.text('Neutral')], style: [Button.neutral]),
            Button([Component.text('Primary')], style: [Button.primary]),
            Button([Component.text('Secondary')], style: [Button.secondary]),
            Button([Component.text('Accent')], style: [Button.accent]),
            Button([Component.text('Info')], style: [Button.info]),
            Button([Component.text('Success')], style: [Button.success]),
            Button([Component.text('Warning')], style: [Button.warning]),
            Button([Component.text('Error')], style: [Button.error]),
          ]),

          // Style variants
          div(classes: 'flex flex-wrap gap-2 mb-4', [
            Button([Component.text('Outline')], style: [Button.outline]),
            Button([Component.text('Ghost')], style: [Button.ghost]),
            Button([Component.text('Link')], style: [Button.link]),
            Button([Component.text('Soft')], style: [Button.soft]),
            Button([Component.text('Dash')], style: [Button.dash]),
          ]),

          // Size variants
          div(classes: 'flex flex-wrap items-center gap-2 mb-4', [
            Button([Component.text('XS')], style: [Button.xs]),
            Button([Component.text('SM')], style: [Button.sm]),
            Button([Component.text('MD')], style: [Button.md]),
            Button([Component.text('LG')], style: [Button.lg]),
            Button([Component.text('XL')], style: [Button.xl]),
          ]),

          // Shape variants
          div(classes: 'flex flex-wrap items-center gap-2', [
            Button([Component.text('Wide Button')], style: [Button.wide]),
            Button([Component.text('⭐')], style: [Button.square]),
            Button([Component.text('💝')], style: [Button.circle]),
            Button([Component.text('Block Button')], style: [Button.block]),
          ]),
        ]),

        // Input Examples
        _buildSection('Input Components', 'Form inputs with validation and styling', [
          div(classes: 'grid grid-cols-1 md:grid-cols-2 gap-4', [
            // Basic inputs
            div([
              label(classes: 'block text-sm font-medium mb-2', [Component.text('Email Address')]),
              Input(type: 'email', placeholder: 'Enter your email', style: [Input.primary]),
            ]),

            div([
              label(classes: 'block text-sm font-medium mb-2', [Component.text('Password')]),
              Input(type: 'password', placeholder: 'Enter password', style: [Input.secondary]),
            ]),

            // Different sizes
            div([
              label(classes: 'block text-sm font-medium mb-2', [Component.text('Small Input')]),
              Input(placeholder: 'Small size', style: [Input.sm]),
            ]),

            div([
              label(classes: 'block text-sm font-medium mb-2', [Component.text('Large Input')]),
              Input(placeholder: 'Large size', style: [Input.lg]),
            ]),

            // Validation states
            div([
              label(classes: 'block text-sm font-medium mb-2', [Component.text('Success State')]),
              Input(placeholder: 'Valid input', style: [Input.success]),
            ]),

            div([
              label(classes: 'block text-sm font-medium mb-2', [Component.text('Error State')]),
              Input(placeholder: 'Invalid input', style: [Input.error]),
            ]),
          ]),

          // Ghost style
          div(classes: 'mt-4', [
            label(classes: 'block text-sm font-medium mb-2', [Component.text('Ghost Style Input')]),
            Input(placeholder: 'Transparent background', style: [Input.ghost, Input.lg]),
          ]),
        ]),

        // Badge Examples
        _buildSection('Badge Components', 'Status indicators, labels, and counters', [
          // Color variants
          div(classes: 'flex flex-wrap gap-2 mb-4', [
            Badge([Component.text('Neutral')], style: [Badge.neutral]),
            Badge([Component.text('Primary')], style: [Badge.primary]),
            Badge([Component.text('Secondary')], style: [Badge.secondary]),
            Badge([Component.text('Accent')], style: [Badge.accent]),
            Badge([Component.text('Info')], style: [Badge.info]),
            Badge([Component.text('Success')], style: [Badge.success]),
            Badge([Component.text('Warning')], style: [Badge.warning]),
            Badge([Component.text('Error')], style: [Badge.error]),
          ]),

          // Style variants
          div(classes: 'flex flex-wrap gap-2 mb-4', [
            Badge([Component.text('Outline')], style: [Badge.outline]),
            Badge([Component.text('Ghost')], style: [Badge.ghost]),
            Badge([Component.text('Soft')], style: [Badge.soft]),
            Badge([Component.text('Dash')], style: [Badge.dash]),
          ]),

          // Size variants
          div(classes: 'flex flex-wrap items-center gap-2 mb-4', [
            Badge([Component.text('XS')], style: [Badge.xs]),
            Badge([Component.text('SM')], style: [Badge.sm]),
            Badge([Component.text('MD')], style: [Badge.md]),
            Badge([Component.text('LG')], style: [Badge.lg]),
            Badge([Component.text('XL')], style: [Badge.xl]),
          ]),

          // Practical examples
          div(classes: 'space-y-2', [
            p([
              Component.text('Status: '),
              Badge([Component.text('Online')], style: [Badge.success, Badge.sm]),
            ]),
            p([
              Component.text('Notifications '),
              Badge([Component.text('3')], style: [Badge.error, Badge.xs]),
            ]),
            p([
              Component.text('Version '),
              Badge([Component.text('v1.2.0')], style: [Badge.ghost]),
            ]),
          ]),
        ]),

        // Integration Examples
        _buildSection('Component Integration', 'Examples showing components working together', [
          // Login card example
          div(classes: 'max-w-md mx-auto', [
            Card(
              style: [Card.border, Card.lg],
              [
                CardBody([
                  div(classes: 'text-center mb-4', [
                    CardTitle([
                      Component.text('Login'),
                      Badge([Component.text('Secure')], style: [Badge.success, Badge.sm]),
                    ]),
                  ]),
                  Alert(
                    [Component.text('Please enter your credentials to continue.')],
                    style: [Alert.info, Alert.soft],
                  ),
                  div(classes: 'space-y-4 mt-4', [
                    Input(type: 'email', placeholder: 'Email address', style: [Input.primary]),
                    Input(type: 'password', placeholder: 'Password', style: [Input.primary]),
                  ]),
                  CardActions([
                    Button([Component.text('Cancel')], style: [Button.ghost]),
                    Button([Component.text('Sign In')], style: [Button.primary]),
                  ]),
                ]),
              ],
            ),
          ]),
        ]),

        // Footer
        div(classes: 'text-center mt-16 pt-8 border-t border-base-300', [
          p(classes: 'text-base-content/60', [
            Component.text('Built with ❤️ using Deepyr • '),
            a(
              href: 'https://github.com/PhilippHGerber/ui_components',
              classes: 'link link-primary',
              [Component.text('View on GitHub')],
            ),
          ]),
        ]),
      ]),
    ]);
  }

  Component _buildSection(String title, String description, List<Component> content) {
    return div(classes: 'mb-16', [
      div(classes: 'mb-8', [
        h2(classes: 'text-2xl font-bold mb-2', [Component.text(title)]),
        p(classes: 'text-base-content/70', [Component.text(description)]),
      ]),
      div(classes: 'space-y-6', content),
    ]);
  }
}