#!/usr/bin/env ruby

# =============================================================================
# Flutter iOS Config Update Script
# =============================================================================
# Updates bundle identifier and display name for any number of flavors.
#
# Usage:
#   ruby update-ios-config.rb \
#     --project ios/Runner.xcodeproj \
#     --flavors '[
#       {"suffix": "dev", "bundle_id": "com.example.app.dev", "display_name": "MyApp Dev"},
#       {"suffix": "staging", "bundle_id": "com.example.app.staging", "display_name": "MyApp Staging"},
#       {"suffix": "prod", "bundle_id": "com.example.app", "display_name": "MyApp"}
#     ]'
#
# Each flavor object requires "suffix" (matches build configurations ending
# with "-{suffix}"). "bundle_id" and "display_name" are optional — omit to
# leave unchanged.
# =============================================================================

require 'xcodeproj'
require 'optparse'
require 'json'

# ---------------------------------------------------------------------------
# 1. Parse arguments
# ---------------------------------------------------------------------------
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: ruby update-ios-config.rb [options]"

  opts.on("--project PATH", "Path to .xcodeproj (default: ios/Runner.xcodeproj)") do |v|
    options[:project] = v
  end
  opts.on("--flavors JSON", "JSON array of flavor configs (each with suffix, bundle_id, display_name)") do |v|
    options[:flavors] = v
  end
end.parse!

PROJECT_PATH = options[:project] || 'ios/Runner.xcodeproj'

# ---------------------------------------------------------------------------
# 2. Parse flavors
# ---------------------------------------------------------------------------
unless options[:flavors]
  puts "Error: --flavors is required."
  puts "Example: --flavors '[{\"suffix\": \"dev\", \"bundle_id\": \"com.example.app.dev\", \"display_name\": \"Dev App\"}]'"
  exit 1
end

begin
  flavors = JSON.parse(options[:flavors])
rescue JSON::ParserError => e
  puts "Error: Invalid JSON for --flavors: #{e.message}"
  exit 1
end

unless flavors.is_a?(Array) && flavors.all? { |f| f.is_a?(Hash) && f['suffix'] }
  puts "Error: --flavors must be a JSON array of objects, each with at least a \"suffix\" key."
  exit 1
end

puts "=" * 60
puts "Flutter iOS Flavor Update"
puts "=" * 60
puts "Project: #{PROJECT_PATH}"
puts "Flavors: #{flavors.length}"
flavors.each do |f|
  puts "  -#{f['suffix']}: bundle_id=#{f['bundle_id'] || '(unchanged)'}, display_name=#{f['display_name'] || '(unchanged)'}"
end
puts "=" * 60
puts ""

# ---------------------------------------------------------------------------
# 3. Open project
# ---------------------------------------------------------------------------
project = Xcodeproj::Project.open(PROJECT_PATH)

# ---------------------------------------------------------------------------
# 4. Build suffix → settings map
# ---------------------------------------------------------------------------
flavor_settings = {}
flavors.each do |f|
  suffix = "-#{f['suffix']}"
  flavor_settings[suffix] = {
    bundle_id: f['bundle_id'],
    display_name: f['display_name'],
  }
end

# ---------------------------------------------------------------------------
# 5. Update build settings
# ---------------------------------------------------------------------------
puts "[Step 1] Updating build settings..."

updated_count = 0
project.targets.each do |target|
  target.build_configurations.each do |config|
    flavor_settings.each do |suffix, settings|
      next unless config.name.end_with?(suffix)

      if settings[:bundle_id]
        config.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] = settings[:bundle_id]
      end
      if settings[:display_name]
        config.build_settings['DISPLAY_NAME'] = settings[:display_name]
      end
      puts "  Target '#{target.name}' / #{config.name}: bundle=#{settings[:bundle_id] || '(unchanged)'}, name=#{settings[:display_name] || '(unchanged)'}"
      updated_count += 1
    end
  end
end

if updated_count == 0
  puts "  WARNING: No build configurations matched the provided suffixes."
  puts "  Make sure your build configurations are named like Debug-dev, Release-prod, etc."
else
  puts "  Updated #{updated_count} build configuration(s)."
end
puts ""

# ---------------------------------------------------------------------------
# 6. Save project
# ---------------------------------------------------------------------------
puts "[Step 2] Saving project..."
project.save
puts "  Project saved."
puts ""

# ---------------------------------------------------------------------------
# 7. Summary
# ---------------------------------------------------------------------------
puts "=" * 60
puts "DONE! Summary of changes:"
puts "=" * 60
puts ""
puts "Build Configurations updated:"
flavors.each do |f|
  puts "  *-#{f['suffix']} => #{f['bundle_id'] || '(unchanged)'} (#{f['display_name'] || '(unchanged)'})"
end
puts ""
puts "Flutter usage:"
flavors.each do |f|
  puts "  flutter run --flavor #{f['suffix']}"
end
puts ""
puts "=" * 60
