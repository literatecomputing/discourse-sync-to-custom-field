# frozen_string_literal: true

# Parts of the core features examples can be skipped like so:
#   it_behaves_like "having working core features", skip_examples: %i[login likes]
#
# List of keywords for skipping examples:
# login, likes, profile, topics, topics:read, topics:reply, topics:create,
# search, search:quick_search, search:full_page
#
# For more details, see https://meta.discourse.org/t/-/361381

RSpec.describe "Profile Location", type: :system do
  fab!(:user) { Fabricate(:user, last_seen_at: 11.minutes.ago, refresh_auto_groups: true) }
  user_location_field =
    UserField.find_or_create_by(
      name: SiteSetting.discourse_sync_to_custom_field_custom_location_field,
      field_type: "text",
      editable: true,
      show_on_profile: true,
      description: "Address",
    )

  before { enable_current_plugin }

  it "updates updates location field when location is changed" do
    user.custom_fields["user_field_#{user_location_field.id}"] = "My Old Address"
    user.save
    user.reload
    expect(user.custom_fields["user_field_#{user_location_field.id}"]).to eq("My Old Address")
    user.user_profile.location = "My New Address"
    user.user_profile.save
    user.reload
    user.user_profile.reload
    expect(user.custom_fields["user_field_#{user_location_field.id}"]).to eq("My New Address")
  end

  it "replaces state codes in the location field" do
    user.user_profile.location = "My New Address, CA"
    user.user_profile.save
    user.reload
    expect(user.custom_fields["user_field_#{user_location_field.id}"]).to eq("My New Address, California")
  end
end
