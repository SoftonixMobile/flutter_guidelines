.PHONY: get upgrade build build_data watch lang sort fix format lint refactor splash icon setup_hooks

# Use fvm when the project pins a Flutter version (.fvmrc) and fvm is installed
FVM := $(if $(and $(wildcard .fvmrc),$(shell command -v fvm 2>/dev/null)),fvm )
DART := $(FVM)dart

get:
	$(DART) pub get

upgrade:
	$(DART) pub upgrade

build:
	$(DART) run build_runner build --delete-conflicting-outputs

build_data:
	cd packages/data_provider && $(DART) run build_runner build --delete-conflicting-outputs
	$(DART) format packages/data_provider/lib/src/injector/inject_package.module.dart

watch:
	$(DART) run build_runner watch --delete-conflicting-outputs

lang:
	$(DART) run stx_easy_localization_generator:generate -O lib/presentation/localization
	$(DART) run stx_easy_localization_generator:generate -f keys -O lib/presentation/localization -o locale_keys.g.dart

sort:
	$(DART) run tidy_imports

fix:
	$(DART) fix --apply

format:
	$(DART) format bin lib packages test
	make lang

lint:
	$(DART) analyze --fatal-infos .
	# $(DART) analyze | grep -E "error -|warning -" || true

refactor:
	make build
	make lang
	make fix
	make format
	make sort
	make lint

splash:
	$(DART) run flutter_native_splash:create

icon:
	$(DART) run flutter_launcher_icons

setup_hooks:
	sh scripts/setup-hooks.sh