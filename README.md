# flutter_guidelines

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## To update the guidelines brick use the following command in the terminal

```
dart run flutter_guidelines:update_guidelines_brick

```

## Patrol

To be able to run patrol tests, you need to set up [Patrol CLI](https://pub.dev/packages/patrol_cli).

Run:
```
dart pub global activate patrol_cli
```

Follow the steps [here](https://patrol.leancode.co/getting-started) to set up patrol for the platforms


To run patrol tests use (the first device will be chosen):
```
patrol test
```

If we want to use not the first device, run:
```
patrol devices
```

Choose the needed device, then run (replace `iPhone 14 Pro Max` to your device name):
```
patrol test --device "iPhone 14 Pro Max"
```
