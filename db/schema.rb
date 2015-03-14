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

ActiveRecord::Schema.define(version: 20150314144239) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "archivalimage_translations", force: :cascade do |t|
    t.integer  "archivalimage_id",             null: false
    t.string   "locale",           limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "caption",          limit: 255
  end

  add_index "archivalimage_translations", ["archivalimage_id"], name: "index_archivalimage_translations_on_archivalimage_id", using: :btree
  add_index "archivalimage_translations", ["locale"], name: "index_archivalimage_translations_on_locale", using: :btree

  create_table "archivalimages", force: :cascade do |t|
    t.integer  "subsite_id"
    t.string   "image",              limit: 255
    t.integer  "image_size"
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_content_type", limit: 255
    t.integer  "event_id"
    t.integer  "festival_id"
    t.integer  "page_id"
    t.integer  "flickr_id"
    t.integer  "project_id"
    t.string   "credit",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "image_date"
    t.boolean  "cover_right",                    default: false, null: false
  end

  add_index "archivalimages", ["event_id"], name: "index_archivalimages_on_event_id", using: :btree
  add_index "archivalimages", ["festival_id"], name: "index_archivalimages_on_festival_id", using: :btree
  add_index "archivalimages", ["page_id"], name: "index_archivalimages_on_page_id", using: :btree
  add_index "archivalimages", ["project_id"], name: "index_archivalimages_on_project_id", using: :btree

  create_table "attachments", force: :cascade do |t|
    t.string   "attachedfile",              limit: 255
    t.string   "attachedfile_content_type", limit: 255
    t.integer  "attachedfile_size",         limit: 8
    t.string   "item_type",                 limit: 255
    t.integer  "item_id"
    t.string   "title",                     limit: 255
    t.text     "description"
    t.boolean  "public"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "documenttype_id"
    t.integer  "year_of_publication"
  end

  add_index "attachments", ["documenttype_id"], name: "index_attachments_on_documenttype_id", using: :btree
  add_index "attachments", ["item_type", "item_id"], name: "index_attachments_on_item_type_and_item_id", using: :btree

  create_table "attendees", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",                 limit: 255
    t.text     "description"
    t.text     "url"
    t.string   "email",                limit: 255
    t.string   "phone",                limit: 255
    t.string   "picture",              limit: 255
    t.integer  "picture_size"
    t.string   "picture_content_type", limit: 255
    t.integer  "picture_width"
    t.integer  "picture_height"
    t.boolean  "status"
    t.text     "extra"
    t.string   "country",              limit: 255
    t.string   "attachment_url",       limit: 255
    t.text     "address"
    t.string   "organisation",         limit: 255
    t.string   "project_name",         limit: 255
    t.text     "project_description"
    t.text     "project_creators"
    t.text     "project_presenters"
    t.text     "project_urls"
    t.text     "motivation_statement"
    t.string   "project_title",        limit: 255
    t.string   "project_keywords",     limit: 255
    t.integer  "event_id"
    t.integer  "festival_id"
    t.string   "slug",                 limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_id"
    t.string   "item_type",            limit: 255
  end

  add_index "attendees", ["event_id"], name: "index_attendees_on_event_id", using: :btree
  add_index "attendees", ["festival_id"], name: "index_attendees_on_festival_id", using: :btree
  add_index "attendees", ["user_id"], name: "index_attendees_on_user_id", using: :btree

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",   limit: 255
  end

  add_index "authentications", ["user_id", "provider", "uid"], name: "index_authentications_on_user_id_and_provider_and_uid", unique: true, using: :btree
  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255,                 null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "wordpress_url"
    t.boolean  "missing",                       default: false, null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "item_id"
    t.string   "item_type",               limit: 255
    t.integer  "user_id"
    t.text     "content"
    t.string   "image",                   limit: 255
    t.integer  "image_width"
    t.string   "image_content_type",      limit: 255
    t.integer  "image_size"
    t.integer  "image_height"
    t.string   "attachment",              limit: 255
    t.integer  "attachment_size"
    t.string   "attachment_content_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["item_id", "item_type"], name: "index_comments_on_item_id_and_item_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "document_translations", force: :cascade do |t|
    t.integer  "document_id", null: false
    t.string   "locale",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "title"
    t.text     "description"
  end

  add_index "document_translations", ["document_id"], name: "index_document_translations_on_document_id", using: :btree
  add_index "document_translations", ["locale"], name: "index_document_translations_on_locale", using: :btree

  create_table "documents", force: :cascade do |t|
    t.date     "date_of_release"
    t.integer  "subsite_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "documenttype_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "documenttype_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "documenttype_anc_desc_udx", unique: true, using: :btree
  add_index "documenttype_hierarchies", ["descendant_id"], name: "documenttype_desc_idx", using: :btree

  create_table "documenttypes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dynamictaglines", force: :cascade do |t|
    t.integer  "subsite_id",  null: false
    t.text     "festival"
    t.text     "electronic"
    t.text     "art"
    t.text     "subcultures"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dynamictaglines", ["subsite_id"], name: "index_dynamictaglines_on_subsite_id", using: :btree

  create_table "etherpads", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "read_only_id",    limit: 255
    t.boolean  "deleted",                     default: false, null: false
    t.datetime "last_edited"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "private_pad"
    t.integer  "documenttype_id"
  end

  create_table "etherpads_events", id: false, force: :cascade do |t|
    t.integer "etherpad_id", null: false
    t.integer "event_id",    null: false
  end

  add_index "etherpads_events", ["etherpad_id"], name: "index_etherpads_events_on_etherpad_id", using: :btree
  add_index "etherpads_events", ["event_id"], name: "index_etherpads_events_on_event_id", using: :btree

  create_table "etherpads_festivals", id: false, force: :cascade do |t|
    t.integer "etherpad_id", null: false
    t.integer "festival_id", null: false
  end

  add_index "etherpads_festivals", ["etherpad_id"], name: "index_etherpads_festivals_on_etherpad_id", using: :btree
  add_index "etherpads_festivals", ["festival_id"], name: "index_etherpads_festivals_on_festival_id", using: :btree

  create_table "etherpads_projects", id: false, force: :cascade do |t|
    t.integer "etherpad_id"
    t.integer "project_id"
  end

  create_table "etherpads_subsites", id: false, force: :cascade do |t|
    t.integer "etherpad_id"
    t.integer "subsite_id"
  end

  create_table "event_translations", force: :cascade do |t|
    t.integer  "event_id",                null: false
    t.string   "locale",      limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",        limit: 255
    t.text     "description"
    t.text     "notes"
  end

  add_index "event_translations", ["event_id"], name: "index_event_translations_on_event_id", using: :btree
  add_index "event_translations", ["locale"], name: "index_event_translations_on_locale", using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "subsite_id"
    t.integer  "place_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean  "published"
    t.string   "image",                        limit: 255
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_content_type",           limit: 255
    t.integer  "image_size",                   limit: 8
    t.text     "facebook_link"
    t.float    "cost"
    t.float    "cost_alternate"
    t.string   "cost_alternate_reason",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",                         limit: 255
    t.string   "facilitator_name",             limit: 255
    t.string   "facilitator_url",              limit: 255
    t.string   "facilitator_organisation",     limit: 255
    t.string   "facilitator_organisation_url", limit: 255
    t.integer  "project_id"
    t.integer  "festival_id"
    t.integer  "step_id"
    t.integer  "user_id",                                  default: 0, null: false
    t.integer  "max_attendees"
    t.integer  "eventr_id"
    t.text     "resources_needed"
    t.text     "protocol"
    t.integer  "residency_id"
    t.integer  "festivaltheme_id"
  end

  add_index "events", ["place_id"], name: "index_events_on_place_id", using: :btree
  add_index "events", ["subsite_id"], name: "index_events_on_subsite_id", using: :btree

  create_table "feeds", force: :cascade do |t|
    t.string   "item_type",  limit: 255
    t.integer  "item_id"
    t.integer  "subsite_id"
    t.datetime "fed_at"
    t.string   "action",     limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feeds", ["item_id"], name: "index_feeds_on_item_id", using: :btree
  add_index "feeds", ["subsite_id"], name: "index_feeds_on_subsite_id", using: :btree
  add_index "feeds", ["user_id"], name: "index_feeds_on_user_id", using: :btree

  create_table "festival_translations", force: :cascade do |t|
    t.integer  "festival_id",               null: false
    t.string   "locale",        limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "overview_text"
  end

  add_index "festival_translations", ["festival_id"], name: "index_festival_translations_on_festival_id", using: :btree
  add_index "festival_translations", ["locale"], name: "index_festival_translations_on_locale", using: :btree

  create_table "festivals", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.date     "start_at"
    t.date     "end_at"
    t.string   "website",            limit: 255
    t.string   "slug",               limit: 255
    t.integer  "node_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subtitle",           limit: 255
    t.string   "image",              limit: 255
    t.integer  "image_height"
    t.integer  "image_width"
    t.integer  "image_size"
    t.string   "image_content_type", limit: 255
    t.string   "background_colour",  limit: 255
    t.string   "primary_colour",     limit: 255
    t.integer  "eventr_id"
    t.boolean  "published",                      default: false,               null: false
    t.string   "festivalbackdrop",   limit: 255
    t.string   "festival_location",  limit: 255, default: "Helsinki, Finland", null: false
    t.string   "tertiary_colour",    limit: 255, default: "FFFFFF",            null: false
    t.boolean  "has_listserv",                   default: false,               null: false
    t.string   "listservname"
  end

  create_table "festivaltheme_relations", force: :cascade do |t|
    t.integer "relation_id"
    t.string  "relation_type",    limit: 255
    t.integer "festivaltheme_id"
  end

  add_index "festivaltheme_relations", ["festivaltheme_id"], name: "index_festivaltheme_relations_on_festivaltheme_id", using: :btree
  add_index "festivaltheme_relations", ["relation_id", "relation_type"], name: "index_festivaltheme_relations_on_relation_id_and_relation_type", using: :btree

  create_table "festivaltheme_translations", force: :cascade do |t|
    t.integer  "festivaltheme_id",             null: false
    t.string   "locale",           limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",             limit: 255
    t.text     "description"
  end

  add_index "festivaltheme_translations", ["festivaltheme_id"], name: "index_festivaltheme_translations_on_festivaltheme_id", using: :btree
  add_index "festivaltheme_translations", ["locale"], name: "index_festivaltheme_translations_on_locale", using: :btree

  create_table "festivalthemes", force: :cascade do |t|
    t.integer  "festival_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",        limit: 255
  end

  add_index "festivalthemes", ["festival_id"], name: "index_festivalthemes_on_festival_id", using: :btree

  create_table "flickrsets", force: :cascade do |t|
    t.integer  "flickr_id",          limit: 8
    t.string   "title",              limit: 255
    t.text     "description"
    t.date     "start_upload_date"
    t.date     "last_modified_date"
    t.integer  "subsite_id",                                              null: false
    t.integer  "event_id"
    t.integer  "project_id"
    t.integer  "festival_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "flickr_user",        limit: 255, default: "91330886@N08", null: false
  end

  add_index "flickrsets", ["event_id"], name: "index_flickrsets_on_event_id", using: :btree
  add_index "flickrsets", ["festival_id"], name: "index_flickrsets_on_festival_id", using: :btree
  add_index "flickrsets", ["flickr_id"], name: "index_flickrsets_on_flickr_id", unique: true, using: :btree
  add_index "flickrsets", ["project_id"], name: "index_flickrsets_on_project_id", using: :btree
  add_index "flickrsets", ["subsite_id"], name: "index_flickrsets_on_subsite_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",               null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "frontitem_translations", force: :cascade do |t|
    t.integer  "frontitem_id",       null: false
    t.string   "locale",             null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "custom_title"
    t.string   "custom_follow_text"
  end

  add_index "frontitem_translations", ["frontitem_id"], name: "index_frontitem_translations_on_frontitem_id", using: :btree
  add_index "frontitem_translations", ["locale"], name: "index_frontitem_translations_on_locale", using: :btree

  create_table "frontitems", force: :cascade do |t|
    t.string   "item_type",             limit: 255
    t.integer  "item_id"
    t.integer  "position"
    t.string   "external_url",          limit: 255
    t.string   "background_colour",     limit: 255, default: "f05a28", null: false
    t.string   "text_colour",           limit: 255, default: "FFFFFF", null: false
    t.boolean  "active"
    t.integer  "frontmodule_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subsite_id"
    t.string   "bigimage",              limit: 255
    t.integer  "bigimage_size"
    t.integer  "bigimage_width"
    t.integer  "bigimage_height"
    t.string   "bigimage_content_type", limit: 255
    t.string   "seconditem_type",       limit: 255
    t.string   "seconditem_id",         limit: 255
  end

  add_index "frontitems", ["item_id", "item_type"], name: "index_frontitems_on_item_id_and_item_type", using: :btree
  add_index "frontitems", ["seconditem_id", "seconditem_type"], name: "index_frontitems_on_seconditem_id_and_seconditem_type", using: :btree

  create_table "frontmodules", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "partial_name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "exampleimage", limit: 255
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "year",               limit: 255
    t.boolean  "paid"
    t.boolean  "hallitus"
    t.boolean  "hallitus_alternate"
    t.string   "notes",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["user_id", "year"], name: "index_memberships_on_user_id_and_year", unique: true, using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "node_translations", force: :cascade do |t|
    t.integer  "node_id",                 null: false
    t.string   "locale",      limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  add_index "node_translations", ["locale"], name: "index_node_translations_on_locale", using: :btree
  add_index "node_translations", ["node_id"], name: "index_node_translations_on_node_id", using: :btree

  create_table "nodes", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "website",           limit: 255
    t.string   "city",              limit: 255
    t.string   "country",           limit: 255
    t.string   "slug",              limit: 255
    t.string   "logo",              limit: 255
    t.string   "logo_content_type", limit: 255
    t.integer  "logo_height"
    t.integer  "logo_width"
    t.integer  "logo_size",         limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nodes_subsites", id: false, force: :cascade do |t|
    t.integer "node_id"
    t.integer "subsite_id"
  end

  create_table "page_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "page_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "page_anc_desc_udx", unique: true, using: :btree
  add_index "page_hierarchies", ["descendant_id"], name: "page_desc_idx", using: :btree

  create_table "page_translations", force: :cascade do |t|
    t.integer  "page_id",                null: false
    t.string   "locale",     limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",       limit: 255
    t.text     "body"
  end

  add_index "page_translations", ["locale"], name: "index_page_translations_on_locale", using: :btree
  add_index "page_translations", ["page_id"], name: "index_page_translations_on_page_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.text     "slug"
    t.integer  "subsite_id"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "wordpress_id"
    t.string   "wordpress_author", limit: 255
    t.string   "wordpress_scope",  limit: 255
    t.integer  "festival_id"
    t.integer  "project_id"
    t.integer  "sort_order"
    t.integer  "festivaltheme_id"
  end

  add_index "pages", ["festival_id"], name: "index_pages_on_festival_id", using: :btree
  add_index "pages", ["project_id"], name: "index_pages_on_project_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.string   "filename",              limit: 255
    t.integer  "filename_width"
    t.integer  "filename_height"
    t.string   "filename_content_type", limit: 255
    t.integer  "filename_size",         limit: 8
    t.integer  "wordpress_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "item_type",             limit: 255
    t.integer  "item_id"
    t.string   "wordpress_scope",       limit: 255
    t.string   "title",                 limit: 255
    t.string   "credit",                limit: 255
    t.date     "image_date"
  end

  add_index "photos", ["item_type", "item_id"], name: "index_photos_on_item_type_and_item_id", using: :btree

  create_table "place_translations", force: :cascade do |t|
    t.integer  "place_id",               null: false
    t.string   "locale",     limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",       limit: 255
  end

  add_index "place_translations", ["locale"], name: "index_place_translations_on_locale", using: :btree
  add_index "place_translations", ["place_id"], name: "index_place_translations_on_place_id", using: :btree

  create_table "places", force: :cascade do |t|
    t.string   "address1",   limit: 255
    t.string   "address2",   limit: 255
    t.string   "city",       limit: 255
    t.string   "country",    limit: 255
    t.string   "postcode",   limit: 255
    t.decimal  "latitude",               precision: 10, scale: 6
    t.decimal  "longitude",              precision: 10, scale: 6
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",       limit: 255
  end

  create_table "post_categories", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.integer  "wordpress_id"
    t.string   "slug",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_translations", force: :cascade do |t|
    t.integer  "post_id",                null: false
    t.string   "locale",     limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",      limit: 255
    t.text     "body"
    t.text     "excerpt"
  end

  add_index "post_translations", ["locale"], name: "index_post_translations_on_locale", using: :btree
  add_index "post_translations", ["post_id"], name: "index_post_translations_on_post_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "slug",               limit: 255
    t.integer  "subsite_id"
    t.boolean  "published"
    t.integer  "creator_id"
    t.integer  "last_modified_id"
    t.datetime "published_at"
    t.integer  "wordpress_id"
    t.string   "image",              limit: 255
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_content_type", limit: 255
    t.integer  "image_size",         limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "wordpress_author",   limit: 255
    t.string   "wordpress_scope",    limit: 255
    t.integer  "event_id"
    t.integer  "project_id"
    t.integer  "festival_id"
    t.boolean  "external",                       default: false, null: false
    t.integer  "eventr_id"
    t.integer  "residency_id"
  end

  add_index "posts", ["subsite_id"], name: "index_posts_on_subsite_id", using: :btree

  create_table "posts_post_categories", id: false, force: :cascade do |t|
    t.integer "post_id"
    t.integer "post_category_id"
  end

  create_table "project_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "project_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "project_anc_desc_udx", unique: true, using: :btree
  add_index "project_hierarchies", ["descendant_id"], name: "project_desc_idx", using: :btree

  create_table "project_translations", force: :cascade do |t|
    t.integer  "project_id",                    null: false
    t.string   "locale",            limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "short_description"
  end

  add_index "project_translations", ["locale"], name: "index_project_translations_on_locale", using: :btree
  add_index "project_translations", ["project_id"], name: "index_project_translations_on_project_id", using: :btree

  create_table "projectproposals", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.integer  "project_id"
    t.text     "description"
    t.text     "long_description"
    t.integer  "primary_initiator_id"
    t.string   "cosupporters",          limit: 255
    t.string   "producer",              limit: 255
    t.string   "treasurer",             limit: 255
    t.string   "documentation",         limit: 255
    t.string   "communication",         limit: 255
    t.string   "additional_experts",    limit: 255
    t.string   "reporting",             limit: 255
    t.string   "imagined_participants", limit: 255
    t.string   "equipment",             limit: 255
    t.string   "budget",                limit: 255
    t.string   "external_funding",      limit: 255
    t.string   "inkind",                limit: 255
    t.string   "people_expertise",      limit: 255
    t.string   "where",                 limit: 255
    t.string   "when",                  limit: 255
    t.string   "when_will_it_end",      limit: 255
    t.text     "why"
    t.string   "slug",                  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comment_count",                     default: 0
    t.integer  "offspring_id"
  end

  add_index "projectproposals", ["project_id"], name: "index_projectproposals_on_project_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.string   "slug",                    limit: 255
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "website",                 limit: 255
    t.integer  "evolvedfrom_id"
    t.integer  "evolution_year"
    t.string   "project_bg_colour",       limit: 255, default: "f9ec31", null: false
    t.string   "project_text_colour",     limit: 255, default: "333",    null: false
    t.string   "project_link_colour",     limit: 255, default: "008cba", null: false
    t.boolean  "active",                              default: false,    null: false
    t.string   "background"
    t.integer  "background_file_size",    limit: 8
    t.string   "background_content_type"
    t.integer  "background_height"
    t.integer  "background_width"
    t.string   "redirect_to"
    t.boolean  "has_listserv",                        default: false,    null: false
    t.string   "listservname"
    t.boolean  "hidden",                              default: false,    null: false
  end

  create_table "residencies", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "country",            limit: 255
    t.date     "start_at"
    t.date     "end_at"
    t.boolean  "is_micro"
    t.string   "photo",              limit: 255
    t.integer  "photo_size"
    t.integer  "photo_width"
    t.integer  "photo_height"
    t.string   "photo_content_type", limit: 255
    t.string   "slug",               limit: 255
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country_override",   limit: 255
  end

  add_index "residencies", ["project_id"], name: "index_residencies_on_project_id", using: :btree
  add_index "residencies", ["user_id"], name: "index_residencies_on_user_id", using: :btree

  create_table "residency_translations", force: :cascade do |t|
    t.integer  "residency_id",             null: false
    t.string   "locale",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  add_index "residency_translations", ["locale"], name: "index_residency_translations_on_locale", using: :btree
  add_index "residency_translations", ["residency_id"], name: "index_residency_translations_on_residency_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id"
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "step_translations", force: :cascade do |t|
    t.integer  "step_id",                 null: false
    t.string   "locale",      limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  add_index "step_translations", ["locale"], name: "index_step_translations_on_locale", using: :btree
  add_index "step_translations", ["step_id"], name: "index_step_translations_on_step_id", using: :btree

  create_table "steps", force: :cascade do |t|
    t.integer  "subsite_id"
    t.integer  "festival_id"
    t.integer  "node_id"
    t.date     "start_at"
    t.date     "end_at"
    t.string   "name",        limit: 255
    t.integer  "number"
    t.integer  "event_id"
    t.string   "slug",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "steps", ["event_id"], name: "index_steps_on_event_id", using: :btree
  add_index "steps", ["festival_id"], name: "index_steps_on_festival_id", using: :btree
  add_index "steps", ["node_id"], name: "index_steps_on_node_id", using: :btree
  add_index "steps", ["subsite_id"], name: "index_steps_on_subsite_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.string   "item_type"
    t.string   "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subscriptions", ["item_type", "item_id"], name: "index_subscriptions_on_item_type_and_item_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "subsites", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.string   "subdomain",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id"
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count",             default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "username",               limit: 255
    t.string   "avatar",                 limit: 255
    t.string   "slug",                   limit: 255
    t.string   "website",                limit: 255
    t.text     "bio"
    t.string   "twitter_name"
    t.text     "feed_urls"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255, null: false
    t.integer  "item_id",                null: false
    t.string   "event",      limit: 255, null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "videohosts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: :cascade do |t|
    t.string   "title",                  limit: 255
    t.text     "description"
    t.string   "url",                    limit: 255
    t.string   "hostid",                 limit: 255
    t.string   "thumbnail",              limit: 255
    t.integer  "thumbnail_size",         limit: 8
    t.integer  "thumbnail_width"
    t.integer  "thumbnail_height"
    t.string   "thumbnail_content_type", limit: 255
    t.integer  "event_id"
    t.integer  "project_id"
    t.integer  "festival_id"
    t.integer  "video_width"
    t.integer  "video_height"
    t.integer  "duration"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "videohost_id",                       null: false
  end

  add_index "videos", ["event_id"], name: "index_videos_on_event_id", using: :btree
  add_index "videos", ["festival_id"], name: "index_videos_on_festival_id", using: :btree
  add_index "videos", ["project_id"], name: "index_videos_on_project_id", using: :btree

  add_foreign_key "subscriptions", "users"
end
