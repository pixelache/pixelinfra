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

ActiveRecord::Schema.define(version: 20171012102113) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "archivalimage_translations", id: :serial, force: :cascade do |t|
    t.integer "archivalimage_id", null: false
    t.string "locale", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "caption", limit: 255
    t.index ["archivalimage_id"], name: "index_archivalimage_translations_on_archivalimage_id"
    t.index ["locale"], name: "index_archivalimage_translations_on_locale"
  end

  create_table "archivalimages", id: :serial, force: :cascade do |t|
    t.integer "subsite_id"
    t.string "image", limit: 255
    t.integer "image_size"
    t.integer "image_width"
    t.integer "image_height"
    t.string "image_content_type", limit: 255
    t.integer "event_id"
    t.integer "festival_id"
    t.integer "page_id"
    t.integer "flickr_id"
    t.integer "project_id"
    t.string "credit", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date "image_date"
    t.boolean "cover_right", default: false, null: false
    t.index ["event_id"], name: "index_archivalimages_on_event_id"
    t.index ["festival_id"], name: "index_archivalimages_on_festival_id"
    t.index ["page_id"], name: "index_archivalimages_on_page_id"
    t.index ["project_id"], name: "index_archivalimages_on_project_id"
  end

  create_table "attachments", id: :serial, force: :cascade do |t|
    t.string "attachedfile", limit: 255
    t.string "attachedfile_content_type", limit: 255
    t.bigint "attachedfile_size"
    t.string "item_type", limit: 255
    t.integer "item_id"
    t.string "title", limit: 255
    t.text "description"
    t.boolean "public"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "documenttype_id"
    t.integer "year_of_publication"
    t.index ["documenttype_id"], name: "index_attachments_on_documenttype_id"
    t.index ["item_type", "item_id"], name: "index_attachments_on_item_type_and_item_id"
  end

  create_table "attendees", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "name", limit: 255
    t.text "description"
    t.text "url"
    t.string "email", limit: 255
    t.string "phone", limit: 255
    t.string "picture", limit: 255
    t.integer "picture_size"
    t.string "picture_content_type", limit: 255
    t.integer "picture_width"
    t.integer "picture_height"
    t.boolean "status"
    t.text "extra"
    t.string "country", limit: 255
    t.string "attachment_url", limit: 255
    t.text "address"
    t.string "organisation", limit: 255
    t.string "project_name", limit: 255
    t.text "project_description"
    t.text "project_creators"
    t.text "project_presenters"
    t.text "project_urls"
    t.text "motivation_statement"
    t.string "project_title", limit: 255
    t.string "project_keywords", limit: 255
    t.integer "event_id"
    t.integer "festival_id"
    t.string "slug", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "item_id"
    t.string "item_type", limit: 255
    t.boolean "waiting_list"
    t.index ["event_id"], name: "index_attendees_on_event_id"
    t.index ["festival_id"], name: "index_attendees_on_festival_id"
    t.index ["user_id"], name: "index_attendees_on_user_id"
  end

  create_table "authentications", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "provider", limit: 255
    t.string "uid", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "username", limit: 255
    t.index ["user_id", "provider", "uid"], name: "index_authentications_on_user_id_and_provider_and_uid", unique: true
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "ckeditor_assets", id: :serial, force: :cascade do |t|
    t.string "data_file_name", limit: 255, null: false
    t.string "data_content_type", limit: 255
    t.integer "data_file_size"
    t.integer "assetable_id"
    t.string "assetable_type", limit: 30
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "wordpress_url"
    t.boolean "missing", default: false, null: false
    t.index ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.integer "item_id"
    t.string "item_type", limit: 255
    t.integer "user_id"
    t.text "content"
    t.string "image", limit: 255
    t.integer "image_width"
    t.string "image_content_type", limit: 255
    t.integer "image_size"
    t.integer "image_height"
    t.string "attachment", limit: 255
    t.integer "attachment_size"
    t.string "attachment_content_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["item_id", "item_type"], name: "index_comments_on_item_id_and_item_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "document_translations", id: :serial, force: :cascade do |t|
    t.integer "document_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "description"
    t.index ["document_id"], name: "index_document_translations_on_document_id"
    t.index ["locale"], name: "index_document_translations_on_locale"
  end

  create_table "documents", id: :serial, force: :cascade do |t|
    t.date "date_of_release"
    t.integer "subsite_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documenttype_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "documenttype_anc_desc_udx", unique: true
    t.index ["descendant_id"], name: "documenttype_desc_idx"
  end

  create_table "documenttypes", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dynamictaglines", id: :serial, force: :cascade do |t|
    t.integer "subsite_id", null: false
    t.text "festival"
    t.text "electronic"
    t.text "art"
    t.text "subcultures"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["subsite_id"], name: "index_dynamictaglines_on_subsite_id"
  end

  create_table "etherpads", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "read_only_id", limit: 255
    t.boolean "deleted", default: false, null: false
    t.datetime "last_edited"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "private_pad"
    t.integer "documenttype_id"
  end

  create_table "etherpads_events", id: false, force: :cascade do |t|
    t.integer "etherpad_id", null: false
    t.integer "event_id", null: false
    t.index ["etherpad_id"], name: "index_etherpads_events_on_etherpad_id"
    t.index ["event_id"], name: "index_etherpads_events_on_event_id"
  end

  create_table "etherpads_festivals", id: false, force: :cascade do |t|
    t.integer "etherpad_id", null: false
    t.integer "festival_id", null: false
    t.index ["etherpad_id"], name: "index_etherpads_festivals_on_etherpad_id"
    t.index ["festival_id"], name: "index_etherpads_festivals_on_festival_id"
  end

  create_table "etherpads_meetings", id: false, force: :cascade do |t|
    t.integer "meeting_id"
    t.integer "etherpad_id"
  end

  create_table "etherpads_projects", id: false, force: :cascade do |t|
    t.integer "etherpad_id"
    t.integer "project_id"
  end

  create_table "etherpads_subsites", id: false, force: :cascade do |t|
    t.integer "etherpad_id"
    t.integer "subsite_id"
  end

  create_table "event_translations", id: :serial, force: :cascade do |t|
    t.integer "event_id", null: false
    t.string "locale", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name", limit: 255
    t.text "description"
    t.text "notes"
    t.index ["event_id"], name: "index_event_translations_on_event_id"
    t.index ["locale"], name: "index_event_translations_on_locale"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.integer "subsite_id"
    t.integer "place_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean "published"
    t.string "image", limit: 255
    t.integer "image_width"
    t.integer "image_height"
    t.string "image_content_type", limit: 255
    t.bigint "image_size"
    t.text "facebook_link"
    t.float "cost"
    t.float "cost_alternate"
    t.string "cost_alternate_reason", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug", limit: 255
    t.string "facilitator_name", limit: 255
    t.string "facilitator_url", limit: 255
    t.string "facilitator_organisation", limit: 255
    t.string "facilitator_organisation_url", limit: 255
    t.integer "project_id"
    t.integer "festival_id"
    t.integer "step_id"
    t.integer "user_id", default: 0, null: false
    t.integer "max_attendees"
    t.integer "eventr_id"
    t.text "resources_needed"
    t.text "protocol"
    t.integer "residency_id"
    t.integer "festivaltheme_id"
    t.boolean "registration_required"
    t.string "email_registrations_to"
    t.string "question_description"
    t.string "question_creators"
    t.string "question_motivation"
    t.boolean "require_approval"
    t.boolean "hide_registrants"
    t.boolean "show_guests_to_public"
    t.boolean "location_tbd"
    t.index ["place_id"], name: "index_events_on_place_id"
    t.index ["subsite_id"], name: "index_events_on_subsite_id"
  end

  create_table "experiences", id: :serial, force: :cascade do |t|
    t.integer "festivaltheme_id"
    t.string "name"
    t.string "phone"
    t.text "description"
    t.integer "experience_type"
    t.string "location"
    t.integer "place_id"
    t.boolean "approved"
    t.boolean "other_activities"
    t.text "special_instructions"
    t.string "email"
    t.string "when_text"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.float "latitude"
    t.float "longitude"
    t.index ["festivaltheme_id"], name: "index_experiences_on_festivaltheme_id"
    t.index ["place_id"], name: "index_experiences_on_place_id"
  end

  create_table "feedcaches", id: :serial, force: :cascade do |t|
    t.string "source"
    t.string "title"
    t.string "link_url"
    t.text "content"
    t.integer "user_id"
    t.boolean "hidden"
    t.integer "issued_at", null: false
    t.string "sourceid", null: false
    t.boolean "official", default: false, null: false
    t.boolean "hashtag", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sourceid", "source"], name: "index_feedcaches_on_sourceid_and_source", unique: true
    t.index ["user_id"], name: "index_feedcaches_on_user_id"
  end

  create_table "feeds", id: :serial, force: :cascade do |t|
    t.string "item_type", limit: 255
    t.integer "item_id"
    t.integer "subsite_id"
    t.datetime "fed_at"
    t.string "action", limit: 255
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["item_id"], name: "index_feeds_on_item_id"
    t.index ["subsite_id"], name: "index_feeds_on_subsite_id"
    t.index ["user_id"], name: "index_feeds_on_user_id"
  end

  create_table "festival_translations", id: :serial, force: :cascade do |t|
    t.integer "festival_id", null: false
    t.string "locale", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "overview_text"
    t.index ["festival_id"], name: "index_festival_translations_on_festival_id"
    t.index ["locale"], name: "index_festival_translations_on_locale"
  end

  create_table "festivals", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.date "start_at"
    t.date "end_at"
    t.string "website", limit: 255
    t.string "slug", limit: 255
    t.integer "node_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "subtitle", limit: 255
    t.string "image", limit: 255
    t.integer "image_height"
    t.integer "image_width"
    t.integer "image_size"
    t.string "image_content_type", limit: 255
    t.string "background_colour", limit: 255
    t.string "primary_colour", limit: 255
    t.integer "eventr_id"
    t.boolean "published", default: false, null: false
    t.string "festivalbackdrop", limit: 255
    t.string "festival_location", limit: 255, default: "Helsinki, Finland", null: false
    t.string "tertiary_colour", limit: 255, default: "FFFFFF", null: false
    t.boolean "has_listserv", default: false, null: false
    t.string "listservname"
    t.integer "subsite_id"
    t.string "redirect_to"
    t.index ["subsite_id"], name: "index_festivals_on_subsite_id"
  end

  create_table "festivaltheme_relations", id: :serial, force: :cascade do |t|
    t.integer "relation_id"
    t.string "relation_type", limit: 255
    t.integer "festivaltheme_id"
    t.index ["festivaltheme_id"], name: "index_festivaltheme_relations_on_festivaltheme_id"
    t.index ["relation_id", "relation_type"], name: "index_festivaltheme_relations_on_relation_id_and_relation_type"
  end

  create_table "festivaltheme_translations", id: :serial, force: :cascade do |t|
    t.integer "festivaltheme_id", null: false
    t.string "locale", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name", limit: 255
    t.text "description"
    t.text "short_description"
    t.index ["festivaltheme_id"], name: "index_festivaltheme_translations_on_festivaltheme_id"
    t.index ["locale"], name: "index_festivaltheme_translations_on_locale"
  end

  create_table "festivalthemes", id: :serial, force: :cascade do |t|
    t.integer "festival_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug", limit: 255
    t.string "image"
    t.bigint "image_file_size"
    t.string "image_content_type"
    t.integer "image_height"
    t.integer "image_width"
    t.index ["festival_id"], name: "index_festivalthemes_on_festival_id"
  end

  create_table "flickrsets", id: :serial, force: :cascade do |t|
    t.bigint "flickr_id"
    t.string "title", limit: 255
    t.text "description"
    t.date "start_upload_date"
    t.date "last_modified_date"
    t.integer "subsite_id", null: false
    t.integer "event_id"
    t.integer "project_id"
    t.integer "festival_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "flickr_user", limit: 255, default: "91330886@N08", null: false
    t.index ["event_id"], name: "index_flickrsets_on_event_id"
    t.index ["festival_id"], name: "index_flickrsets_on_festival_id"
    t.index ["flickr_id"], name: "index_flickrsets_on_flickr_id", unique: true
    t.index ["project_id"], name: "index_flickrsets_on_project_id"
    t.index ["subsite_id"], name: "index_flickrsets_on_subsite_id"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", limit: 255, null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope", limit: 255
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "frontitem_translations", id: :serial, force: :cascade do |t|
    t.integer "frontitem_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "custom_title"
    t.string "custom_follow_text"
    t.index ["frontitem_id"], name: "index_frontitem_translations_on_frontitem_id"
    t.index ["locale"], name: "index_frontitem_translations_on_locale"
  end

  create_table "frontitems", id: :serial, force: :cascade do |t|
    t.string "item_type", limit: 255
    t.integer "item_id"
    t.integer "position"
    t.string "external_url", limit: 255
    t.string "background_colour", limit: 255, default: "f05a28", null: false
    t.string "text_colour", limit: 255, default: "FFFFFF", null: false
    t.boolean "active"
    t.integer "frontmodule_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "subsite_id"
    t.string "bigimage", limit: 255
    t.integer "bigimage_size"
    t.integer "bigimage_width"
    t.integer "bigimage_height"
    t.string "bigimage_content_type", limit: 255
    t.string "seconditem_type", limit: 255
    t.string "seconditem_id", limit: 255
    t.boolean "background_on_title", default: false, null: false
    t.boolean "background_on_text", default: false, null: false
    t.boolean "dont_scale"
    t.boolean "no_text"
    t.index ["item_id", "item_type"], name: "index_frontitems_on_item_id_and_item_type"
    t.index ["seconditem_id", "seconditem_type"], name: "index_frontitems_on_seconditem_id_and_seconditem_type"
  end

  create_table "frontmodules", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "partial_name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "exampleimage", limit: 255
  end

  create_table "meeting_translations", id: :serial, force: :cascade do |t|
    t.integer "meeting_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["locale"], name: "index_meeting_translations_on_locale"
    t.index ["meeting_id"], name: "index_meeting_translations_on_meeting_id"
  end

  create_table "meetings", id: :serial, force: :cascade do |t|
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer "meetingtype_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meetingtype_id"], name: "index_meetings_on_meetingtype_id"
  end

  create_table "meetingtype_translations", id: :serial, force: :cascade do |t|
    t.integer "meetingtype_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["locale"], name: "index_meetingtype_translations_on_locale"
    t.index ["meetingtype_id"], name: "index_meetingtype_translations_on_meetingtype_id"
  end

  create_table "meetingtypes", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memberships", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "year", limit: 255
    t.boolean "paid"
    t.boolean "hallitus"
    t.boolean "hallitus_alternate"
    t.string "notes", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id", "year"], name: "index_memberships_on_user_id_and_year", unique: true
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "node_translations", id: :serial, force: :cascade do |t|
    t.integer "node_id", null: false
    t.string "locale", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "description"
    t.index ["locale"], name: "index_node_translations_on_locale"
    t.index ["node_id"], name: "index_node_translations_on_node_id"
  end

  create_table "nodes", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "website", limit: 255
    t.string "city", limit: 255
    t.string "country", limit: 255
    t.string "slug", limit: 255
    t.string "logo", limit: 255
    t.string "logo_content_type", limit: 255
    t.integer "logo_height"
    t.integer "logo_width"
    t.bigint "logo_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nodes_subsites", id: false, force: :cascade do |t|
    t.integer "node_id"
    t.integer "subsite_id"
  end

  create_table "opencallanswers", id: :serial, force: :cascade do |t|
    t.integer "opencallsubmission_id"
    t.integer "opencallquestion_id"
    t.text "answer"
    t.string "attachment_file_name"
    t.integer "attachment_file_size"
    t.string "attachment_content_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "attachment"
    t.index ["opencallquestion_id"], name: "index_opencallanswers_on_opencallquestion_id"
    t.index ["opencallsubmission_id", "opencallquestion_id"], name: "ocqs_index", unique: true
    t.index ["opencallsubmission_id"], name: "index_opencallanswers_on_opencallsubmission_id"
  end

  create_table "opencallquestion_translations", id: :serial, force: :cascade do |t|
    t.integer "opencallquestion_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "question_text"
    t.index ["locale"], name: "index_opencallquestion_translations_on_locale"
    t.index ["opencallquestion_id"], name: "index_opencallquestion_translations_on_opencallquestion_id"
  end

  create_table "opencallquestions", id: :serial, force: :cascade do |t|
    t.integer "opencall_id"
    t.integer "question_type"
    t.integer "sort_order"
    t.integer "character_limit"
    t.boolean "is_required", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["opencall_id"], name: "index_opencallquestions_on_opencall_id"
  end

  create_table "opencalls", id: :serial, force: :cascade do |t|
    t.integer "subsite_id"
    t.boolean "published"
    t.boolean "is_open"
    t.integer "page_id"
    t.text "submitted_text"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.datetime "closing_date"
    t.index ["page_id"], name: "index_opencalls_on_page_id"
    t.index ["subsite_id"], name: "index_opencalls_on_subsite_id"
  end

  create_table "opencallsubmissions", id: :serial, force: :cascade do |t|
    t.integer "opencall_id"
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "address"
    t.string "city"
    t.string "postcode"
    t.string "country"
    t.string "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "comment_count", default: 0
    t.index ["opencall_id"], name: "index_opencallsubmissions_on_opencall_id"
  end

  create_table "page_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "page_anc_desc_udx", unique: true
    t.index ["descendant_id"], name: "page_desc_idx"
  end

  create_table "page_translations", id: :serial, force: :cascade do |t|
    t.integer "page_id", null: false
    t.string "locale", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name", limit: 255
    t.text "body"
    t.index ["locale"], name: "index_page_translations_on_locale"
    t.index ["page_id"], name: "index_page_translations_on_page_id"
  end

  create_table "pages", id: :serial, force: :cascade do |t|
    t.text "slug"
    t.integer "subsite_id"
    t.boolean "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "parent_id"
    t.integer "wordpress_id"
    t.string "wordpress_author", limit: 255
    t.string "wordpress_scope", limit: 255
    t.integer "festival_id"
    t.integer "project_id"
    t.integer "sort_order"
    t.integer "festivaltheme_id"
    t.datetime "child_updated_at"
    t.integer "opencall_id"
    t.index ["festival_id"], name: "index_pages_on_festival_id"
    t.index ["project_id"], name: "index_pages_on_project_id"
  end

  create_table "photos", id: :serial, force: :cascade do |t|
    t.string "filename", limit: 255
    t.integer "filename_width"
    t.integer "filename_height"
    t.string "filename_content_type", limit: 255
    t.bigint "filename_size"
    t.integer "wordpress_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "item_type", limit: 255
    t.integer "item_id"
    t.string "wordpress_scope", limit: 255
    t.string "title", limit: 255
    t.string "credit", limit: 255
    t.date "image_date"
    t.index ["item_type", "item_id"], name: "index_photos_on_item_type_and_item_id"
  end

  create_table "place_translations", id: :serial, force: :cascade do |t|
    t.integer "place_id", null: false
    t.string "locale", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name", limit: 255
    t.index ["locale"], name: "index_place_translations_on_locale"
    t.index ["place_id"], name: "index_place_translations_on_place_id"
  end

  create_table "places", id: :serial, force: :cascade do |t|
    t.string "address1", limit: 255
    t.string "address2", limit: 255
    t.string "city", limit: 255
    t.string "country", limit: 255
    t.string "postcode", limit: 255
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug", limit: 255
  end

  create_table "post_categories", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "wordpress_id"
    t.string "slug", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_translations", id: :serial, force: :cascade do |t|
    t.integer "post_id", null: false
    t.string "locale", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "title", limit: 255
    t.text "body"
    t.text "excerpt"
    t.index ["locale"], name: "index_post_translations_on_locale"
    t.index ["post_id"], name: "index_post_translations_on_post_id"
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.string "slug", limit: 255
    t.integer "subsite_id"
    t.boolean "published"
    t.integer "creator_id"
    t.integer "last_modified_id"
    t.datetime "published_at"
    t.integer "wordpress_id"
    t.string "image", limit: 255
    t.integer "image_width"
    t.integer "image_height"
    t.string "image_content_type", limit: 255
    t.bigint "image_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "wordpress_author", limit: 255
    t.string "wordpress_scope", limit: 255
    t.integer "event_id"
    t.integer "project_id"
    t.integer "festival_id"
    t.boolean "external", default: false, null: false
    t.integer "eventr_id"
    t.integer "residency_id"
    t.boolean "registration_required"
    t.string "email_registrations_to"
    t.string "question_description"
    t.string "question_creators"
    t.string "question_motivation"
    t.string "email_template"
    t.integer "max_attendees"
    t.index ["subsite_id"], name: "index_posts_on_subsite_id"
  end

  create_table "posts_post_categories", id: false, force: :cascade do |t|
    t.integer "post_id"
    t.integer "post_category_id"
  end

  create_table "project_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "project_anc_desc_udx", unique: true
    t.index ["descendant_id"], name: "project_desc_idx"
  end

  create_table "project_translations", id: :serial, force: :cascade do |t|
    t.integer "project_id", null: false
    t.string "locale", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "description"
    t.string "short_description"
    t.index ["locale"], name: "index_project_translations_on_locale"
    t.index ["project_id"], name: "index_project_translations_on_project_id"
  end

  create_table "projectproposals", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "project_id"
    t.text "description"
    t.text "long_description"
    t.integer "primary_initiator_id"
    t.string "cosupporters", limit: 255
    t.string "producer", limit: 255
    t.string "treasurer", limit: 255
    t.string "documentation", limit: 255
    t.string "communication", limit: 255
    t.string "additional_experts", limit: 255
    t.string "reporting", limit: 255
    t.string "imagined_participants", limit: 255
    t.string "equipment", limit: 255
    t.string "budget", limit: 255
    t.string "external_funding", limit: 255
    t.string "inkind", limit: 255
    t.string "people_expertise", limit: 255
    t.string "where", limit: 255
    t.string "when", limit: 255
    t.string "when_will_it_end", limit: 255
    t.text "why"
    t.string "slug", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "comment_count", default: 0
    t.integer "offspring_id"
    t.boolean "archived", default: false, null: false
    t.integer "festival_id"
    t.integer "event_id"
    t.index ["project_id"], name: "index_projectproposals_on_project_id"
  end

  create_table "projects", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "slug", limit: 255
    t.integer "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "website", limit: 255
    t.integer "evolvedfrom_id"
    t.integer "evolution_year"
    t.string "project_bg_colour", limit: 255, default: "f9ec31", null: false
    t.string "project_text_colour", limit: 255, default: "333", null: false
    t.string "project_link_colour", limit: 255, default: "008cba", null: false
    t.boolean "active", default: false, null: false
    t.string "background"
    t.bigint "background_file_size"
    t.string "background_content_type"
    t.integer "background_height"
    t.integer "background_width"
    t.string "redirect_to"
    t.boolean "has_listserv", default: false, null: false
    t.string "listservname"
    t.boolean "hidden", default: false, null: false
  end

  create_table "residencies", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "country", limit: 255
    t.date "start_at"
    t.date "end_at"
    t.boolean "is_micro"
    t.string "photo", limit: 255
    t.integer "photo_size"
    t.integer "photo_width"
    t.integer "photo_height"
    t.string "photo_content_type", limit: 255
    t.string "slug", limit: 255
    t.integer "project_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "country_override", limit: 255
    t.index ["project_id"], name: "index_residencies_on_project_id"
    t.index ["user_id"], name: "index_residencies_on_user_id"
  end

  create_table "residency_translations", id: :serial, force: :cascade do |t|
    t.integer "residency_id", null: false
    t.string "locale", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "description"
    t.index ["locale"], name: "index_residency_translations_on_locale"
    t.index ["residency_id"], name: "index_residency_translations_on_residency_id"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "resource_id"
    t.string "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "step_translations", id: :serial, force: :cascade do |t|
    t.integer "step_id", null: false
    t.string "locale", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "description"
    t.index ["locale"], name: "index_step_translations_on_locale"
    t.index ["step_id"], name: "index_step_translations_on_step_id"
  end

  create_table "steps", id: :serial, force: :cascade do |t|
    t.integer "subsite_id"
    t.integer "festival_id"
    t.integer "node_id"
    t.date "start_at"
    t.date "end_at"
    t.string "name", limit: 255
    t.integer "number"
    t.integer "event_id"
    t.string "slug", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "description"
    t.index ["event_id"], name: "index_steps_on_event_id"
    t.index ["festival_id"], name: "index_steps_on_festival_id"
    t.index ["node_id"], name: "index_steps_on_node_id"
    t.index ["subsite_id"], name: "index_steps_on_subsite_id"
  end

  create_table "subscriptions", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "item_id"
    t.string "item_type"
    t.string "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_type", "item_id"], name: "index_subscriptions_on_item_type_and_item_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "subsites", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "description", limit: 255
    t.string "subdomain", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type", limit: 255
    t.integer "tagger_id"
    t.string "tagger_type", limit: 255
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "email", limit: 255, default: "", null: false
    t.string "provider", limit: 255
    t.string "uid", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.string "username", limit: 255
    t.string "avatar", limit: 255
    t.string "slug", limit: 255
    t.string "website", limit: 255
    t.text "bio"
    t.string "twitter_name"
    t.text "feed_urls"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  create_table "versions", id: :serial, force: :cascade do |t|
    t.string "item_type", limit: 255, null: false
    t.integer "item_id", null: false
    t.string "event", limit: 255, null: false
    t.string "whodunnit", limit: 255
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "videohosts", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.text "description"
    t.string "url", limit: 255
    t.string "hostid", limit: 255
    t.string "thumbnail", limit: 255
    t.bigint "thumbnail_size"
    t.integer "thumbnail_width"
    t.integer "thumbnail_height"
    t.string "thumbnail_content_type", limit: 255
    t.integer "event_id"
    t.integer "project_id"
    t.integer "festival_id"
    t.integer "video_width"
    t.integer "video_height"
    t.integer "duration"
    t.boolean "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "videohost_id", null: false
    t.index ["event_id"], name: "index_videos_on_event_id"
    t.index ["festival_id"], name: "index_videos_on_festival_id"
    t.index ["project_id"], name: "index_videos_on_project_id"
  end

  add_foreign_key "experiences", "festivalthemes"
  add_foreign_key "experiences", "places"
  add_foreign_key "feedcaches", "users"
  add_foreign_key "meetings", "meetingtypes"
  add_foreign_key "opencallanswers", "opencallquestions"
  add_foreign_key "opencallanswers", "opencallsubmissions"
  add_foreign_key "opencallquestions", "opencalls"
  add_foreign_key "opencalls", "pages"
  add_foreign_key "opencalls", "subsites"
  add_foreign_key "opencallsubmissions", "opencalls"
  add_foreign_key "subscriptions", "users"
end
