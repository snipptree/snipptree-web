br:
	@echo "Starting Build Runner..."
	dart run build_runner build
	@echo "Build Runner Completed Successfully!"

brd:
	@echo "Starting Build Runner with --delete-conflicting-outputs..."
	dart run build_runner build --delete-conflicting-outputs
	@echo "Build Runner Completed Successfully!"

run:
	@echo "Starting SnippTree on PORT 5000"
	flutter run -d chrome --web-renderer html --web-port=5000

clean:
	@echo "Cleaning project and getting dependencies.."
	flutter clean && flutter pub get

deploy:
	@echo "Building flutter web and deploying to firebase"
	flutter build web && firebase deploy
