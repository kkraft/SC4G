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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 0) do

  create_table "actions", :primary_key => "aid", :force => true do |t|
    t.string "type",       :limit => 32,         :default => "",  :null => false
    t.string "callback",                         :default => "",  :null => false
    t.binary "parameters", :limit => 2147483647,                  :null => false
    t.string "label",                            :default => "0", :null => false
  end

# Could not dump table "advanced_help_index" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc1caf68>

# Could not dump table "authmap" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fed19ea8>

  create_table "backup_migrate_destinations", :primary_key => "destination_id", :force => true do |t|
    t.string "name",                   :null => false
    t.string "type",     :limit => 32, :null => false
    t.text   "location",               :null => false
    t.text   "settings",               :null => false
  end

  create_table "backup_migrate_profiles", :primary_key => "profile_id", :force => true do |t|
    t.string  "name",                                          :null => false
    t.string  "filename",                                      :null => false
    t.integer "append_timestamp", :limit => 1,  :default => 0, :null => false
    t.string  "timestamp_format", :limit => 14,                :null => false
    t.text    "filters",                                       :null => false
  end

  create_table "backup_migrate_schedules", :primary_key => "schedule_id", :force => true do |t|
    t.string  "name",                                           :null => false
    t.string  "source_id",      :limit => 32, :default => "db", :null => false
    t.string  "destination_id", :limit => 32, :default => "0",  :null => false
    t.string  "profile_id",     :limit => 32, :default => "0",  :null => false
    t.integer "keep",                         :default => 0,    :null => false
    t.integer "period",                       :default => 0,    :null => false
    t.integer "enabled",        :limit => 1,  :default => 0,    :null => false
    t.integer "cron",           :limit => 1,  :default => 0,    :null => false
  end

# Could not dump table "batch" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc1e0b88>

# Could not dump table "block" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc1efbb0>

# Could not dump table "block_custom" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc1f0970>

# Could not dump table "block_node_type" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc1fabc8>

# Could not dump table "block_role" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc1fcf40>

# Could not dump table "blocked_ips" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc200578>

# Could not dump table "cache" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc2094c0>

# Could not dump table "cache_block" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc2123b8>

# Could not dump table "cache_bootstrap" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc217278>

# Could not dump table "cache_field" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc218178>

# Could not dump table "cache_filter" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc221070>

# Could not dump table "cache_form" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fe9e6768>

# Could not dump table "cache_image" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc226e58>

# Could not dump table "cache_menu" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc22fd28>

# Could not dump table "cache_page" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc230c50>

# Could not dump table "cache_path" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc239b48>

# Could not dump table "cache_update" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fe8b3418>

# Could not dump table "cache_views" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc247928>

# Could not dump table "cache_views_data" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc248800>

  create_table "ckeditor_input_format", :id => false, :force => true do |t|
    t.string "name",   :limit => 128, :default => "", :null => false
    t.string "format", :limit => 128, :default => "", :null => false
  end

  create_table "ckeditor_settings", :primary_key => "name", :force => true do |t|
    t.text "settings"
  end

# Could not dump table "comment" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc1d03a0>

# Could not dump table "contact" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fca77b70>

  create_table "ctools_access_ruleset", :primary_key => "rsid", :force => true do |t|
    t.string "name"
    t.string "admin_title"
    t.text   "admin_description", :limit => 2147483647
    t.text   "requiredcontexts",  :limit => 2147483647
    t.text   "contexts",          :limit => 2147483647
    t.text   "relationships",     :limit => 2147483647
    t.text   "access",            :limit => 2147483647
  end

  create_table "ctools_css_cache", :primary_key => "cid", :force => true do |t|
    t.string  "filename"
    t.text    "css",      :limit => 2147483647
    t.integer "filter",   :limit => 1
  end

  create_table "ctools_custom_content", :primary_key => "cid", :force => true do |t|
    t.string "name"
    t.string "admin_title"
    t.text   "admin_description", :limit => 2147483647
    t.string "category"
    t.text   "settings",          :limit => 2147483647
  end

# Could not dump table "ctools_object_cache" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fce07b28>

  create_table "date_format_locale", :id => false, :force => true do |t|
    t.string "format",   :limit => 100, :null => false
    t.string "type",     :limit => 64,  :null => false
    t.string "language", :limit => 12,  :null => false
  end

# Could not dump table "date_format_type" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fce64030>

# Could not dump table "date_formats" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fce9e500>

# Could not dump table "field_config" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8ff166e70>

# Could not dump table "field_config_instance" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8ff210ee8>

# Could not dump table "field_data_body" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8ff56dde8>

