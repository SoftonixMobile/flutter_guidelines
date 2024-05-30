.PHONY: build watch lang sort fix lint commit splash icon setup_hooks

get:
	dart pub get

build:
	dart run build_runner build --delete-conflicting-outputs

watch:
	dart run build_runner watch --delete-conflicting-outputs

lang:
	dart run stx_easy_localization_generator:generate
	dart run stx_easy_localization_generator:generate -f keys -o locale_keys.g.dart

sort:
	dart run import_sorter:main

fix:
	dart fix --apply

lint:
	flutter analyze .
	# flutter analyze --no-fatal-infos | grep -E "error •|warning •" || true

commit:
	make sort
	make fix
	make lint

splash:
	dart run flutter_native_splash:create

icon:
	dart run flutter_launcher_icons

setup_hooks:
	sh scripts/setup-hooks.sh