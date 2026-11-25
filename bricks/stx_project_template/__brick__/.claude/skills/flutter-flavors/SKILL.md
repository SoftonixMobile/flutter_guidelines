---
name: flutter-flavors
description: Configure Flutter build flavors (environments like dev, staging, production) for Android and/or iOS. Use this skill whenever the user mentions Flutter flavors, Flutter build configurations, Flutter environments, Flutter schemes, product flavors, Xcode schemes for Flutter, build variants for Flutter, or wants to set up dev/staging/prod builds in a Flutter project. Also trigger when the user asks about bundle IDs or app names in Flutter. Even if they just say "set up environments for my Flutter app" or "I need separate dev and prod builds", use this skill.
---

# Flutter Flavors Skill

This skill configures Flutter build flavors (environment-based builds like dev, staging, production) across Android, iOS, or both platforms.

## Workflow

### 1. Understand the request

Determine the following from the user's message. If any point is unclear or missing, ask a concise clarifying question covering all ambiguous points at once — do not assume defaults silently.

**Required clarifications:**

1. **Which flavors?** (e.g., `dev`, `staging`, `prod` — if unspecified, ask; do not default)
2. **Which platforms?** Android only, iOS only, or both — if unspecified, ask
3. **What varies per flavor?**
   - App name: What is the base app name, and should flavors use a prefix or suffix? (e.g., "Dev MyApp" with prefix, or "MyApp Dev" with suffix)
   - Bundle/application ID: What is the base bundle ID, and what suffix per flavor? (e.g., `com.example.app` → `com.example.app.dev`)
4. **Dart-side config?** Does the user need separate entry points (`lib/main_dev.dart`, `lib/main_prod.dart`) for flavor-specific bootstrap? The standard approach also uses environment files (`.env.dev`, `.env.prod`) passed via `--dart-define-from-file` for config values.

Based on the current project structure, suggest to the user the best approach and ask clarifying questions similar to the following (Use AskUserQuestion tool):

1. **Which flavors?**
   - `dev` + `prod` (Recommended)
   - `dev` + `staging` + `prod`
   - Other (please specify)

2. **Which platforms?**
   - Both (Android + iOS) (Recommended)
   - Android only
   - iOS only
   - Other (please specify)

3. **App name:**
   - What's the base app name and what is the flavor label style?
     - Prefix (e.g., "Dev MyApp") (Recommended)
     - Suffix (e.g., "MyApp Dev")
     - Base app name for all flavors (e.g., "MyApp")
     - Other (please specify)

4. **Bundle/application ID:**
   - What's the base ID and what is the flavor suffix style? (e.g., `com.example.app`)
     - Add flavor suffix to ID? (e.g., `com.example.app.dev`) (Recommended)
     - Base ID (e.g., `com.example.app`)
     - Other (please specify)

5. **Dart-side config:**
   - Separate entry points per flavor? (`lib/main_dev.dart`, etc.)
     - Yes (Recommended)
     - No — single entry point
     - Other (please specify)
   - Environment files via `--dart-define-from-file`? (`.env.dev`, `.env.prod`)
     - Yes (Recommended)
     - No
     - Other (please specify)

Note: Questions may depend on the current project structure, build id, app name, etc. For example, if the user already has flavor config, ask about existing config and suggest improvements.

Only proceed once all four points are resolved.

### 2. Read the relevant platform reference(s)

Based on the platform scope, read the appropriate reference files **before writing any code or config**:

| Scope | Files to read |
|-------|--------------|
| Android only | `references/general.md` then `references/android.md` |
| iOS only | `references/general.md` then `references/ios.md` |
| Both (default) | `references/general.md`, then `references/android.md`, then `references/ios.md` |

**Read order matters** — the order depends on the user's request. Always start with `general.md` for Dart-side setup, then read platform references in the order the user prioritizes. If no preference is stated, follow the default order above.

### 3. Execute

Follow the instructions in the reference files you loaded. The general pattern is:

1. **Dart side** (from `general.md`): Create flavor config, entry points, and `--dart-define-from-file` setup
2. **Android side** (from `android.md`): Configure `productFlavors` in `build.gradle`, resources
3. **iOS side** (from `ios.md`): Create Xcode schemes, xcconfig files, build settings

### 4. Verify

After making changes, suggest the user verify with:

```bash
# Android
flutter build apk --flavor dev -t lib/main_dev.dart --dart-define-from-file=.env.dev
flutter build apk --flavor prod -t lib/main_prod.dart --dart-define-from-file=.env.prod

# iOS
flutter build ios --flavor dev -t lib/main_dev.dart --dart-define-from-file=.env.dev
flutter build ios --flavor prod -t lib/main_prod.dart --dart-define-from-file=.env.prod
```

## Important notes

- Always check the Flutter project structure before making changes (look for existing `android/`, `ios/`, `lib/` folders and any existing flavor config)
- Respect existing build configurations — extend rather than overwrite
