# frozen_string_literal: true

# Parts of the core features examples can be skipped like so:
#   it_behaves_like "having working core features", skip_examples: %i[login likes]
#
# List of keywords for skipping examples:
# login, likes, profile, topics, topics:read, topics:reply, topics:create,
# search, search:quick_search, search:full_page
#
# For more details, see https://meta.discourse.org/t/-/361381

RSpec.describe "Email updates ", type: :system do
  fab!(:user) { Fabricate(:user, last_seen_at: 11.minutes.ago, refresh_auto_groups: true) }
  #  UserField.all.destroy_all
  user_field =
    UserField.find_or_create_by(
      name: SiteSetting.discourse_sync_to_custom_field_custom_email_field,
      field_type: "text",
      editable: true,
      show_on_profile: true,
      description: "Email",
    )
  before { enable_current_plugin }

  it "creates the custom field when the email is changed" do
    user_email = user.user_emails.find_by(primary: true)
    user_email.update!(email: "new_email@example.com")
    user.reload
    expect(user.custom_fields["user_field_#{user_field.id}"]).to eq("new_email@example.com")
  end

  it "updates the custom field when the email is changed" do
    user.custom_fields["user_field_#{user_field.id}"] = "old_email@example.com"
    user.save
    user_email = user.user_emails.find_by(primary: true)
    user_email.update!(email: "new_email@example.com")
    user.reload
    expect(user.custom_fields["user_field_#{user_field.id}"]).to eq("new_email@example.com")
  end
end
