# frozen_string_literal: true

# name: discourse-sync-to-custom-field
# about: TODO
# meta_topic_id: TODO
# version: 0.0.1
# authors: Discourse
# url: TODO
# required_version: 2.7.0

enabled_site_setting :discourse_sync_to_custom_field_enabled

module ::DiscourseSyncToCustomField
  PLUGIN_NAME = "discourse-sync-to-custom-field"
end

require_relative "lib/discourse_sync_to_custom_field/engine"

after_initialize do
  # Code which should run after Rails has finished booting
end
