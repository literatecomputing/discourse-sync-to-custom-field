# frozen_string_literal: true

DiscourseSyncToCustomField::Engine.routes.draw do
  get "/examples" => "examples#index"
  # define routes here
end

Discourse::Application.routes.draw do
  mount ::DiscourseSyncToCustomField::Engine, at: "discourse-sync-to-custom-field"
end
