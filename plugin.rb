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
  # Code which should run after Rails has finished booting
  self.add_model_callback(UserEmail, :after_save) do
    if SiteSetting.discourse_sync_to_custom_field_enabled
      custom_field =
        UserField.find_by(name: SiteSetting.discourse_sync_to_custom_field_custom_email_field)
      if custom_field.present?
        return if !self.primary?
        email = self.email
        user_field_name = "user_field_#{custom_field.id}"
        ucf = UserCustomField.find_or_create_by(name: user_field_name, user_id: self.user.id)
        ucf.value = self.email
        ucf.save!
      end
    end
  end

  self.add_model_callback(UserProfile, :after_save) do
    if SiteSetting.discourse_sync_to_custom_field_enabled
      puts "In after_save callback for UserProfile #{self.inspect} -- #{SiteSetting.discourse_sync_to_custom_field_enabled.inspect}"
      custom_field =
        UserField.find_by(name: SiteSetting.discourse_sync_to_custom_field_custom_location_field)
      puts "All user fields: #{UserField.all.inspect}"
      if custom_field.present?
        puts "--------> Syncing location to custom field #{custom_field.inspect} -- #{SiteSetting.discourse_sync_to_custom_field_custom_location_field.inspect}"
        location = self.location
        user_field_name = "user_field_#{custom_field.id}"
        ucf = UserCustomField.find_or_create_by(name: user_field_name, user_id: self.user.id)
        ucf.value = location
        ucf.save!
        puts "--------> Set #{user_field_name} to #{location} for user #{self.user.username}"
      end
    end
  end
end
