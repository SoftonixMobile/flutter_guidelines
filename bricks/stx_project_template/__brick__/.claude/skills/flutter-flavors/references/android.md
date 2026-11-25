# Flutter Flavors — Android Configuration

This reference covers Android-specific flavor setup. Read `general.md` first for Dart-side config.

## Table of Contents
1. [Product Flavors in build.gradle](#product-flavors-in-buildgradle)
2. [Kotlin vs Groovy Syntax](#kotlin-vs-groovy-syntax)
3. [Per-Flavor App Name](#per-flavor-app-name)
4. [Common Pitfalls](#common-pitfalls)

---

## Product Flavors in build.gradle

### Check which build system the project uses

Before editing, determine the build file:

- **Groovy DSL**: `android/app/build.gradle`
- **Kotlin DSL**: `android/app/build.gradle.kts`

Newer Flutter projects (3.16+) may use Kotlin DSL. Check which file exists.

### Groovy DSL (`build.gradle`)

Add inside the `android {}` block:

```groovy
android {
    // ... existing config ...

    flavorDimensions "default"
    productFlavors {
        dev {
            dimension "default"
            applicationIdSuffix ".dev"
            resValue "string", "display_name", "Dev MyApp"
        }
        prod {
            dimension "default"
            resValue "string", "display_name", "MyApp"
        }
    }
}
```

### Kotlin DSL (`build.gradle.kts`)

```kotlin
android {
    // ... existing config ...

    flavorDimensions += "default"
    productFlavors {
        create("dev") {
            dimension = "default"
            applicationIdSuffix = ".dev"
            resValue("string", "display_name", "Dev MyApp")
        }
        create("prod") {
            dimension = "default"
            resValue("string", "display_name", "MyApp")
        }
    }
}
```

---

## Kotlin vs Groovy Syntax

Quick cheat sheet for common differences:

| Action | Groovy | Kotlin DSL |
|--------|--------|------------|
| Set dimension | `dimension "env"` | `dimension = "env"` |
| Add flavor | `dev { ... }` | `create("dev") { ... }` |
| Set suffix | `applicationIdSuffix ".dev"` | `applicationIdSuffix = ".dev"` |
| Add flavor dimension | `flavorDimensions "env"` | `flavorDimensions += "env"` |

---

## Per-Flavor App Name

Two approaches:

### Approach 1: resValue (recommended for simplicity)

As shown above, use `resValue "string", "display_name", "MyApp Dev"` in the flavor block.

Then in `android/app/src/main/AndroidManifest.xml`:

```xml
<application
    android:label="@string/display_name"
    ...>
```

**Important**: Remove any hardcoded `android:label` value and ensure you don't have a conflicting `display_name` in `android/app/src/main/res/values/strings.xml`. If `strings.xml` has an `display_name` entry, remove it — the `resValue` from gradle takes precedence but may conflict.

---

## Common Pitfalls

### 1. Missing `flavorDimensions`
Every `productFlavors` block requires at least one `flavorDimensions` declaration. Without it, the build fails.

### 2. Plugin conflicts with flavors
Some Flutter plugins generate their own Gradle config. If you see build errors after adding flavors, check `android/app/build.gradle` for `missingDimensionStrategy`:

```groovy
android {
    defaultConfig {
        // If a plugin defines its own flavors, tell Gradle which to use
        missingDimensionStrategy 'somePluginDimension', 'default'
    }
}
```

### 3. Namespace / AGP 8+ changes
Android Gradle Plugin 8+ moved `namespace` out of `AndroidManifest.xml`. Ensure `namespace` is set in `build.gradle`:

```groovy
android {
    namespace "com.example.myapp"
    // ...
}
```

The `applicationIdSuffix` in flavors appends to the application ID, **not** the namespace. This is correct — namespace and application ID serve different purposes.