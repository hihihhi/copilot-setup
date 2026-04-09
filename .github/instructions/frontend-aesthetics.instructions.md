---
applyTo: "**/*.tsx,**/*.css,**/components/**,**/pages/**,**/styles/**"
---

## Frontend Aesthetics — Avoid AI Slop

You tend to produce generic "AI slop" frontends by default. When writing any frontend code, apply these rules:

### Typography
- **Never use**: Inter, Roboto, Arial, Open Sans, Lato, or system-ui as the primary font
- **Choose distinctively** based on context:
  - Data/technical: IBM Plex Sans + IBM Plex Mono for numbers
  - Editorial/content: Playfair Display or Fraunces
  - Modern SaaS: Clash Display or Satoshi
  - Developer tools: JetBrains Mono or Fira Code
- Use extreme weight contrasts: pair 200 (light) with 800 (black), not 400 with 600
- Size jumps of 3× minimum between heading and body, not 1.5×
- Always load chosen font from Google Fonts with the `<link>` tag

### Color & Theme
- Commit fully to one aesthetic — don't hedge with safe palettes
- Use CSS custom properties (`--color-*`) for every color value
- **Never use**: purple gradient on white background (the default AI aesthetic)
- Dominant base color with one sharp accent outperforms equal distribution of 5 colors
- Draw from: IDE themes (Catppuccin, Nord, Tokyo Night), cultural aesthetics, material palettes

### Motion
- One well-orchestrated page load (staggered `animation-delay` reveals) > many micro-interactions
- CSS-only animations for HTML pages; Motion library for React
- Prefer `transform` and `opacity` for performance — avoid animating layout properties

### Backgrounds
- Never default to a flat solid color — add depth with layered gradients, geometric patterns, or subtle noise
- Background should match the overall aesthetic — dark technical, light editorial, etc.

### Layout
- Don't use equal-width columns unless the content demands it
- Whitespace is design — use asymmetric spacing deliberately
- Cards should have visible depth hierarchy (background > surface > elevated)

State your design choices (font, palette, aesthetic direction) in a comment before writing any styles.
