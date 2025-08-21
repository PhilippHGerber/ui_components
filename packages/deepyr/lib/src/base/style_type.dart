/// Enum representing the various types of utility classes available in Ui.
enum StyleType {
  // Core Layout
  layout, // Flexbox, Grid, positioning, display, float
  spacing, // Margin, padding, gap, space-between
  sizing, // Width, height, min/max dimensions
  // Visual Styling
  style, // Colors, background, opacity
  typography, // Font, text properties, whitespace
  border, // Border, outline, divider
  effect, // Shadows, blur, filters
  transform, // Transform, rotate, scale
  animation, // Transitions, animations
  // Behavioral
  state, // Active, hover, focus states
  interactive, // Cursor, pointer-events, scroll
  accessibility, // Screen readers, visibility, focus
  // Special Cases
  form, // Form-specific styles
  table, // Table-specific layouts
  utility, // Miscellaneous utilities

  additional,
}
