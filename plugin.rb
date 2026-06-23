# frozen_string_literal: true

# name: discourse-sync-to-custom-field
# about: sync email address to custom field
# meta_topic_id: TODO
# version: 0.0.1
# authors: Jay Pfaffman
# url: TODO
# required_version: 2.7.0

enabled_site_setting :discourse_sync_to_custom_field_enabled

module ::DiscourseSyncToCustomField
  PLUGIN_NAME = "discourse-sync-to-custom-field"
end

require_relative "lib/discourse_sync_to_custom_field/engine"
after_initialize do
  self.add_model_callback(UserEmail, :after_commit, on: %i[create update]) do
    next if !SiteSetting.discourse_sync_to_custom_field_enabled

    custom_field =
      UserField.find_by(name: SiteSetting.discourse_sync_to_custom_field_custom_email_field)
    next if custom_field.nil?
    next if !self.primary?

    user_field_name = "user_field_#{custom_field.id}"
    ucf = UserCustomField.find_or_create_by(name: user_field_name, user_id: self.user_id)
    ucf.update(value: self.email)
  end

  self.add_model_callback(UserProfile, :after_commit, on: %i[create update]) do
    next if !SiteSetting.discourse_sync_to_custom_field_enabled

    custom_field =
      UserField.find_by(name: SiteSetting.discourse_sync_to_custom_field_custom_location_field)
    next if custom_field.nil?
    next if self.location.blank?

    location = self.location
    location = DiscourseSyncToCustomField::ReplaceStateCodes.replace_state_codes(location)

    user_field_name = "user_field_#{custom_field.id}"
    ucf = UserCustomField.find_or_create_by(name: user_field_name, user_id: self.user_id)
    ucf.update(value: location)
  end
end