# Could not dump table "field_data_comment_body" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8ff5fa630>

# Could not dump table "field_data_field_image" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8ff784438>

# Could not dump table "field_data_field_tags" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8ff526b78>

# Could not dump table "field_revision_body" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8ff53d850>

# Could not dump table "field_revision_comment_body" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8ff54c300>

# Could not dump table "field_revision_field_image" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8ff4062c0>

# Could not dump table "field_revision_field_tags" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8ff2bf240>

# Could not dump table "file_managed" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8ff344170>

# Could not dump table "file_usage" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8feea8da0>

# Could not dump table "filter" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8ff72e7b8>

# Could not dump table "filter_format" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fe938a78>

# Could not dump table "flood" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc0fd630>

# Could not dump table "history" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc1bd688>

# Could not dump table "image_effects" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc1c7318>

# Could not dump table "image_styles" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fea8f980>

  create_table "menu_custom", :primary_key => "menu_name", :force => true do |t|
    t.string "title",       :default => "", :null => false
    t.text   "description"
  end

# Could not dump table "menu_links" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc1d9d88>

# Could not dump table "menu_router" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc1ed928>

# Could not dump table "node" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc1fde68>

  create_table "node_access", :id => false, :force => true do |t|
    t.integer "nid",                       :default => 0,  :null => false
    t.integer "gid",                       :default => 0,  :null => false
    t.string  "realm",                     :default => "", :null => false
    t.integer "grant_view",   :limit => 1, :default => 0,  :null => false
    t.integer "grant_update", :limit => 1, :default => 0,  :null => false
    t.integer "grant_delete", :limit => 1, :default => 0,  :null => false
  end

# Could not dump table "node_comment_statistics" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc213448>

# Could not dump table "node_revision" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc21b7b0>

  create_table "node_type", :primary_key => "type", :force => true do |t|
    t.string  "name",                            :default => "", :null => false
    t.string  "base",                                            :null => false
    t.string  "module",                                          :null => false
    t.text    "description", :limit => 16777215,                 :null => false
    t.text    "help",        :limit => 16777215,                 :null => false
    t.integer "has_title",   :limit => 1,                        :null => false
    t.string  "title_label",                     :default => "", :null => false
    t.integer "custom",      :limit => 1,        :default => 0,  :null => false
    t.integer "modified",    :limit => 1,        :default => 0,  :null => false
    t.integer "locked",      :limit => 1,        :default => 0,  :null => false
    t.integer "disabled",    :limit => 1,        :default => 0,  :null => false
    t.string  "orig_type",                       :default => "", :null => false
  end

# Could not dump table "page_manager_handlers" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb900806130>

# Could not dump table "page_manager_pages" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc22ea90>

# Could not dump table "page_manager_weights" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc232280>

# Could not dump table "queue" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc23ad68>

  create_table "rdf_mapping", :id => false, :force => true do |t|
    t.string "type",    :limit => 128,        :null => false
    t.string "bundle",  :limit => 128,        :null => false
    t.binary "mapping", :limit => 2147483647
  end

# Could not dump table "registry" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc241c58>

  create_table "registry_file", :primary_key => "filename", :force => true do |t|
    t.string "hash", :limit => 64, :null => false
  end

# Could not dump table "role" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc2482b0>

# Could not dump table "role_permission" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc251978>

  create_table "search_dataset", :id => false, :force => true do |t|
    t.integer "sid",                           :default => 0, :null => false
    t.string  "type",    :limit => 16,                        :null => false
    t.text    "data",    :limit => 2147483647,                :null => false
    t.integer "reindex",                       :default => 0, :null => false
  end

# Could not dump table "search_index" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb90080f7a8>

# Could not dump table "search_node_links" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc07d0e8>

  create_table "search_total", :primary_key => "word", :force => true do |t|
    t.float "count"
  end

# Could not dump table "semaphore" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc14fde0>

  create_table "sequences", :primary_key => "value", :force => true do |t|
  end

# Could not dump table "sessions" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc0e9e78>

  create_table "shortcut_set", :primary_key => "set_name", :force => true do |t|
    t.string "title", :default => "", :null => false
  end

# Could not dump table "shortcut_set_users" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc0f13d0>

# Could not dump table "site_verify" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc1557b8>

# Could not dump table "stylizer" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fcf3dba0>

