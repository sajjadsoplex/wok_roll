# Wok & Roll — Flutter Web

A playful, single-page interactive story for the Wok & Roll Chowmein Corner Culture Day stall.

## Included

- Eight interactive story scenes: welcome, calendar, running, stall reveal, Noor Ul Huda mission, chowmein delivery, thank-you, and appreciation.
- Custom-drawn white kitten mascot (no external image dependency).
- Animated glowing CTA buttons, scene transitions, running sequence, floating decorations and flying bees.
- Responsive layout for mobile and desktop.
- Supplied Culture Day poster bundled locally.
- Real chicken-noodle stock photograph loaded from Pexels with a bundled local fallback.
- No backend, accounts, API keys, or external runtime image URLs.

## Requirements

- Flutter stable with Dart 3.3 or newer.
- Chrome (for local web preview).

## Run locally

```bash
flutter doctor
flutter pub get
flutter run -d chrome
```

## Build for GitHub Pages

For a repository named `wok-and-roll`:

```bash
flutter build web --release --base-href "/wok-and-roll/"
```

Publish the **contents** of `build/web/` to the `gh-pages` branch or configure GitHub Pages to deploy from a branch/folder containing those build files.

### GitHub Actions deployment (recommended)

1. Push this project to a repository named `wok-and-roll`.
2. In GitHub, open **Settings → Pages** and set the source to **GitHub Actions**.
3. Add the workflow below as `.github/workflows/deploy.yml`.
4. Push to `main`. GitHub Actions builds Flutter Web and publishes `build/web`.

```yaml
name: Deploy Flutter Web to GitHub Pages
on:
  push:
    branches: [main]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: pages
  cancel-in-progress: true

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          channel: stable
          flutter-version: '3.24.5'
      - run: flutter pub get
      - run: flutter build web --release --base-href "/wok-and-roll/"
      - uses: actions/upload-pages-artifact@v3
        with:
          path: build/web

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - id: deployment
        uses: actions/deploy-pages@v4
```

**Important:** If your repository has a different name, replace `/wok-and-roll/` in the build command with `/<YOUR-REPOSITORY-NAME>/`. For a custom domain or user site repository, use `/`.

## Project structure

```text
wok_and_roll_flutter/
├── assets/images/
│   ├── culture_day_poster.jpg
│   └── chowmein_from_poster.jpg
├── lib/
│   ├── main.dart
│   ├── app.dart
│   ├── scenes/story_controller.dart
│   └── widgets/
│       ├── cat_mascot.dart
│       ├── floating_decorations.dart
│       └── story_button.dart
├── web/index.html
├── pubspec.yaml
└── README.md
```

## Before the event

- Confirm whether the event year is 2026. The experience currently says 26 November, without a year in the story.
- Replace the bundled poster with the final approved stall poster if it changes.
- Add a real stall photo and a permitted group photo of the 6th B Girlies if available. The supplied event poster is currently used for the stall reveal; the separate noodle photo is a stock image, not a photograph of your actual dish.
- Verify the spelling and preferred display of Noor Ul Huda's name.
- Test the built site on an Android phone and a desktop browser before sharing the QR code.

## Notes

This is a frontend-only experience. The chowmein action is a playful story interaction, not an actual order/payment flow. The cat mascot is drawn in Flutter Canvas, so no third-party cat asset or remote animation service is required.

## Image credit

The sample chicken-noodle photograph is by **Nadin Sh** on [Pexels](https://www.pexels.com/photo/close-up-of-chicken-noodles-dish-24738508/) and is presented as a free stock photo. Replace it with your own dish photo for the most authentic stall promotion. The original event poster was supplied in this conversation.
