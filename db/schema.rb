# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141002114659) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "archivalimage_translations", force: true do |t|
    t.integer  "archivalimage_id", null: false
    t.string   "locale",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "caption"
  end

  add_index "archivalimage_translations", ["archivalimage_id"], name: "index_archivalimage_translations_on_archivalimage_id", using: :btree
  add_index "archivalimage_translations", ["locale"], name: "index_archivalimage_translations_on_locale", using: :btree

  create_table "archivalimages", force: true do |t|
    t.integer  "subsite_id"
    t.string   "image"
    t.integer  "image_size"
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_content_type"
    t.integer  "event_id"
    t.integer  "festival_id"
    t.integer  "page_id"
    t.integer  "flickr_id"
    t.integer  "project_id"
    t.string   "credit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "archivalimages", ["event_id"], name: "index_archivalimages_on_event_id", using: :btree
  add_index "archivalimages", ["festival_id"], name: "index_archivalimages_on_festival_id", using: :btree
  add_index "archivalimages", ["page_id"], name: "index_archivalimages_on_page_id", using: :btree
  add_index "archivalimages", ["project_id"], name: "index_archivalimages_on_project_id", using: :btree

  create_table "attachments", force: true do |t|
    t.string   "attachedfile"
    t.string   "attachedfile_content_type"
    t.integer  "attachedfile_size",         limit: 8
    t.string   "item_type"
    t.integer  "item_id"
    t.string   "title"
    t.text     "description"
    t.boolean  "public"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["item_type", "item_id"], name: "index_attachments_on_item_type_and_item_id", using: :btree

  create_table "attendees", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.text     "url"
    t.string   "email"
    t.string   "phone"
    t.string   "picture"
    t.integer  "picture_size"
    t.string   "picture_content_type"
    t.integer  "picture_width"
    t.integer  "picture_height"
    t.boolean  "status"
    t.text     "extra"
    t.string   "country"
    t.string   "attachment_url"
    t.text     "address"
    t.string   "organisation"
    t.string   "project_name"
    t.text     "project_description"
    t.text     "project_creators"
    t.text     "project_presenters"
    t.text     "project_urls"
    t.text     "motivation_statement"
    t.string   "project_title"
    t.string   "project_keywords"
    t.integer  "event_id"
    t.integer  "festival_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_id"
    t.string   "item_type"
  end

  add_index "attendees", ["event_id"], name: "index_attendees_on_event_id", using: :btree
  add_index "attendees", ["festival_id"], name: "index_attendees_on_festival_id", using: :btree
  add_index "attendees", ["user_id"], name: "index_attendees_on_user_id", using: :btree

  create_table "authentications", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "authentications", ["user_id", "provider", "uid"], name: "index_authentications_on_user_id_and_provider_and_uid", unique: true, using: :btree
  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "documenttype_hierarchies", id: false, force: true do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "documenttype_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "documenttype_anc_desc_udx", unique: true, using: :btree
  add_index "documenttype_hierarchies", ["descendant_id"], name: "documenttype_desc_idx", using: :btree

  create_table "documenttypes", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dynamictaglines", force: true do |t|
    t.integer  "subsite_id",  null: false
    t.text     "festival"
    t.text     "electronic"
    t.text     "art"
    t.text     "subcultures"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dynamictaglines", ["subsite_id"], name: "index_dynamictaglines_on_subsite_id", using: :btree

  create_table "etherpads", force: true do |t|
    t.string   "name"
    t.string   "read_only_id"
    t.boolean  "deleted",         default: false, null: false
    t.datetime "last_edited"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "private_pad"
    t.integer  "documenttype_id"
  end

  create_table "etherpads_events", id: false, force: true do |t|
    t.integer "etherpad_id", null: false
    t.integer "event_id",    null: false
  end

  add_index "etherpads_events", ["etherpad_id"], name: "index_etherpads_events_on_etherpad_id", using: :btree
  add_index "etherpads_events", ["event_id"], name: "index_etherpads_events_on_event_id", using: :btree

  create_table "etherpads_festivals", id: false, force: true do |t|
    t.integer "etherpad_id", null: false
    t.integer "festival_id", null: false
  end

  add_index "etherpads_festivals", ["etherpad_id"], name: "index_etherpads_festivals_on_etherpad_id", using: :btree
  add_index "etherpads_festivals", ["festival_id"], name: "index_etherpads_festivals_on_festival_id", using: :btree

  create_table "etherpads_projects", id: false, force: true do |t|
    t.integer "etherpad_id"
    t.integer "project_id"
  end

  create_table "etherpads_subsites", id: false, force: true do |t|
    t.integer "etherpad_id"
    t.integer "subsite_id"
  end

  create_table "event_translations", force: true do |t|
    t.integer  "event_id",    null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
    t.text     "notes"
  end

  add_index "event_translations", ["event_id"], name: "index_event_translations_on_event_id", using: :btree
  add_index "event_translations", ["locale"], name: "index_event_translations_on_locale", using: :btree

  create_table "events", force: true do |t|
    t.integer  "subsite_id"
    t.integer  "place_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean  "published"
    t.string   "image"
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_content_type"
    t.integer  "image_size",                   limit: 8
    t.text     "facebook_link"
    t.float    "cost"
    t.float    "cost_alternate"
    t.string   "cost_alternate_reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.string   "facilitator_name"
    t.string   "facilitator_url"
    t.string   "facilitator_organisation"
    t.string   "facilitator_organisation_url"
    t.integer  "project_id"
    t.integer  "festival_id"
    t.integer  "step_id"
    t.integer  "user_id",                                default: 0, null: false
    t.integer  "max_attendees"
    t.integer  "eventr_id"
  end

  add_index "events", ["place_id"], name: "index_events_on_place_id", using: :btree
  add_index "events", ["subsite_id"], name: "index_events_on_subsite_id", using: :btree

  create_table "feeds", force: true do |t|
    t.string   "item_type"
    t.integer  "item_id"
    t.integer  "subsite_id"
    t.datetime "fed_at"
    t.string   "action"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feeds", ["item_id"], name: "index_feeds_on_item_id", using: :btree
  add_index "feeds", ["subsite_id"], name: "index_feeds_on_subsite_id", using: :btree
  add_index "feeds", ["user_id"], name: "index_feeds_on_user_id", using: :btree

  create_table "festival_translations", force: true do |t|
    t.integer  "festival_id",   null: false
    t.string   "locale",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "overview_text"
  end

  add_index "festival_translations", ["festival_id"], name: "index_festival_translations_on_festival_id", using: :btree
  add_index "festival_translations", ["locale"], name: "index_festival_translations_on_locale", using: :btree

  create_table "festivals", force: true do |t|
    t.string   "name"
    t.date     "start_at"
    t.date     "end_at"
    t.string   "website"
    t.string   "slug"
    t.integer  "node_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subtitle"
    t.string   "image"
    t.integer  "image_height"
    t.integer  "image_width"
    t.integer  "image_size"
    t.string   "image_content_type"
    t.string   "background_colour"
    t.string   "primary_colour"
    t.integer  "eventr_id"
  end

  create_table "flickrsets", force: true do |t|
    t.integer  "flickr_id",          limit: 8
    t.string   "title"
    t.text     "description"
    t.date     "start_upload_date"
    t.date     "last_modified_date"
    t.integer  "subsite_id",                   null: false
    t.integer  "event_id"
    t.integer  "project_id"
    t.integer  "festival_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flickrsets", ["event_id"], name: "index_flickrsets_on_event_id", using: :btree
  add_index "flickrsets", ["festival_id"], name: "index_flickrsets_on_festival_id", using: :btree
  add_index "flickrsets", ["flickr_id"], name: "index_flickrsets_on_flickr_id", unique: true, using: :btree
  add_index "flickrsets", ["project_id"], name: "index_flickrsets_on_project_id", using: :btree
  add_index "flickrsets", ["subsite_id"], name: "index_flickrsets_on_subsite_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "frontitems", force: true do |t|
    t.string   "item_type"
    t.integer  "item_id"
    t.integer  "position"
    t.string   "external_url"
    t.string   "background_colour",     default: "f05a28",    null: false
    t.string   "text_colour",           default: "FFFFFF",    null: false
    t.boolean  "active"
    t.integer  "frontmodule_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subsite_id"
    t.string   "bigimage"
    t.integer  "bigimage_size"
    t.integer  "bigimage_width"
    t.integer  "bigimage_height"
    t.string   "bigimage_content_type"
    t.string   "seconditem_type"
    t.string   "seconditem_id"
    t.string   "custom_title"
    t.string   "custom_follow_text",    default: "Read more", null: false
  end

  add_index "frontitems", ["item_id", "item_type"], name: "index_frontitems_on_item_id_and_item_type", using: :btree
  add_index "frontitems", ["seconditem_id", "seconditem_type"], name: "index_frontitems_on_seconditem_id_and_seconditem_type", using: :btree

  create_table "frontmodules", force: true do |t|
    t.string   "name"
    t.string   "partial_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "exampleimage"
  end

  create_table "node_translations", force: true do |t|
    t.integer  "node_id",     null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  add_index "node_translations", ["locale"], name: "index_node_translations_on_locale", using: :btree
  add_index "node_translations", ["node_id"], name: "index_node_translations_on_node_id", using: :btree

  create_table "nodes", force: true do |t|
    t.string   "name"
    t.string   "website"
    t.string   "city"
    t.string   "country"
    t.string   "slug"
    t.string   "logo"
    t.string   "logo_content_type"
    t.integer  "logo_height"
    t.integer  "logo_width"
    t.integer  "logo_size",         limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nodes_subsites", id: false, force: true do |t|
    t.integer "node_id"
    t.integer "subsite_id"
  end

  create_table "page_hierarchies", id: false, force: true do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "page_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "page_anc_desc_udx", unique: true, using: :btree
  add_index "page_hierarchies", ["descendant_id"], name: "page_desc_idx", using: :btree

  create_table "page_translations", force: true do |t|
    t.integer  "page_id",    null: false
    t.string   "locale",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "body"
  end

  add_index "page_translations", ["locale"], name: "index_page_translations_on_locale", using: :btree
  add_index "page_translations", ["page_id"], name: "index_page_translations_on_page_id", using: :btree

  create_table "pages", force: true do |t|
    t.text     "slug"
    t.integer  "subsite_id"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "wordpress_id"
    t.string   "wordpress_author"
    t.string   "wordpress_scope"
    t.integer  "festival_id"
    t.integer  "project_id"
    t.integer  "sort_order"
  end

  add_index "pages", ["festival_id"], name: "index_pages_on_festival_id", using: :btree
  add_index "pages", ["project_id"], name: "index_pages_on_project_id", using: :btree

  create_table "photos", force: true do |t|
    t.string   "filename"
    t.integer  "filename_width"
    t.integer  "filename_height"
    t.string   "filename_content_type"
    t.integer  "filename_size",         limit: 8
    t.integer  "wordpress_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "item_type"
    t.integer  "item_id"
    t.string   "wordpress_scope"
  end

  add_index "photos", ["item_type", "item_id"], name: "index_photos_on_item_type_and_item_id", using: :btree

  create_table "place_translations", force: true do |t|
    t.integer  "place_id",   null: false
    t.string   "locale",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "place_translations", ["locale"], name: "index_place_translations_on_locale", using: :btree
  add_index "place_translations", ["place_id"], name: "index_place_translations_on_place_id", using: :btree

  create_table "places", force: true do |t|
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "country"
    t.string   "postcode"
    t.decimal  "latitude",   precision: 10, scale: 6
    t.decimal  "longitude",  precision: 10, scale: 6
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "post_categories", force: true do |t|
    t.string   "name"
    t.integer  "wordpress_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_translations", force: true do |t|
    t.integer  "post_id",    null: false
    t.string   "locale",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "body"
    t.text     "excerpt"
  end

  add_index "post_translations", ["locale"], name: "index_post_translations_on_locale", using: :btree
  add_index "post_translations", ["post_id"], name: "index_post_translations_on_post_id", using: :btree

  create_table "posts", force: true do |t|
    t.string   "slug"
    t.integer  "subsite_id"
    t.boolean  "published"
    t.integer  "creator_id"
    t.integer  "last_modified_id"
    t.datetime "published_at"
    t.integer  "wordpress_id"
    t.string   "image"
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_content_type"
    t.integer  "image_size",         limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "wordpress_author"
    t.string   "wordpress_scope"
    t.integer  "event_id"
    t.integer  "project_id"
    t.integer  "festival_id"
    t.boolean  "external",                     default: false, null: false
    t.integer  "eventr_id"
  end

  add_index "posts", ["subsite_id"], name: "index_posts_on_subsite_id", using: :btree

  create_table "posts_post_categories", id: false, force: true do |t|
    t.integer "post_id"
    t.integer "post_category_id"
  end

  create_table "project_hierarchies", id: false, force: true do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "project_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "project_anc_desc_udx", unique: true, using: :btree
  add_index "project_hierarchies", ["descendant_id"], name: "project_desc_idx", using: :btree

  create_table "project_translations", force: true do |t|
    t.integer  "project_id",  null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  add_index "project_translations", ["locale"], name: "index_project_translations_on_locale", using: :btree
  add_index "project_translations", ["project_id"], name: "index_project_translations_on_project_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "website"
    t.integer  "evolvedfrom_id"
    t.integer  "evolution_year"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "step_translations", force: true do |t|
    t.integer  "step_id",     null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  add_index "step_translations", ["locale"], name: "index_step_translations_on_locale", using: :btree
  add_index "step_translations", ["step_id"], name: "index_step_translations_on_step_id", using: :btree

  create_table "steps", force: true do |t|
    t.integer  "subsite_id"
    t.integer  "festival_id"
    t.integer  "node_id"
    t.date     "start_at"
    t.date     "end_at"
    t.string   "name"
    t.integer  "number"
    t.integer  "event_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "steps", ["event_id"], name: "index_steps_on_event_id", using: :btree
  add_index "steps", ["festival_id"], name: "index_steps_on_festival_id", using: :btree
  add_index "steps", ["node_id"], name: "index_steps_on_node_id", using: :btree
  add_index "steps", ["subsite_id"], name: "index_steps_on_subsite_id", using: :btree

  create_table "subsites", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "subdomain"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "videohosts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.string   "hostid"
    t.string   "thumbnail"
    t.integer  "thumbnail_size",         limit: 8
    t.integer  "thumbnail_width"
    t.integer  "thumbnail_height"
    t.string   "thumbnail_content_type"
    t.integer  "event_id"
    t.integer  "project_id"
    t.integer  "festival_id"
    t.integer  "video_width"
    t.integer  "video_height"
    t.integer  "duration"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "videos", ["event_id"], name: "index_videos_on_event_id", using: :btree
  add_index "videos", ["festival_id"], name: "index_videos_on_festival_id", using: :btree
  add_index "videos", ["project_id"], name: "index_videos_on_project_id", using: :btree

end
