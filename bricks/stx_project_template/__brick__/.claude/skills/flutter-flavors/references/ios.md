# Flutter Flavors — iOS Configuration

This reference covers iOS-specific flavor setup. Read `general.md` first for Dart-side config.

This is an **interactive, step-by-step workflow** — each step requires developer confirmation before moving on. Never skip steps or assume the developer has completed something without asking.

The workflow has 5 steps. Track progress and always tell the developer which step they are on.

## Table of Contents
1. [Step 1 — Rename existing build configurations](#step-1--rename-existing-build-configurations)
2. [Step 2 — Create Xcode schemes](#step-2--create-xcode-schemes)
3. [Step 3 — Set bundle identifiers and display names](#step-3--set-bundle-identifiers-and-display-names)
4. [Step 4 — Update Info.plist](#step-4--update-infoplist)
5. [Step 5 — Update xcconfig files (CocoaPods only)](#step-5--update-xcconfig-files-cocoapods-only)

---

## Step 1 — Rename existing build configurations

Ask the developer to open the Xcode project and rename the existing build configurations.

The developer must create **3 build configurations per flavor** (Debug, Profile, Release). A default Flutter project starts with 3 configurations (Debug, Profile, Release). First duplicate each original N − 1 times (for N flavors), then rename all of them — originals and copies — to follow the `{Type}-{flavor}` pattern.

> **Step 1 of 5 — Duplicate and rename build configurations**
>
> Open your Xcode project → select the **Runner** project (not the target) → go to the **Info** tab.
>
> **First**, duplicate each original configuration **N − 1** times (where N is the number of flavors).
> For each of Debug, Profile, and Release, click **+** → "Duplicate ... configuration" to create the copies.
>
> **Then** rename all configurations (originals + copies) to follow the `{Type}-{flavor}` pattern:
>
> | Configuration     | Rename to             |
> |-------------------|-----------------------|
> | Debug             | **Debug-{flavor1}**   |
> | Debug copy        | **Debug-{flavor2}**   |
> | Profile           | **Profile-{flavor1}** |
> | Profile copy      | **Profile-{flavor2}** |
> | Release           | **Release-{flavor1}** |
> | Release copy      | **Release-{flavor2}** |
>
> When done you should have **3 × N** build configurations total.
>
> Let me know or share a screenshot so I can verify.

**Example for 2 flavors (dev, prod) — 6 configurations:**

```
Debug-dev       Profile-dev       Release-dev
Debug-prod      Profile-prod      Release-prod
```

Wait for the developer to confirm. If they share a screenshot, verify all configurations exist. If anything is wrong, tell them exactly what to fix.

---

## Step 2 — Create Xcode schemes

Once Step 1 is confirmed, guide the developer to create one scheme per flavor.

The **first scheme** is created by renaming the existing `Runner` scheme. All additional schemes are created via **Product → Scheme → New Scheme**.

> **Step 2 of 5 — Create Xcode schemes**
>
> You need one scheme per flavor. Each scheme maps to its corresponding build configurations.
>
> **First flavor** — rename the existing Runner scheme:
> 1. In **Manage Schemes**, select the **Runner** scheme and rename it to your first flavor name (e.g., `dev`).
>
> **Additional flavors** — create new schemes:
> 1. Go to **Product → Scheme → New Scheme**.
> 2. Name it after the flavor and make sure the target is set to **Runner**.
>
> **For every scheme**, edit it and set the Build Configuration for each tab:
>
> | Tab       | Build Configuration        |
> |-----------|----------------------------|
> | Run       | Debug-{flavor}             |
> | Test      | Debug-{flavor}             |
> | Profile   | Profile-{flavor}           |
> | Analyze   | Debug-{flavor}             |
> | Archive   | Release-{flavor}           |
>
> Make sure the **Shared** checkbox is checked for every scheme.
>
> Let me know when you're done, or share a screenshot of the Manage Schemes window.

Wait for confirmation. Verify all schemes exist, are shared, and have the correct configuration assignments.

---

## Step 3 — Set bundle identifiers and display names

Once schemes are confirmed, run the bundled Ruby script based on the developer's request. The script accepts a JSON list of flavor configs:

```bash
ruby <skill_dir>/scripts/update-ios-config.rb \
  --project ios/Runner.xcodeproj \
  --flavors '[
    {"suffix": "dev", "bundle_id": "com.example.myapp.dev", "display_name": "Dev MyApp"},
    {"suffix": "prod", "bundle_id": "com.example.myapp", "display_name": "MyApp"}
  ]'
```

The `suffix` is the build configuration suffix (e.g., `dev`, `prod`). The script matches configurations ending with `-{suffix}` and applies the bundle ID and display name.

**Important:**
- If the `xcodeproj` gem is not installed, install it first: `gem install xcodeproj`.
- Locate the script at: `<this skill's parent directory>/scripts/update-ios-config.rb`
- You can omit `bundle_id` or `display_name` from any entry to leave it unchanged.

---

## Step 4 — Update Info.plist

> **Step 4 of 5 — Update Info.plist**
>
> Open `ios/Runner/Info.plist` and make sure these keys use the `$(DISPLAY_NAME)` variable:

Find the existing `CFBundleDisplayName` and `CFBundleName` entries and update them. If they don't exist, add them. The goal is:

```xml
<key>CFBundleDisplayName</key>
<string>$(DISPLAY_NAME)</string>
```

```xml
<key>CFBundleName</key>
<string>$(DISPLAY_NAME)</string>
```

Do this programmatically if the file is accessible, or instruct the developer to do it manually. Verify the plist after changes.

---

## Step 5 — Update xcconfig files (CocoaPods only)

First, check whether the project uses CocoaPods. Look for:
- A `Podfile` in the `ios/` directory
- A `Pods/` directory

**If CocoaPods is NOT used** (project uses Swift Package Manager), skip this step and tell the developer:

> Your project doesn't use CocoaPods, so no xcconfig changes are needed. Moving on!

**If CocoaPods IS used**, update the xcconfig files and Podfile.

### xcconfig files

**`ios/Flutter/Debug.xcconfig`** — add an optional include for each flavor's debug config:
```
#include? "Pods/Target Support Files/Pods-Runner/Pods-Runner.debug-{flavor1}.xcconfig"
#include? "Pods/Target Support Files/Pods-Runner/Pods-Runner.debug-{flavor2}.xcconfig"
... (one line per flavor)
#include "Generated.xcconfig"
```

**`ios/Flutter/Release.xcconfig`** — add optional includes for each flavor's profile and release configs:
```
#include? "Pods/Target Support Files/Pods-Runner/Pods-Runner.profile-{flavor1}.xcconfig"
#include? "Pods/Target Support Files/Pods-Runner/Pods-Runner.profile-{flavor2}.xcconfig"
... (one line per flavor)
#include? "Pods/Target Support Files/Pods-Runner/Pods-Runner.release-{flavor1}.xcconfig"
#include? "Pods/Target Support Files/Pods-Runner/Pods-Runner.release-{flavor2}.xcconfig"
... (one line per flavor)
#include "Generated.xcconfig"
```

Note the `#include?` (with question mark) — these are optional includes that won't fail if the file doesn't exist yet (before the first `pod install`).

### Podfile

Add the build configuration mapping inside the `Podfile`, right after the `platform :ios` line (or near the top, before `target 'Runner'`):

```ruby
project 'Runner', {
  'Debug-dev' => :debug,
  'Profile-dev' => :release,
  'Release-dev' => :release,
  'Debug-prod' => :debug,
  'Profile-prod' => :release,
  'Release-prod' => :release,
}
```

The pattern: `Debug-*` maps to `:debug`, `Profile-*` and `Release-*` map to `:release`. Generate one entry per flavor per build type.

After updating, tell the developer to run `pod install` to regenerate the Pods xcconfig files.

---

## Important behavioral notes

- **Never skip ahead.** Complete each step and get developer confirmation before proceeding.
- **Always verify.** When the developer says they're done or shares a screenshot, check their work. If something is wrong, clearly explain what needs fixing.
- **Be flexible on Step 3.** The developer may want to skip the script, update only some values, or provide custom values instead of using the suffix/prefix convention.
- **Detect CocoaPods vs SPM** in Step 5 before suggesting xcconfig changes.
- **Track progress.** If the conversation is interrupted, remind the developer where they left off.
- **Adapt to any number of flavors.** The steps above use placeholder names — always substitute the actual flavor names the developer specified.

## Common Pitfalls

### 1. Scheme name must match flavor name
Flutter expects the scheme name to exactly match the `--flavor` argument (case-sensitive). If you run `flutter run --flavor dev`, the scheme must be named `dev`.

### 2. Missing build configurations
Every flavor needs exactly 3 build configurations: Debug, Profile, and Release. If any are missing, Flutter won't be able to build for that flavor.

### 3. Scheme not shared
If a scheme's **Shared** checkbox is unchecked, the `.xcscheme` file lives in the user's local data instead of `xcshareddata/`. This means other developers and CI won't have the scheme. Always ensure all flavor schemes are shared.

### 4. CocoaPods configuration mismatch
When using CocoaPods, the Podfile must list all build configurations. Missing entries cause `pod install` to fail or produce warnings. The xcconfig includes must also cover all flavors.

### 5. Build configuration naming convention
The naming convention `{Type}-{flavor}` (e.g., `Debug-dev`, `Release-prod`) is critical. Flutter uses the flavor name (lowercase) from `--flavor` to find the matching scheme, and the scheme maps to configurations via this naming convention.

### 6. Code signing per flavor
Each flavor with a unique bundle ID needs its own provisioning profile. For development, automatic signing is easiest. For CI/CD, set up per-flavor profiles via xcconfig:
```
CODE_SIGN_STYLE=Manual
PROVISIONING_PROFILE_SPECIFIER=MyApp Dev Profile
DEVELOPMENT_TEAM=XXXXXXXXXX
```

### 7. Flutter scheme detection
If Flutter can't find your scheme, verify:
```bash
xcodebuild -workspace ios/Runner.xcworkspace -list
```
Your flavor schemes should appear in the output. If not, the scheme files may not be in the right location or may not be marked as shared.