# Could not dump table "system" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc164f60>

  create_table "taxonomy_access_default", :id => false, :force => true do |t|
    t.integer "vid",                       :default => 0, :null => false
    t.integer "rid",                       :default => 0, :null => false
    t.integer "grant_view",   :limit => 1, :default => 0, :null => false
    t.integer "grant_update", :limit => 1, :default => 0, :null => false
    t.integer "grant_delete", :limit => 1, :default => 0, :null => false
    t.integer "grant_create", :limit => 1, :default => 0, :null => false
    t.integer "grant_list",   :limit => 1, :default => 0, :null => false
  end

  create_table "taxonomy_access_term", :id => false, :force => true do |t|
    t.integer "tid",                       :default => 0, :null => false
    t.integer "rid",                       :default => 0, :null => false
    t.integer "grant_view",   :limit => 1, :default => 0, :null => false
    t.integer "grant_update", :limit => 1, :default => 0, :null => false
    t.integer "grant_delete", :limit => 1, :default => 0, :null => false
    t.integer "grant_create", :limit => 1, :default => 0, :null => false
    t.integer "grant_list",   :limit => 1, :default => 1, :null => false
  end

# Could not dump table "taxonomy_index" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc17c480>

# Could not dump table "taxonomy_term_data" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc184270>

# Could not dump table "taxonomy_term_hierarchy" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc186458>

# Could not dump table "taxonomy_vocabulary" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fda69ce0>

# Could not dump table "url_alias" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc193220>

# Could not dump table "users" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb90100d540>

# Could not dump table "users_roles" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc1a4b60>

  create_table "variable", :primary_key => "name", :force => true do |t|
    t.binary "value", :limit => 2147483647, :null => false
  end

# Could not dump table "views_display" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc25f668>

# Could not dump table "views_view" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc266b70>

# Could not dump table "watchdog" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc273000>

  create_table "webform", :primary_key => "nid", :force => true do |t|
    t.text    "confirmation",                                                     :null => false
    t.string  "confirmation_format"
    t.string  "redirect_url",                       :default => "<confirmation>"
    t.integer "status",                :limit => 1, :default => 1,                :null => false
    t.integer "block",                 :limit => 1, :default => 0,                :null => false
    t.integer "teaser",                :limit => 1, :default => 0,                :null => false
    t.integer "allow_draft",           :limit => 1, :default => 0,                :null => false
    t.integer "auto_save",             :limit => 1, :default => 0,                :null => false
    t.integer "submit_notice",         :limit => 1, :default => 1,                :null => false
    t.string  "submit_text"
    t.integer "submit_limit",          :limit => 1, :default => -1,               :null => false
    t.integer "submit_interval",                    :default => -1,               :null => false
    t.integer "total_submit_limit",                 :default => -1,               :null => false
    t.integer "total_submit_interval",              :default => -1,               :null => false
  end

  create_table "webform_component", :id => false, :force => true do |t|
    t.integer "nid",                      :default => 0, :null => false
    t.integer "cid",       :limit => 2,   :default => 0, :null => false
    t.integer "pid",       :limit => 2,   :default => 0, :null => false
    t.string  "form_key",  :limit => 128
    t.string  "name"
    t.string  "type",      :limit => 16
    t.text    "value",                                   :null => false
    t.text    "extra",                                   :null => false
    t.integer "mandatory", :limit => 1,   :default => 0, :null => false
    t.integer "weight",    :limit => 2,   :default => 0, :null => false
  end

  create_table "webform_emails", :id => false, :force => true do |t|
    t.integer "nid",                              :default => 0, :null => false
    t.integer "eid",                 :limit => 2, :default => 0, :null => false
    t.text    "email"
    t.string  "subject"
    t.string  "from_name"
    t.string  "from_address"
    t.text    "template"
    t.text    "excluded_components",                             :null => false
    t.integer "html",                :limit => 1, :default => 0, :null => false
    t.integer "attachments",         :limit => 1, :default => 0, :null => false
  end

  create_table "webform_last_download", :id => false, :force => true do |t|
    t.integer "nid",       :default => 0, :null => false
    t.integer "uid",       :default => 0, :null => false
    t.integer "sid",       :default => 0, :null => false
    t.integer "requested", :default => 0, :null => false
  end

  create_table "webform_roles", :id => false, :force => true do |t|
    t.integer "nid", :default => 0, :null => false
    t.integer "rid", :default => 0, :null => false
  end

# Could not dump table "webform_submissions" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc29a498>

# Could not dump table "webform_submitted_data" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8fc2a15e0>

  create_table "wysiwyg", :primary_key => "format", :force => true do |t|
    t.string "editor",   :limit => 128, :default => "", :null => false
    t.text   "settings"
  end

# Could not dump table "wysiwyg_user" because of following NoMethodError
#   undefined method `orders' for #<ActiveRecord::ConnectionAdapters::Mysql2IndexDefinition:0x007fb8ff192ed0>

end
