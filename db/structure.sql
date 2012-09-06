CREATE TABLE `actions` (
  `aid` varchar(255) NOT NULL default '0' COMMENT 'Primary Key: Unique actions ID.',
  `type` varchar(32) NOT NULL default '' COMMENT 'The object that that action acts on (node, user, comment, system or custom types.)',
  `callback` varchar(255) NOT NULL default '' COMMENT 'The callback function that executes when the action runs.',
  `parameters` longblob NOT NULL COMMENT 'Parameters to be passed to the callback function.',
  `label` varchar(255) NOT NULL default '0' COMMENT 'Label of the action.',
  PRIMARY KEY  (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores action information.';

CREATE TABLE `advanced_help_index` (
  `sid` int(10) unsigned NOT NULL auto_increment COMMENT 'The primary key to give to the search engine for this topic.',
  `module` varchar(255) NOT NULL default '' COMMENT 'The module that owns this topic.',
  `topic` varchar(255) NOT NULL default '' COMMENT 'The topic id.',
  `language` varchar(12) NOT NULL default '' COMMENT 'The language this search index relates to.',
  PRIMARY KEY  (`sid`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores search index correlations for advanced help topics.';

CREATE TABLE `authmap` (
  `aid` int(10) unsigned NOT NULL auto_increment COMMENT 'Primary Key: Unique authmap ID.',
  `uid` int(11) NOT NULL default '0' COMMENT 'User’s users.uid.',
  `authname` varchar(128) NOT NULL default '' COMMENT 'Unique authentication name.',
  `module` varchar(128) NOT NULL default '' COMMENT 'Module which is controlling the authentication.',
  PRIMARY KEY  (`aid`),
  UNIQUE KEY `authname` (`authname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores distributed authentication mapping.';

CREATE TABLE `backup_migrate_destinations` (
  `destination_id` varchar(32) NOT NULL default '0' COMMENT 'The primary identifier for a profile.',
  `name` varchar(255) NOT NULL COMMENT 'The name of the profile.',
  `type` varchar(32) NOT NULL COMMENT 'The type of the destination.',
  `location` text NOT NULL COMMENT 'The the location string of the destination.',
  `settings` text NOT NULL COMMENT 'Other settings for the destination.',
  PRIMARY KEY  (`destination_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `backup_migrate_profiles` (
  `profile_id` varchar(32) NOT NULL default '0' COMMENT 'The primary identifier for a profile.',
  `name` varchar(255) NOT NULL COMMENT 'The name of the profile.',
  `filename` varchar(255) NOT NULL,
  `append_timestamp` tinyint(3) unsigned NOT NULL default '0' COMMENT 'Append a timestamp to the filename.',
  `timestamp_format` varchar(14) NOT NULL COMMENT 'The format of the timestamp.',
  `filters` text NOT NULL COMMENT 'The filter settings for the profile.',
  PRIMARY KEY  (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `backup_migrate_schedules` (
  `schedule_id` varchar(32) NOT NULL default '0' COMMENT 'The primary identifier for a profile.',
  `name` varchar(255) NOT NULL COMMENT 'The name of the profile.',
  `source_id` varchar(32) NOT NULL default 'db' COMMENT 'The backup_migrate_destination.destination_id of the source to backup from.',
  `destination_id` varchar(32) NOT NULL default '0' COMMENT 'The backup_migrate_destination.destination_id of the destination to back up to.',
  `profile_id` varchar(32) NOT NULL default '0' COMMENT 'The primary identifier for a profile.',
  `keep` int(11) NOT NULL default '0' COMMENT 'The number of backups to keep.',
  `period` int(11) NOT NULL default '0' COMMENT 'The number of seconds between backups.',
  `enabled` tinyint(3) unsigned NOT NULL default '0' COMMENT 'Whether the schedule is enabled.',
  `cron` tinyint(3) unsigned NOT NULL default '0' COMMENT 'Whether the schedule should be run during cron.',
  PRIMARY KEY  (`schedule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `batch` (
  `bid` int(10) unsigned NOT NULL COMMENT 'Primary Key: Unique batch ID.',
  `token` varchar(64) NOT NULL COMMENT 'A string token generated against the current user’s session id and the batch id, used to ensure that only the user who submitted the batch can effectively access it.',
  `timestamp` int(11) NOT NULL COMMENT 'A Unix timestamp indicating when this batch was submitted for processing. Stale batches are purged at cron time.',
  `batch` longblob COMMENT 'A serialized array containing the processing data for the batch.',
  PRIMARY KEY  (`bid`),
  KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores details about batches (processes that run in...';

CREATE TABLE `block` (
  `bid` int(11) NOT NULL auto_increment COMMENT 'Primary Key: Unique block ID.',
  `module` varchar(64) NOT NULL default '' COMMENT 'The module from which the block originates; for example, ’user’ for the Who’s Online block, and ’block’ for any custom blocks.',
  `delta` varchar(32) NOT NULL default '0' COMMENT 'Unique ID for block within a module.',
  `theme` varchar(64) NOT NULL default '' COMMENT 'The theme under which the block settings apply.',
  `status` tinyint(4) NOT NULL default '0' COMMENT 'Block enabled status. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL default '0' COMMENT 'Block weight within region.',
  `region` varchar(64) NOT NULL default '' COMMENT 'Theme region within which the block is set.',
  `custom` tinyint(4) NOT NULL default '0' COMMENT 'Flag to indicate how users may control visibility of the block. (0 = Users cannot control, 1 = On by default, but can be hidden, 2 = Hidden by default, but can be shown)',
  `visibility` tinyint(4) NOT NULL default '0' COMMENT 'Flag to indicate how to show blocks on pages. (0 = Show on all pages except listed pages, 1 = Show only on listed pages, 2 = Use custom PHP code to determine visibility)',
  `pages` text NOT NULL COMMENT 'Contents of the "Pages" block; contains either a list of paths on which to include/exclude the block or PHP code, depending on "visibility" setting.',
  `title` varchar(64) NOT NULL default '' COMMENT 'Custom title for the block. (Empty string will use block default title, <none> will remove the title, text will cause block to use specified title.)',
  `cache` tinyint(4) NOT NULL default '1' COMMENT 'Binary flag to indicate block cache mode. (-2: Custom cache, -1: Do not cache, 1: Cache per role, 2: Cache per user, 4: Cache per page, 8: Block cache global) See DRUPAL_CACHE_* constants in ../includes/common.inc for more detailed information.',
  PRIMARY KEY  (`bid`),
  UNIQUE KEY `tmd` (`theme`,`module`,`delta`),
  KEY `list` (`theme`,`status`,`region`,`weight`,`module`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8 COMMENT='Stores block settings, such as region and visibility...';

CREATE TABLE `block_custom` (
  `bid` int(10) unsigned NOT NULL auto_increment COMMENT 'The block’s block.bid.',
  `body` longtext COMMENT 'Block contents.',
  `info` varchar(128) NOT NULL default '' COMMENT 'Block description.',
  `format` varchar(255) default NULL COMMENT 'The filter_format.format of the block body.',
  PRIMARY KEY  (`bid`),
  UNIQUE KEY `info` (`info`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Stores contents of custom-made blocks.';

CREATE TABLE `block_node_type` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type from node_type.type.',
  PRIMARY KEY  (`module`,`delta`,`type`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up display criteria for blocks based on content types';

CREATE TABLE `block_role` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `rid` int(10) unsigned NOT NULL COMMENT 'The user’s role ID from users_roles.rid.',
  PRIMARY KEY  (`module`,`delta`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up access permissions for blocks based on user roles';

CREATE TABLE `blocked_ips` (
  `iid` int(10) unsigned NOT NULL auto_increment COMMENT 'Primary Key: unique ID for IP addresses.',
  `ip` varchar(40) NOT NULL default '' COMMENT 'IP address',
  PRIMARY KEY  (`iid`),
  KEY `blocked_ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores blocked IP addresses.';

CREATE TABLE `cache` (
  `cid` varchar(255) NOT NULL default '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL default '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY  (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';

CREATE TABLE `cache_block` (
  `cid` varchar(255) NOT NULL default '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL default '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY  (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Block module to store already built...';

CREATE TABLE `cache_bootstrap` (
  `cid` varchar(255) NOT NULL default '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL default '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY  (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for data required to bootstrap Drupal, may be...';

CREATE TABLE `cache_field` (
  `cid` varchar(255) NOT NULL default '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL default '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY  (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';

CREATE TABLE `cache_filter` (
  `cid` varchar(255) NOT NULL default '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL default '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY  (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Filter module to store already...';

CREATE TABLE `cache_form` (
  `cid` varchar(255) NOT NULL default '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL default '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY  (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the form system to store recently built...';

CREATE TABLE `cache_image` (
  `cid` varchar(255) NOT NULL default '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL default '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY  (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store information about image...';

CREATE TABLE `cache_menu` (
  `cid` varchar(255) NOT NULL default '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL default '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY  (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the menu system to store router...';

CREATE TABLE `cache_page` (
  `cid` varchar(255) NOT NULL default '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL default '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY  (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store compressed pages for anonymous...';

CREATE TABLE `cache_path` (
  `cid` varchar(255) NOT NULL default '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL default '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY  (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for path alias lookup.';

CREATE TABLE `cache_update` (
  `cid` varchar(255) NOT NULL default '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL default '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY  (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Update module to store information...';

CREATE TABLE `cache_views` (
  `cid` varchar(255) NOT NULL default '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL default '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY  (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';

CREATE TABLE `cache_views_data` (
  `cid` varchar(255) NOT NULL default '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL default '1' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY  (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for views to store pre-rendered queries,...';

CREATE TABLE `ckeditor_input_format` (
  `name` varchar(128) NOT NULL default '' COMMENT 'Name of the CKEditor role',
  `format` varchar(128) NOT NULL default '' COMMENT 'Drupal filter format id',
  PRIMARY KEY  (`name`,`format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores CKEditor input format assignments';

CREATE TABLE `ckeditor_settings` (
  `name` varchar(128) NOT NULL default '' COMMENT 'Name of the CKEditor profile',
  `settings` text COMMENT 'Profile settings',
  PRIMARY KEY  (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores CKEditor profile settings';

CREATE TABLE `comment` (
  `cid` int(11) NOT NULL auto_increment COMMENT 'Primary Key: Unique comment ID.',
  `pid` int(11) NOT NULL default '0' COMMENT 'The comment.cid to which this comment is a reply. If set to 0, this comment is not a reply to an existing comment.',
  `nid` int(11) NOT NULL default '0' COMMENT 'The node.nid to which this comment is a reply.',
  `uid` int(11) NOT NULL default '0' COMMENT 'The users.uid who authored the comment. If set to 0, this comment was created by an anonymous user.',
  `subject` varchar(64) NOT NULL default '' COMMENT 'The comment title.',
  `hostname` varchar(128) NOT NULL default '' COMMENT 'The author’s host name.',
  `created` int(11) NOT NULL default '0' COMMENT 'The time that the comment was created, as a Unix timestamp.',
  `changed` int(11) NOT NULL default '0' COMMENT 'The time that the comment was last edited, as a Unix timestamp.',
  `status` tinyint(3) unsigned NOT NULL default '1' COMMENT 'The published status of a comment. (0 = Not Published, 1 = Published)',
  `thread` varchar(255) NOT NULL COMMENT 'The vancode representation of the comment’s place in a thread.',
  `name` varchar(60) default NULL COMMENT 'The comment author’s name. Uses users.name if the user is logged in, otherwise uses the value typed into the comment form.',
  `mail` varchar(64) default NULL COMMENT 'The comment author’s e-mail address from the comment form, if user is anonymous, and the ’Anonymous users may/must leave their contact information’ setting is turned on.',
  `homepage` varchar(255) default NULL COMMENT 'The comment author’s home page address from the comment form, if user is anonymous, and the ’Anonymous users may/must leave their contact information’ setting is turned on.',
  `language` varchar(12) NOT NULL default '' COMMENT 'The languages.language of this comment.',
  PRIMARY KEY  (`cid`),
  KEY `comment_status_pid` (`pid`,`status`),
  KEY `comment_num_new` (`nid`,`status`,`created`,`cid`,`thread`),
  KEY `comment_uid` (`uid`),
  KEY `comment_nid_language` (`nid`,`language`),
  KEY `comment_created` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores comments and associated data.';

CREATE TABLE `contact` (
  `cid` int(10) unsigned NOT NULL auto_increment COMMENT 'Primary Key: Unique category ID.',
  `category` varchar(255) NOT NULL default '' COMMENT 'Category name.',
  `recipients` longtext NOT NULL COMMENT 'Comma-separated list of recipient e-mail addresses.',
  `reply` longtext NOT NULL COMMENT 'Text of the auto-reply message.',
  `weight` int(11) NOT NULL default '0' COMMENT 'The category’s weight.',
  `selected` tinyint(4) NOT NULL default '0' COMMENT 'Flag to indicate whether or not category is selected by default. (1 = Yes, 0 = No)',
  PRIMARY KEY  (`cid`),
  UNIQUE KEY `category` (`category`),
  KEY `list` (`weight`,`category`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Contact form category settings.';

CREATE TABLE `ctools_access_ruleset` (
  `rsid` int(11) NOT NULL auto_increment COMMENT 'A database primary key to ensure uniqueness',
  `name` varchar(255) default NULL COMMENT 'Unique ID for this ruleset. Used to identify it programmatically.',
  `admin_title` varchar(255) default NULL COMMENT 'Administrative title for this ruleset.',
  `admin_description` longtext COMMENT 'Administrative description for this ruleset.',
  `requiredcontexts` longtext COMMENT 'Any required contexts for this ruleset.',
  `contexts` longtext COMMENT 'Any embedded contexts for this ruleset.',
  `relationships` longtext COMMENT 'Any relationships for this ruleset.',
  `access` longtext COMMENT 'The actual group of access plugins for this ruleset.',
  PRIMARY KEY  (`rsid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains exportable customized access rulesets.';

CREATE TABLE `ctools_css_cache` (
  `cid` varchar(128) NOT NULL COMMENT 'The CSS ID this cache object belongs to.',
  `filename` varchar(255) default NULL COMMENT 'The filename this CSS is stored in.',
  `css` longtext COMMENT 'CSS being stored.',
  `filter` tinyint(4) default NULL COMMENT 'Whether or not this CSS needs to be filtered.',
  PRIMARY KEY  (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A special cache used to store CSS that must be non-volatile.';

CREATE TABLE `ctools_custom_content` (
  `cid` int(11) NOT NULL auto_increment COMMENT 'A database primary key to ensure uniqueness',
  `name` varchar(255) default NULL COMMENT 'Unique ID for this content. Used to identify it programmatically.',
  `admin_title` varchar(255) default NULL COMMENT 'Administrative title for this content.',
  `admin_description` longtext COMMENT 'Administrative description for this content.',
  `category` varchar(255) default NULL COMMENT 'Administrative category for this content.',
  `settings` longtext COMMENT 'Serialized settings for the actual content to be used',
  PRIMARY KEY  (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains exportable customized content for this site.';

CREATE TABLE `ctools_object_cache` (
  `sid` varchar(64) NOT NULL COMMENT 'The session ID this cache object belongs to.',
  `name` varchar(128) NOT NULL COMMENT 'The name of the object this cache is attached to.',
  `obj` varchar(32) NOT NULL COMMENT 'The type of the object this cache is attached to; this essentially represents the owner so that several sub-systems can use this cache.',
  `updated` int(10) unsigned NOT NULL default '0' COMMENT 'The time this cache was created or updated.',
  `data` longtext COMMENT 'Serialized data being stored.',
  PRIMARY KEY  (`sid`,`obj`,`name`),
  KEY `updated` (`updated`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A special cache used to store objects that are being...';

CREATE TABLE `date_format_locale` (
  `format` varchar(100) NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `language` varchar(12) NOT NULL COMMENT 'A languages.language for this format to be used with.',
  PRIMARY KEY  (`type`,`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats for each locale.';

CREATE TABLE `date_format_type` (
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `title` varchar(255) NOT NULL COMMENT 'The human readable name of the format type.',
  `locked` tinyint(4) NOT NULL default '0' COMMENT 'Whether or not this is a system provided format.',
  PRIMARY KEY  (`type`),
  KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date format types.';

CREATE TABLE `date_formats` (
  `dfid` int(10) unsigned NOT NULL auto_increment COMMENT 'The date format identifier.',
  `format` varchar(100) NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `locked` tinyint(4) NOT NULL default '0' COMMENT 'Whether or not this format can be modified.',
  PRIMARY KEY  (`dfid`),
  UNIQUE KEY `formats` (`format`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats.';

CREATE TABLE `field_config` (
  `id` int(11) NOT NULL auto_increment COMMENT 'The primary identifier for a field',
  `field_name` varchar(32) NOT NULL COMMENT 'The name of this field. Non-deleted field names are unique, but multiple deleted fields can have the same name.',
  `type` varchar(128) NOT NULL COMMENT 'The type of this field.',
  `module` varchar(128) NOT NULL default '' COMMENT 'The module that implements the field type.',
  `active` tinyint(4) NOT NULL default '0' COMMENT 'Boolean indicating whether the module that implements the field type is enabled.',
  `storage_type` varchar(128) NOT NULL COMMENT 'The storage backend for the field.',
  `storage_module` varchar(128) NOT NULL default '' COMMENT 'The module that implements the storage backend.',
  `storage_active` tinyint(4) NOT NULL default '0' COMMENT 'Boolean indicating whether the module that implements the storage backend is enabled.',
  `locked` tinyint(4) NOT NULL default '0' COMMENT '@TODO',
  `data` longblob NOT NULL COMMENT 'Serialized data containing the field properties that do not warrant a dedicated column.',
  `cardinality` tinyint(4) NOT NULL default '0',
  `translatable` tinyint(4) NOT NULL default '0',
  `deleted` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `field_name` (`field_name`),
  KEY `active` (`active`),
  KEY `storage_active` (`storage_active`),
  KEY `deleted` (`deleted`),
  KEY `module` (`module`),
  KEY `storage_module` (`storage_module`),
  KEY `type` (`type`),
  KEY `storage_type` (`storage_type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE `field_config_instance` (
  `id` int(11) NOT NULL auto_increment COMMENT 'The primary identifier for a field instance',
  `field_id` int(11) NOT NULL COMMENT 'The identifier of the field attached by this instance',
  `field_name` varchar(32) NOT NULL default '',
  `entity_type` varchar(32) NOT NULL default '',
  `bundle` varchar(128) NOT NULL default '',
  `data` longblob NOT NULL,
  `deleted` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `field_name_bundle` (`field_name`,`entity_type`,`bundle`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

CREATE TABLE `field_data_body` (
  `entity_type` varchar(128) NOT NULL default '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL default '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL default '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned default NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL default '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) default NULL,
  PRIMARY KEY  (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `body_format` (`body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 2 (body)';

CREATE TABLE `field_data_comment_body` (
  `entity_type` varchar(128) NOT NULL default '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL default '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL default '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned default NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL default '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `comment_body_value` longtext,
  `comment_body_format` varchar(255) default NULL,
  PRIMARY KEY  (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `comment_body_format` (`comment_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 1 (comment_body)';

CREATE TABLE `field_data_field_image` (
  `entity_type` varchar(128) NOT NULL default '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL default '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL default '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned default NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL default '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) unsigned default NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_image_alt` varchar(512) default NULL,
  `field_image_title` varchar(1024) default NULL,
  `field_image_width` int(10) unsigned default NULL COMMENT 'The width of the image in pixels.',
  `field_image_height` int(10) unsigned default NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY  (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_image_fid` (`field_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 4 (field_image)';

CREATE TABLE `field_data_field_tags` (
  `entity_type` varchar(128) NOT NULL default '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL default '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL default '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned default NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL default '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_tags_tid` int(10) unsigned default NULL,
  PRIMARY KEY  (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_tags_tid` (`field_tags_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 3 (field_tags)';

CREATE TABLE `field_revision_body` (
  `entity_type` varchar(128) NOT NULL default '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL default '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL default '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL default '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) default NULL,
  PRIMARY KEY  (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `body_format` (`body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 2 (body)';

CREATE TABLE `field_revision_comment_body` (
  `entity_type` varchar(128) NOT NULL default '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL default '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL default '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL default '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `comment_body_value` longtext,
  `comment_body_format` varchar(255) default NULL,
  PRIMARY KEY  (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `comment_body_format` (`comment_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 1 (comment_body)';

CREATE TABLE `field_revision_field_image` (
  `entity_type` varchar(128) NOT NULL default '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL default '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL default '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL default '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) unsigned default NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_image_alt` varchar(512) default NULL,
  `field_image_title` varchar(1024) default NULL,
  `field_image_width` int(10) unsigned default NULL COMMENT 'The width of the image in pixels.',
  `field_image_height` int(10) unsigned default NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY  (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_image_fid` (`field_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 4 (field_image)';

CREATE TABLE `field_revision_field_tags` (
  `entity_type` varchar(128) NOT NULL default '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL default '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL default '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL default '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_tags_tid` int(10) unsigned default NULL,
  PRIMARY KEY  (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_tags_tid` (`field_tags_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 3 (field_tags)';

CREATE TABLE `file_managed` (
  `fid` int(10) unsigned NOT NULL auto_increment COMMENT 'File ID.',
  `uid` int(10) unsigned NOT NULL default '0' COMMENT 'The users.uid of the user who is associated with the file.',
  `filename` varchar(255) character set utf8 collate utf8_bin NOT NULL default '' COMMENT 'Name of the file with no path components. This may differ from the basename of the URI if the file is renamed to avoid overwriting an existing file.',
  `uri` varchar(255) character set utf8 collate utf8_bin NOT NULL default '' COMMENT 'The URI to access the file (either local or remote).',
  `filemime` varchar(255) NOT NULL default '' COMMENT 'The file’s MIME type.',
  `filesize` int(10) unsigned NOT NULL default '0' COMMENT 'The size of the file in bytes.',
  `status` tinyint(4) NOT NULL default '0' COMMENT 'A field indicating the status of the file. Two status are defined in core: temporary (0) and permanent (1). Temporary files older than DRUPAL_MAXIMUM_TEMP_FILE_AGE will be removed during a cron run.',
  `timestamp` int(10) unsigned NOT NULL default '0' COMMENT 'UNIX timestamp for when the file was added.',
  PRIMARY KEY  (`fid`),
  UNIQUE KEY `uri` (`uri`),
  KEY `uid` (`uid`),
  KEY `status` (`status`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8 COMMENT='Stores information for uploaded files.';

CREATE TABLE `file_usage` (
  `fid` int(10) unsigned NOT NULL COMMENT 'File ID.',
  `module` varchar(255) NOT NULL default '' COMMENT 'The name of the module that is using the file.',
  `type` varchar(64) NOT NULL default '' COMMENT 'The name of the object type in which the file is used.',
  `id` int(10) unsigned NOT NULL default '0' COMMENT 'The primary key of the object using the file.',
  `count` int(10) unsigned NOT NULL default '0' COMMENT 'The number of times this file is used by this object.',
  PRIMARY KEY  (`fid`,`type`,`id`,`module`),
  KEY `type_id` (`type`,`id`),
  KEY `fid_count` (`fid`,`count`),
  KEY `fid_module` (`fid`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Track where a file is used.';

CREATE TABLE `filter` (
  `format` varchar(255) NOT NULL COMMENT 'Foreign key: The filter_format.format to which this filter is assigned.',
  `module` varchar(64) NOT NULL default '' COMMENT 'The origin module of the filter.',
  `name` varchar(32) NOT NULL default '' COMMENT 'Name of the filter being referenced.',
  `weight` int(11) NOT NULL default '0' COMMENT 'Weight of filter within format.',
  `status` int(11) NOT NULL default '0' COMMENT 'Filter enabled status. (1 = enabled, 0 = disabled)',
  `settings` longblob COMMENT 'A serialized array of name value pairs that store the filter settings for the specific format.',
  PRIMARY KEY  (`format`,`name`),
  KEY `list` (`weight`,`module`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table that maps filters (HTML corrector) to text formats ...';

CREATE TABLE `filter_format` (
  `format` varchar(255) NOT NULL COMMENT 'Primary Key: Unique machine name of the format.',
  `name` varchar(255) NOT NULL default '' COMMENT 'Name of the text format (Filtered HTML).',
  `cache` tinyint(4) NOT NULL default '0' COMMENT 'Flag to indicate whether format is cacheable. (1 = cacheable, 0 = not cacheable)',
  `status` tinyint(3) unsigned NOT NULL default '1' COMMENT 'The status of the text format. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL default '0' COMMENT 'Weight of text format to use when listing.',
  PRIMARY KEY  (`format`),
  UNIQUE KEY `name` (`name`),
  KEY `status_weight` (`status`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores text formats: custom groupings of filters, such as...';

CREATE TABLE `flood` (
  `fid` int(11) NOT NULL auto_increment COMMENT 'Unique flood event ID.',
  `event` varchar(64) NOT NULL default '' COMMENT 'Name of event (e.g. contact).',
  `identifier` varchar(128) NOT NULL default '' COMMENT 'Identifier of the visitor, such as an IP address or hostname.',
  `timestamp` int(11) NOT NULL default '0' COMMENT 'Timestamp of the event.',
  `expiration` int(11) NOT NULL default '0' COMMENT 'Expiration timestamp. Expired events are purged on cron run.',
  PRIMARY KEY  (`fid`),
  KEY `allow` (`event`,`identifier`,`timestamp`),
  KEY `purge` (`expiration`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COMMENT='Flood controls the threshold of events, such as the...';

CREATE TABLE `history` (
  `uid` int(11) NOT NULL default '0' COMMENT 'The users.uid that read the node nid.',
  `nid` int(11) NOT NULL default '0' COMMENT 'The node.nid that was read.',
  `timestamp` int(11) NOT NULL default '0' COMMENT 'The Unix timestamp at which the read occurred.',
  PRIMARY KEY  (`uid`,`nid`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A record of which users have read which nodes.';

CREATE TABLE `image_effects` (
  `ieid` int(10) unsigned NOT NULL auto_increment COMMENT 'The primary identifier for an image effect.',
  `isid` int(10) unsigned NOT NULL default '0' COMMENT 'The image_styles.isid for an image style.',
  `weight` int(11) NOT NULL default '0' COMMENT 'The weight of the effect in the style.',
  `name` varchar(255) NOT NULL COMMENT 'The unique name of the effect to be executed.',
  `data` longblob NOT NULL COMMENT 'The configuration data for the effect.',
  PRIMARY KEY  (`ieid`),
  KEY `isid` (`isid`),
  KEY `weight` (`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image effects.';

CREATE TABLE `image_styles` (
  `isid` int(10) unsigned NOT NULL auto_increment COMMENT 'The primary identifier for an image style.',
  `name` varchar(255) NOT NULL COMMENT 'The style name.',
  PRIMARY KEY  (`isid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image styles.';

CREATE TABLE `menu_custom` (
  `menu_name` varchar(32) NOT NULL default '' COMMENT 'Primary Key: Unique key for menu. This is used as a block delta so length is 32.',
  `title` varchar(255) NOT NULL default '' COMMENT 'Menu title; displayed at top of block.',
  `description` text COMMENT 'Menu description.',
  PRIMARY KEY  (`menu_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds definitions for top-level custom menus (for example...';

CREATE TABLE `menu_links` (
  `menu_name` varchar(32) NOT NULL default '' COMMENT 'The menu name. All links with the same menu name (such as ’navigation’) are part of the same menu.',
  `mlid` int(10) unsigned NOT NULL auto_increment COMMENT 'The menu link ID (mlid) is the integer primary key.',
  `plid` int(10) unsigned NOT NULL default '0' COMMENT 'The parent link ID (plid) is the mlid of the link above in the hierarchy, or zero if the link is at the top level in its menu.',
  `link_path` varchar(255) NOT NULL default '' COMMENT 'The Drupal path or external path this link points to.',
  `router_path` varchar(255) NOT NULL default '' COMMENT 'For links corresponding to a Drupal path (external = 0), this connects the link to a menu_router.path for joins.',
  `link_title` varchar(255) NOT NULL default '' COMMENT 'The text displayed for the link, which may be modified by a title callback stored in menu_router.',
  `options` blob COMMENT 'A serialized array of options to be passed to the url() or l() function, such as a query string or HTML attributes.',
  `module` varchar(255) NOT NULL default 'system' COMMENT 'The name of the module that generated this link.',
  `hidden` smallint(6) NOT NULL default '0' COMMENT 'A flag for whether the link should be rendered in menus. (1 = a disabled menu item that may be shown on admin screens, -1 = a menu callback, 0 = a normal, visible link)',
  `external` smallint(6) NOT NULL default '0' COMMENT 'A flag to indicate if the link points to a full URL starting with a protocol, like http:// (1 = external, 0 = internal).',
  `has_children` smallint(6) NOT NULL default '0' COMMENT 'Flag indicating whether any links have this link as a parent (1 = children exist, 0 = no children).',
  `expanded` smallint(6) NOT NULL default '0' COMMENT 'Flag for whether this link should be rendered as expanded in menus - expanded links always have their child links displayed, instead of only when the link is in the active trail (1 = expanded, 0 = not expanded)',
  `weight` int(11) NOT NULL default '0' COMMENT 'Link weight among links in the same menu at the same depth.',
  `depth` smallint(6) NOT NULL default '0' COMMENT 'The depth relative to the top level. A link with plid == 0 will have depth == 1.',
  `customized` smallint(6) NOT NULL default '0' COMMENT 'A flag to indicate that the user has manually created or edited the link (1 = customized, 0 = not customized).',
  `p1` int(10) unsigned NOT NULL default '0' COMMENT 'The first mlid in the materialized path. If N = depth, then pN must equal the mlid. If depth > 1 then p(N-1) must equal the plid. All pX where X > depth must equal zero. The columns p1 .. p9 are also called the parents.',
  `p2` int(10) unsigned NOT NULL default '0' COMMENT 'The second mlid in the materialized path. See p1.',
  `p3` int(10) unsigned NOT NULL default '0' COMMENT 'The third mlid in the materialized path. See p1.',
  `p4` int(10) unsigned NOT NULL default '0' COMMENT 'The fourth mlid in the materialized path. See p1.',
  `p5` int(10) unsigned NOT NULL default '0' COMMENT 'The fifth mlid in the materialized path. See p1.',
  `p6` int(10) unsigned NOT NULL default '0' COMMENT 'The sixth mlid in the materialized path. See p1.',
  `p7` int(10) unsigned NOT NULL default '0' COMMENT 'The seventh mlid in the materialized path. See p1.',
  `p8` int(10) unsigned NOT NULL default '0' COMMENT 'The eighth mlid in the materialized path. See p1.',
  `p9` int(10) unsigned NOT NULL default '0' COMMENT 'The ninth mlid in the materialized path. See p1.',
  `updated` smallint(6) NOT NULL default '0' COMMENT 'Flag that indicates that this link was generated during the update from Drupal 5.',
  PRIMARY KEY  (`mlid`),
  KEY `path_menu` (`link_path`(128),`menu_name`),
  KEY `menu_plid_expand_child` (`menu_name`,`plid`,`expanded`,`has_children`),
  KEY `menu_parents` (`menu_name`,`p1`,`p2`,`p3`,`p4`,`p5`,`p6`,`p7`,`p8`,`p9`),
  KEY `router_path` (`router_path`(128))
) ENGINE=InnoDB AUTO_INCREMENT=895 DEFAULT CHARSET=utf8 COMMENT='Contains the individual links within a menu.';

CREATE TABLE `menu_router` (
  `path` varchar(255) NOT NULL default '' COMMENT 'Primary Key: the Drupal path this entry describes',
  `load_functions` blob NOT NULL COMMENT 'A serialized array of function names (like node_load) to be called to load an object corresponding to a part of the current path.',
  `to_arg_functions` blob NOT NULL COMMENT 'A serialized array of function names (like user_uid_optional_to_arg) to be called to replace a part of the router path with another string.',
  `access_callback` varchar(255) NOT NULL default '' COMMENT 'The callback which determines the access to this router path. Defaults to user_access.',
  `access_arguments` blob COMMENT 'A serialized array of arguments for the access callback.',
  `page_callback` varchar(255) NOT NULL default '' COMMENT 'The name of the function that renders the page.',
  `page_arguments` blob COMMENT 'A serialized array of arguments for the page callback.',
  `delivery_callback` varchar(255) NOT NULL default '' COMMENT 'The name of the function that sends the result of the page_callback function to the browser.',
  `fit` int(11) NOT NULL default '0' COMMENT 'A numeric representation of how specific the path is.',
  `number_parts` smallint(6) NOT NULL default '0' COMMENT 'Number of parts in this router path.',
  `context` int(11) NOT NULL default '0' COMMENT 'Only for local tasks (tabs) - the context of a local task to control its placement.',
  `tab_parent` varchar(255) NOT NULL default '' COMMENT 'Only for local tasks (tabs) - the router path of the parent page (which may also be a local task).',
  `tab_root` varchar(255) NOT NULL default '' COMMENT 'Router path of the closest non-tab parent page. For pages that are not local tasks, this will be the same as the path.',
  `title` varchar(255) NOT NULL default '' COMMENT 'The title for the current page, or the title for the tab if this is a local task.',
  `title_callback` varchar(255) NOT NULL default '' COMMENT 'A function which will alter the title. Defaults to t()',
  `title_arguments` varchar(255) NOT NULL default '' COMMENT 'A serialized array of arguments for the title callback. If empty, the title will be used as the sole argument for the title callback.',
  `theme_callback` varchar(255) NOT NULL default '' COMMENT 'A function which returns the name of the theme that will be used to render this page. If left empty, the default theme will be used.',
  `theme_arguments` varchar(255) NOT NULL default '' COMMENT 'A serialized array of arguments for the theme callback.',
  `type` int(11) NOT NULL default '0' COMMENT 'Numeric representation of the type of the menu item, like MENU_LOCAL_TASK.',
  `description` text NOT NULL COMMENT 'A description of this item.',
  `position` varchar(255) NOT NULL default '' COMMENT 'The position of the block (left or right) on the system administration page for this item.',
  `weight` int(11) NOT NULL default '0' COMMENT 'Weight of the element. Lighter weights are higher up, heavier weights go down.',
  `include_file` mediumtext COMMENT 'The file to include for this element, usually the page callback function lives in this file.',
  PRIMARY KEY  (`path`),
  KEY `fit` (`fit`),
  KEY `tab_parent` (`tab_parent`(64),`weight`,`title`),
  KEY `tab_root_weight_title` (`tab_root`(64),`weight`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps paths to various callbacks (access, page and title)';

CREATE TABLE `node` (
  `nid` int(10) unsigned NOT NULL auto_increment COMMENT 'The primary identifier for a node.',
  `vid` int(10) unsigned default NULL COMMENT 'The current node_revision.vid version identifier.',
  `type` varchar(32) NOT NULL default '' COMMENT 'The node_type.type of this node.',
  `language` varchar(12) NOT NULL default '' COMMENT 'The languages.language of this node.',
  `title` varchar(255) NOT NULL default '' COMMENT 'The title of this node, always treated as non-markup plain text.',
  `uid` int(11) NOT NULL default '0' COMMENT 'The users.uid that owns this node; initially, this is the user that created it.',
  `status` int(11) NOT NULL default '1' COMMENT 'Boolean indicating whether the node is published (visible to non-administrators).',
  `created` int(11) NOT NULL default '0' COMMENT 'The Unix timestamp when the node was created.',
  `changed` int(11) NOT NULL default '0' COMMENT 'The Unix timestamp when the node was most recently saved.',
  `comment` int(11) NOT NULL default '0' COMMENT 'Whether comments are allowed on this node: 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL default '0' COMMENT 'Boolean indicating whether the node should be displayed on the front page.',
  `sticky` int(11) NOT NULL default '0' COMMENT 'Boolean indicating whether the node should be displayed at the top of lists in which it appears.',
  `tnid` int(10) unsigned NOT NULL default '0' COMMENT 'The translation set id for this node, which equals the node id of the source post in each set.',
  `translate` int(11) NOT NULL default '0' COMMENT 'A boolean indicating whether this translation page needs to be updated.',
  PRIMARY KEY  (`nid`),
  UNIQUE KEY `vid` (`vid`),
  KEY `node_changed` (`changed`),
  KEY `node_created` (`created`),
  KEY `node_frontpage` (`promote`,`status`,`sticky`,`created`),
  KEY `node_status_type` (`status`,`type`,`nid`),
  KEY `node_title_type` (`title`,`type`(4)),
  KEY `node_type` (`type`(4)),
  KEY `uid` (`uid`),
  KEY `tnid` (`tnid`),
  KEY `translate` (`translate`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='The base table for nodes.';

CREATE TABLE `node_access` (
  `nid` int(10) unsigned NOT NULL default '0' COMMENT 'The node.nid this record affects.',
  `gid` int(10) unsigned NOT NULL default '0' COMMENT 'The grant ID a user must possess in the specified realm to gain this row’s privileges on the node.',
  `realm` varchar(255) NOT NULL default '' COMMENT 'The realm in which the user must possess the grant ID. Each node access node can define one or more realms.',
  `grant_view` tinyint(3) unsigned NOT NULL default '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can view this node.',
  `grant_update` tinyint(3) unsigned NOT NULL default '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can edit this node.',
  `grant_delete` tinyint(3) unsigned NOT NULL default '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can delete this node.',
  PRIMARY KEY  (`nid`,`gid`,`realm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Identifies which realm/grant pairs a user must possess in...';

CREATE TABLE `node_comment_statistics` (
  `nid` int(10) unsigned NOT NULL default '0' COMMENT 'The node.nid for which the statistics are compiled.',
  `cid` int(11) NOT NULL default '0' COMMENT 'The comment.cid of the last comment.',
  `last_comment_timestamp` int(11) NOT NULL default '0' COMMENT 'The Unix timestamp of the last comment that was posted within this node, from comment.changed.',
  `last_comment_name` varchar(60) default NULL COMMENT 'The name of the latest author to post a comment on this node, from comment.name.',
  `last_comment_uid` int(11) NOT NULL default '0' COMMENT 'The user ID of the latest author to post a comment on this node, from comment.uid.',
  `comment_count` int(10) unsigned NOT NULL default '0' COMMENT 'The total number of comments on this node.',
  PRIMARY KEY  (`nid`),
  KEY `node_comment_timestamp` (`last_comment_timestamp`),
  KEY `comment_count` (`comment_count`),
  KEY `last_comment_uid` (`last_comment_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains statistics of node and comments posts to show ...';

CREATE TABLE `node_revision` (
  `nid` int(10) unsigned NOT NULL default '0' COMMENT 'The node this version belongs to.',
  `vid` int(10) unsigned NOT NULL auto_increment COMMENT 'The primary identifier for this version.',
  `uid` int(11) NOT NULL default '0' COMMENT 'The users.uid that created this version.',
  `title` varchar(255) NOT NULL default '' COMMENT 'The title of this version.',
  `log` longtext NOT NULL COMMENT 'The log entry explaining the changes in this version.',
  `timestamp` int(11) NOT NULL default '0' COMMENT 'A Unix timestamp indicating when this version was created.',
  `status` int(11) NOT NULL default '1' COMMENT 'Boolean indicating whether the node (at the time of this revision) is published (visible to non-administrators).',
  `comment` int(11) NOT NULL default '0' COMMENT 'Whether comments are allowed on this node (at the time of this revision): 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL default '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed on the front page.',
  `sticky` int(11) NOT NULL default '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed at the top of lists in which it appears.',
  PRIMARY KEY  (`vid`),
  KEY `nid` (`nid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='Stores information about each saved version of a node.';

CREATE TABLE `node_type` (
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type.',
  `name` varchar(255) NOT NULL default '' COMMENT 'The human-readable name of this type.',
  `base` varchar(255) NOT NULL COMMENT 'The base string used to construct callbacks corresponding to this node type.',
  `module` varchar(255) NOT NULL COMMENT 'The module defining this node type.',
  `description` mediumtext NOT NULL COMMENT 'A brief description of this type.',
  `help` mediumtext NOT NULL COMMENT 'Help information shown to the user when creating a node of this type.',
  `has_title` tinyint(3) unsigned NOT NULL COMMENT 'Boolean indicating whether this type uses the node.title field.',
  `title_label` varchar(255) NOT NULL default '' COMMENT 'The label displayed for the title field on the edit form.',
  `custom` tinyint(4) NOT NULL default '0' COMMENT 'A boolean indicating whether this type is defined by a module (FALSE) or by a user via Add content type (TRUE).',
  `modified` tinyint(4) NOT NULL default '0' COMMENT 'A boolean indicating whether this type has been modified by an administrator; currently not used in any way.',
  `locked` tinyint(4) NOT NULL default '0' COMMENT 'A boolean indicating whether the administrator can change the machine name of this type.',
  `disabled` tinyint(4) NOT NULL default '0' COMMENT 'A boolean indicating whether the node type is disabled.',
  `orig_type` varchar(255) NOT NULL default '' COMMENT 'The original machine-readable name of this node type. This may be different from the current type name if the locked field is 0.',
  PRIMARY KEY  (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about all defined node types.';

CREATE TABLE `page_manager_handlers` (
  `did` int(11) NOT NULL auto_increment COMMENT 'Primary ID field for the table. Not used for anything except internal lookups.',
  `name` varchar(255) default NULL COMMENT 'Unique ID for this task handler. Used to identify it programmatically.',
  `task` varchar(64) default NULL COMMENT 'ID of the task this handler is for.',
  `subtask` varchar(64) NOT NULL default '' COMMENT 'ID of the subtask this handler is for.',
  `handler` varchar(64) default NULL COMMENT 'ID of the task handler being used.',
  `weight` int(11) default NULL COMMENT 'The order in which this handler appears. Lower numbers go first.',
  `conf` longtext NOT NULL COMMENT 'Serialized configuration of the handler, if needed.',
  PRIMARY KEY  (`did`),
  UNIQUE KEY `name` (`name`),
  KEY `fulltask` (`task`,`subtask`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `page_manager_pages` (
  `pid` int(11) NOT NULL auto_increment COMMENT 'Primary ID field for the table. Not used for anything except internal lookups.',
  `name` varchar(255) default NULL COMMENT 'Unique ID for this subtask. Used to identify it programmatically.',
  `task` varchar(64) default 'page' COMMENT 'What type of page this is, so that we can use the same mechanism for creating tighter UIs for targeted pages.',
  `admin_title` varchar(255) default NULL COMMENT 'Human readable title for this page subtask.',
  `admin_description` longtext COMMENT 'Administrative description of this item.',
  `path` varchar(255) default NULL COMMENT 'The menu path that will invoke this task.',
  `access` longtext NOT NULL COMMENT 'Access configuration for this path.',
  `menu` longtext NOT NULL COMMENT 'Serialized configuration of Drupal menu visibility settings for this item.',
  `arguments` longtext NOT NULL COMMENT 'Configuration of arguments for this menu item.',
  `conf` longtext NOT NULL COMMENT 'Serialized configuration of the page, if needed.',
  PRIMARY KEY  (`pid`),
  UNIQUE KEY `name` (`name`),
  KEY `task` (`task`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains page subtasks for implementing pages with...';

CREATE TABLE `page_manager_weights` (
  `name` varchar(255) NOT NULL default '' COMMENT 'Unique ID for this task handler. Used to identify it programmatically.',
  `weight` int(11) default NULL COMMENT 'The order in which this handler appears. Lower numbers go first.',
  PRIMARY KEY  (`name`),
  KEY `weights` (`name`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains override weights for page_manager handlers that...';

CREATE TABLE `queue` (
  `item_id` int(10) unsigned NOT NULL auto_increment COMMENT 'Primary Key: Unique item ID.',
  `name` varchar(255) NOT NULL default '' COMMENT 'The queue name.',
  `data` longblob COMMENT 'The arbitrary data for the item.',
  `expire` int(11) NOT NULL default '0' COMMENT 'Timestamp when the claim lease expires on the item.',
  `created` int(11) NOT NULL default '0' COMMENT 'Timestamp when the item was created.',
  PRIMARY KEY  (`item_id`),
  KEY `name_created` (`name`,`created`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8 COMMENT='Stores items in queues.';

CREATE TABLE `rdf_mapping` (
  `type` varchar(128) NOT NULL COMMENT 'The name of the entity type a mapping applies to (node, user, comment, etc.).',
  `bundle` varchar(128) NOT NULL COMMENT 'The name of the bundle a mapping applies to.',
  `mapping` longblob COMMENT 'The serialized mapping of the bundle type and fields to RDF terms.',
  PRIMARY KEY  (`type`,`bundle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores custom RDF mappings for user defined content types...';

CREATE TABLE `registry` (
  `name` varchar(255) NOT NULL default '' COMMENT 'The name of the function, class, or interface.',
  `type` varchar(9) NOT NULL default '' COMMENT 'Either function or class or interface.',
  `filename` varchar(255) NOT NULL COMMENT 'Name of the file.',
  `module` varchar(255) NOT NULL default '' COMMENT 'Name of the module the file belongs to.',
  `weight` int(11) NOT NULL default '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.',
  PRIMARY KEY  (`name`,`type`),
  KEY `hook` (`type`,`weight`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each record is a function, class, or interface name and...';

CREATE TABLE `registry_file` (
  `filename` varchar(255) NOT NULL COMMENT 'Path to the file.',
  `hash` varchar(64) NOT NULL COMMENT 'sha-256 hash of the file’s contents when last parsed.',
  PRIMARY KEY  (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Files parsed to build the registry.';

CREATE TABLE `role` (
  `rid` int(10) unsigned NOT NULL auto_increment COMMENT 'Primary Key: Unique role ID.',
  `name` varchar(64) NOT NULL default '' COMMENT 'Unique role name.',
  `weight` int(11) NOT NULL default '0' COMMENT 'The weight of this role in listings and the user interface.',
  PRIMARY KEY  (`rid`),
  UNIQUE KEY `name` (`name`),
  KEY `name_weight` (`name`,`weight`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='Stores user roles.';

CREATE TABLE `role_permission` (
  `rid` int(10) unsigned NOT NULL COMMENT 'Foreign Key: role.rid.',
  `permission` varchar(128) NOT NULL default '' COMMENT 'A single permission granted to the role identified by rid.',
  `module` varchar(255) NOT NULL default '' COMMENT 'The module declaring the permission.',
  PRIMARY KEY  (`rid`,`permission`),
  KEY `permission` (`permission`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the permissions assigned to user roles.';

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `search_dataset` (
  `sid` int(10) unsigned NOT NULL default '0' COMMENT 'Search item ID, e.g. node ID for nodes.',
  `type` varchar(16) NOT NULL COMMENT 'Type of item, e.g. node.',
  `data` longtext NOT NULL COMMENT 'List of space-separated words from the item.',
  `reindex` int(10) unsigned NOT NULL default '0' COMMENT 'Set to force node reindexing.',
  PRIMARY KEY  (`sid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items that will be searched.';

CREATE TABLE `search_index` (
  `word` varchar(50) NOT NULL default '' COMMENT 'The search_total.word that is associated with the search item.',
  `sid` int(10) unsigned NOT NULL default '0' COMMENT 'The search_dataset.sid of the searchable item to which the word belongs.',
  `type` varchar(16) NOT NULL COMMENT 'The search_dataset.type of the searchable item to which the word belongs.',
  `score` float default NULL COMMENT 'The numeric score of the word, higher being more important.',
  PRIMARY KEY  (`word`,`sid`,`type`),
  KEY `sid_type` (`sid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the search index, associating words, items and...';

CREATE TABLE `search_node_links` (
  `sid` int(10) unsigned NOT NULL default '0' COMMENT 'The search_dataset.sid of the searchable item containing the link to the node.',
  `type` varchar(16) NOT NULL default '' COMMENT 'The search_dataset.type of the searchable item containing the link to the node.',
  `nid` int(10) unsigned NOT NULL default '0' COMMENT 'The node.nid that this item links to.',
  `caption` longtext COMMENT 'The text used to link to the node.nid.',
  PRIMARY KEY  (`sid`,`type`,`nid`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items (like nodes) that link to other nodes, used...';

CREATE TABLE `search_total` (
  `word` varchar(50) NOT NULL default '' COMMENT 'Primary Key: Unique word in the search index.',
  `count` float default NULL COMMENT 'The count of the word in the index using Zipf’s law to equalize the probability distribution.',
  PRIMARY KEY  (`word`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores search totals for words.';

CREATE TABLE `semaphore` (
  `name` varchar(255) NOT NULL default '' COMMENT 'Primary Key: Unique name.',
  `value` varchar(255) NOT NULL default '' COMMENT 'A value for the semaphore.',
  `expire` double NOT NULL COMMENT 'A Unix timestamp with microseconds indicating when the semaphore should expire.',
  PRIMARY KEY  (`name`),
  KEY `value` (`value`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for holding semaphores, locks, flags, etc. that...';

CREATE TABLE `sequences` (
  `value` int(10) unsigned NOT NULL auto_increment COMMENT 'The value of the sequence.',
  PRIMARY KEY  (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8 COMMENT='Stores IDs.';

CREATE TABLE `sessions` (
  `uid` int(10) unsigned NOT NULL COMMENT 'The users.uid corresponding to a session, or 0 for anonymous user.',
  `sid` varchar(128) NOT NULL COMMENT 'A session ID. The value is generated by Drupal’s session handlers.',
  `ssid` varchar(128) NOT NULL default '' COMMENT 'Secure session ID. The value is generated by Drupal’s session handlers.',
  `hostname` varchar(128) NOT NULL default '' COMMENT 'The IP address that last used this session ID (sid).',
  `timestamp` int(11) NOT NULL default '0' COMMENT 'The Unix timestamp when this session last requested a page. Old records are purged by PHP automatically.',
  `cache` int(11) NOT NULL default '0' COMMENT 'The time of this user’s last post. This is used when the site has specified a minimum_cache_lifetime. See cache_get().',
  `session` longblob COMMENT 'The serialized contents of $_SESSION, an array of name/value pairs that persists across page requests by this session ID. Drupal loads $_SESSION from here at the start of each request and saves it at the end.',
  PRIMARY KEY  (`sid`,`ssid`),
  KEY `timestamp` (`timestamp`),
  KEY `uid` (`uid`),
  KEY `ssid` (`ssid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Drupal’s session handlers read and write into the...';

CREATE TABLE `shortcut_set` (
  `set_name` varchar(32) NOT NULL default '' COMMENT 'Primary Key: The menu_links.menu_name under which the set’s links are stored.',
  `title` varchar(255) NOT NULL default '' COMMENT 'The title of the set.',
  PRIMARY KEY  (`set_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about sets of shortcuts links.';

CREATE TABLE `shortcut_set_users` (
  `uid` int(10) unsigned NOT NULL default '0' COMMENT 'The users.uid for this set.',
  `set_name` varchar(32) NOT NULL default '' COMMENT 'The shortcut_set.set_name that will be displayed for this user.',
  PRIMARY KEY  (`uid`),
  KEY `set_name` (`set_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to shortcut sets.';

CREATE TABLE `site_verify` (
  `svid` int(10) unsigned NOT NULL auto_increment COMMENT 'Primary Key: Unique site verification ID.',
  `engine` varchar(32) NOT NULL default '',
  `file` varchar(255) default '',
  `file_contents` longtext NOT NULL,
  `meta` text NOT NULL,
  PRIMARY KEY  (`svid`),
  KEY `engine` (`engine`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `stylizer` (
  `sid` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL COMMENT 'Unique ID for this style. Used to identify it programmatically.',
  `admin_title` varchar(255) default NULL COMMENT 'Human readable title for this style.',
  `admin_description` longtext COMMENT 'Administrative description of this style.',
  `settings` longtext COMMENT 'A serialized array of settings specific to the style base that describes this plugin.',
  PRIMARY KEY  (`sid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customized stylizer styles created by administrative users.';

CREATE TABLE `system` (
  `filename` varchar(255) NOT NULL default '' COMMENT 'The path of the primary file for this item, relative to the Drupal root; e.g. modules/node/node.module.',
  `name` varchar(255) NOT NULL default '' COMMENT 'The name of the item; e.g. node.',
  `type` varchar(12) NOT NULL default '' COMMENT 'The type of the item, either module, theme, or theme_engine.',
  `owner` varchar(255) NOT NULL default '' COMMENT 'A theme’s ’parent’ . Can be either a theme or an engine.',
  `status` int(11) NOT NULL default '0' COMMENT 'Boolean indicating whether or not this item is enabled.',
  `bootstrap` int(11) NOT NULL default '0' COMMENT 'Boolean indicating whether this module is loaded during Drupal’s early bootstrapping phase (e.g. even before the page cache is consulted).',
  `schema_version` smallint(6) NOT NULL default '-1' COMMENT 'The module’s database schema version number. -1 if the module is not installed (its tables do not exist); 0 or the largest N of the module’s hook_update_N() function that has either been run or existed when the module was first installed.',
  `weight` int(11) NOT NULL default '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.',
  `info` blob COMMENT 'A serialized array containing information from the module’s .info file; keys can include name, description, package, version, core, dependencies, and php.',
  PRIMARY KEY  (`filename`),
  KEY `system_list` (`status`,`bootstrap`,`type`,`weight`,`name`),
  KEY `type_name` (`type`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of all modules, themes, and theme engines that are...';

CREATE TABLE `taxonomy_access_default` (
  `vid` int(10) unsigned NOT NULL default '0' COMMENT 'The vocabulary.vid for which this row sets defaults.',
  `rid` int(10) unsigned NOT NULL default '0' COMMENT 'The role.rid a user must possess to gain this row’s privileges on nodes for terms in this vocabulary.',
  `grant_view` tinyint(3) unsigned NOT NULL default '0' COMMENT 'Whether this role can view nodes with terms in this vocabulary. 0=>Ignore, 1=>Allow, 2=>Deny.',
  `grant_update` tinyint(3) unsigned NOT NULL default '0' COMMENT 'Whether this role can edit nodes with terms in this vocabulary. 0=>Ignore, 1=>Allow, 2=>Deny.',
  `grant_delete` tinyint(3) unsigned NOT NULL default '0' COMMENT 'Whether this role can delete nodes with terms in this vocabulary. 0=>Ignore, 1=>Allow, 2=>Deny.',
  `grant_create` tinyint(3) unsigned NOT NULL default '0' COMMENT 'Whether this role can set terms in this vocabulary when adding or editing a node. 0=>No, 1=>Yes.',
  `grant_list` tinyint(3) unsigned NOT NULL default '0' COMMENT 'Whether this role can view the name of terms in this vocabulary on a node or in category lists. 0=>No, 1=>Yes.',
  PRIMARY KEY  (`vid`,`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets vocabulary defaults which roles may view, update,...';

CREATE TABLE `taxonomy_access_term` (
  `tid` int(10) unsigned NOT NULL default '0' COMMENT 'The term_data.tid this record affects.  Overrides vocabulary default in taxonomy_access_default.',
  `rid` int(10) unsigned NOT NULL default '0' COMMENT 'The role.rid a user must possess to gain this row’s privileges on nodes for this term.',
  `grant_view` tinyint(3) unsigned NOT NULL default '0' COMMENT 'Whether this role can view nodes with this term. 0=>Ignore, 1=>Allow, 2=>Deny.',
  `grant_update` tinyint(3) unsigned NOT NULL default '0' COMMENT 'Whether this role can edit nodes with this term. 0=>Ignore, 1=>Allow, 2=>Deny.',
  `grant_delete` tinyint(3) unsigned NOT NULL default '0' COMMENT 'Whether this role can delete nodes with this term. 0=>Ignore, 1=>Allow, 2=>Deny.',
  `grant_create` tinyint(3) unsigned NOT NULL default '0' COMMENT 'Whether this role can set this term when adding or editing a node. 0=>No, 1=>Yes.',
  `grant_list` tinyint(3) unsigned NOT NULL default '1' COMMENT 'Whether this role can view the name of this term on a node or in category lists. 0=>No, 1=>Yes.',
  PRIMARY KEY  (`tid`,`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Identifies which roles may view, update, delete, create,...';

CREATE TABLE `taxonomy_index` (
  `nid` int(10) unsigned NOT NULL default '0' COMMENT 'The node.nid this record tracks.',
  `tid` int(10) unsigned NOT NULL default '0' COMMENT 'The term ID.',
  `sticky` tinyint(4) default '0' COMMENT 'Boolean indicating whether the node is sticky.',
  `created` int(11) NOT NULL default '0' COMMENT 'The Unix timestamp when the node was created.',
  KEY `term_node` (`tid`,`sticky`,`created`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains denormalized information about node/term...';

CREATE TABLE `taxonomy_term_data` (
  `tid` int(10) unsigned NOT NULL auto_increment COMMENT 'Primary Key: Unique term ID.',
  `vid` int(10) unsigned NOT NULL default '0' COMMENT 'The taxonomy_vocabulary.vid of the vocabulary to which the term is assigned.',
  `name` varchar(255) NOT NULL default '' COMMENT 'The term name.',
  `description` longtext COMMENT 'A description of the term.',
  `format` varchar(255) default NULL COMMENT 'The filter_format.format of the description.',
  `weight` int(11) NOT NULL default '0' COMMENT 'The weight of this term in relation to other terms.',
  PRIMARY KEY  (`tid`),
  KEY `taxonomy_tree` (`vid`,`weight`,`name`),
  KEY `vid_name` (`vid`,`name`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='Stores term information.';

CREATE TABLE `taxonomy_term_hierarchy` (
  `tid` int(10) unsigned NOT NULL default '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term.',
  `parent` int(10) unsigned NOT NULL default '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term’s parent. 0 indicates no parent.',
  PRIMARY KEY  (`tid`,`parent`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the hierarchical relationship between terms.';

CREATE TABLE `taxonomy_vocabulary` (
  `vid` int(10) unsigned NOT NULL auto_increment COMMENT 'Primary Key: Unique vocabulary ID.',
  `name` varchar(255) NOT NULL default '' COMMENT 'Name of the vocabulary.',
  `machine_name` varchar(255) NOT NULL default '' COMMENT 'The vocabulary machine name.',
  `description` longtext COMMENT 'Description of the vocabulary.',
  `hierarchy` tinyint(3) unsigned NOT NULL default '0' COMMENT 'The type of hierarchy allowed within the vocabulary. (0 = disabled, 1 = single, 2 = multiple)',
  `module` varchar(255) NOT NULL default '' COMMENT 'The module which created the vocabulary.',
  `weight` int(11) NOT NULL default '0' COMMENT 'The weight of this vocabulary in relation to other vocabularies.',
  PRIMARY KEY  (`vid`),
  UNIQUE KEY `machine_name` (`machine_name`),
  KEY `list` (`weight`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Stores vocabulary information.';

CREATE TABLE `url_alias` (
  `pid` int(10) unsigned NOT NULL auto_increment COMMENT 'A unique path alias identifier.',
  `source` varchar(255) NOT NULL default '' COMMENT 'The Drupal path this alias is for; e.g. node/12.',
  `alias` varchar(255) NOT NULL default '' COMMENT 'The alias for this path; e.g. title-of-the-story.',
  `language` varchar(12) NOT NULL default '' COMMENT 'The language this alias is for; if ’und’, the alias will be used for unknown languages. Each Drupal path can have an alias for each supported language.',
  PRIMARY KEY  (`pid`),
  KEY `alias_language_pid` (`alias`,`language`,`pid`),
  KEY `source_language_pid` (`source`,`language`,`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='A list of URL aliases for Drupal paths; a user may visit...';

CREATE TABLE `users` (
  `uid` int(10) unsigned NOT NULL default '0' COMMENT 'Primary Key: Unique user ID.',
  `name` varchar(60) NOT NULL default '' COMMENT 'Unique user name.',
  `pass` varchar(128) NOT NULL default '' COMMENT 'User’s password (hashed).',
  `mail` varchar(254) default '' COMMENT 'User’s e-mail address.',
  `theme` varchar(255) NOT NULL default '' COMMENT 'User’s default theme.',
  `signature` varchar(255) NOT NULL default '' COMMENT 'User’s signature.',
  `signature_format` varchar(255) default NULL COMMENT 'The filter_format.format of the signature.',
  `created` int(11) NOT NULL default '0' COMMENT 'Timestamp for when user was created.',
  `access` int(11) NOT NULL default '0' COMMENT 'Timestamp for previous time user accessed the site.',
  `login` int(11) NOT NULL default '0' COMMENT 'Timestamp for user’s last login.',
  `status` tinyint(4) NOT NULL default '0' COMMENT 'Whether the user is active(1) or blocked(0).',
  `timezone` varchar(32) default NULL COMMENT 'User’s time zone.',
  `language` varchar(12) NOT NULL default '' COMMENT 'User’s default language.',
  `picture` int(11) NOT NULL default '0' COMMENT 'Foreign key: file_managed.fid of user’s picture.',
  `init` varchar(254) default '' COMMENT 'E-mail address used for initial account creation.',
  `data` longblob COMMENT 'A serialized array of name value pairs that are related to the user. Any form values posted during user edit are stored and are loaded into the $user object during user_load(). Use of this field is discouraged and it will likely disappear in a future...',
  PRIMARY KEY  (`uid`),
  UNIQUE KEY `name` (`name`),
  KEY `access` (`access`),
  KEY `created` (`created`),
  KEY `mail` (`mail`),
  KEY `picture` (`picture`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores user data.';

CREATE TABLE `users_roles` (
  `uid` int(10) unsigned NOT NULL default '0' COMMENT 'Primary Key: users.uid for user.',
  `rid` int(10) unsigned NOT NULL default '0' COMMENT 'Primary Key: role.rid for role.',
  PRIMARY KEY  (`uid`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to roles.';

CREATE TABLE `variable` (
  `name` varchar(128) NOT NULL default '' COMMENT 'The name of the variable.',
  `value` longblob NOT NULL COMMENT 'The value of the variable.',
  PRIMARY KEY  (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Named variable/value pairs created by Drupal core or any...';

CREATE TABLE `views_display` (
  `vid` int(10) unsigned NOT NULL default '0' COMMENT 'The view this display is attached to.',
  `id` varchar(64) NOT NULL default '' COMMENT 'An identifier for this display; usually generated from the display_plugin, so should be something like page or page_1 or block_2, etc.',
  `display_title` varchar(64) NOT NULL default '' COMMENT 'The title of the display, viewable by the administrator.',
  `display_plugin` varchar(64) NOT NULL default '' COMMENT 'The type of the display. Usually page, block or embed, but is pluggable so may be other things.',
  `position` int(11) default '0' COMMENT 'The order in which this display is loaded.',
  `display_options` longtext COMMENT 'A serialized array of options for this display; it contains options that are generally only pertinent to that display plugin type.',
  PRIMARY KEY  (`vid`,`id`),
  KEY `vid` (`vid`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about each display attached to a view.';

CREATE TABLE `views_view` (
  `vid` int(10) unsigned NOT NULL auto_increment COMMENT 'The view ID of the field, defined by the database.',
  `name` varchar(128) NOT NULL default '' COMMENT 'The unique name of the view. This is the primary field views are loaded from, and is used so that views may be internal and not necessarily in the database. May only be alphanumeric characters plus underscores.',
  `description` varchar(255) default '' COMMENT 'A description of the view for the admin interface.',
  `tag` varchar(255) default '' COMMENT 'A tag used to group/sort views in the admin interface',
  `base_table` varchar(64) NOT NULL default '' COMMENT 'What table this view is based on, such as node, user, comment, or term.',
  `human_name` varchar(255) default '' COMMENT 'A human readable name used to be displayed in the admin interface',
  `core` int(11) default '0' COMMENT 'Stores the drupal core version of the view.',
  PRIMARY KEY  (`vid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the general data for a view.';

CREATE TABLE `volunteers` (
  `id` int(11) NOT NULL auto_increment,
  `first_name` varchar(255) default NULL,
  `last_name` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `sid` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `watchdog` (
  `wid` int(11) NOT NULL auto_increment COMMENT 'Primary Key: Unique watchdog event ID.',
  `uid` int(11) NOT NULL default '0' COMMENT 'The users.uid of the user who triggered the event.',
  `type` varchar(64) NOT NULL default '' COMMENT 'Type of log message, for example "user" or "page not found."',
  `message` longtext NOT NULL COMMENT 'Text of log message to be passed into the t() function.',
  `variables` longblob NOT NULL COMMENT 'Serialized array of variables that match the message string and that is passed into the t() function.',
  `severity` tinyint(3) unsigned NOT NULL default '0' COMMENT 'The severity level of the event; ranges from 0 (Emergency) to 7 (Debug)',
  `link` varchar(255) default '' COMMENT 'Link to view the result of the event.',
  `location` text NOT NULL COMMENT 'URL of the origin of the event.',
  `referer` text COMMENT 'URL of referring page.',
  `hostname` varchar(128) NOT NULL default '' COMMENT 'Hostname of the user who triggered the event.',
  `timestamp` int(11) NOT NULL default '0' COMMENT 'Unix timestamp of when event occurred.',
  PRIMARY KEY  (`wid`),
  KEY `type` (`type`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=8807 DEFAULT CHARSET=utf8 COMMENT='Table that contains logs of all system events.';

CREATE TABLE `webform` (
  `nid` int(10) unsigned NOT NULL COMMENT 'The node identifier of a webform.',
  `confirmation` text NOT NULL COMMENT 'The confirmation message or URL displayed to the user after submitting a form.',
  `confirmation_format` varchar(255) default NULL COMMENT 'The filter_format.format of the confirmation message.',
  `redirect_url` varchar(255) default '<confirmation>' COMMENT 'The URL a user is redirected to after submitting a form.',
  `status` tinyint(4) NOT NULL default '1' COMMENT 'Boolean value of a webform for open (1) or closed (0).',
  `block` tinyint(4) NOT NULL default '0' COMMENT 'Boolean value for whether this form be available as a block.',
  `teaser` tinyint(4) NOT NULL default '0' COMMENT 'Boolean value for whether the entire form should be displayed on the teaser.',
  `allow_draft` tinyint(4) NOT NULL default '0' COMMENT 'Boolean value for whether submissions to this form be saved as a draft.',
  `auto_save` tinyint(4) NOT NULL default '0' COMMENT 'Boolean value for whether submissions to this form should be auto-saved between pages.',
  `submit_notice` tinyint(4) NOT NULL default '1' COMMENT 'Boolean value for whether to show or hide the previous submissions notification.',
  `submit_text` varchar(255) default NULL COMMENT 'The title of the submit button on the form.',
  `submit_limit` tinyint(4) NOT NULL default '-1' COMMENT 'The number of submissions a single user is allowed to submit within an interval. -1 is unlimited.',
  `submit_interval` int(11) NOT NULL default '-1' COMMENT 'The amount of time in seconds that must pass before a user can submit another submission within the set limit.',
  `total_submit_limit` int(11) NOT NULL default '-1',
  `total_submit_interval` int(11) NOT NULL default '-1',
  PRIMARY KEY  (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for storing additional properties for webform nodes.';

CREATE TABLE `webform_component` (
  `nid` int(10) unsigned NOT NULL default '0' COMMENT 'The node identifier of a webform.',
  `cid` smallint(5) unsigned NOT NULL default '0' COMMENT 'The identifier for this component within this node, starts at 0 for each node.',
  `pid` smallint(5) unsigned NOT NULL default '0' COMMENT 'If this component has a parent fieldset, the cid of that component.',
  `form_key` varchar(128) default NULL COMMENT 'When the form is displayed and processed, this key can be used to reference the results.',
  `name` varchar(255) default NULL COMMENT 'The label for this component.',
  `type` varchar(16) default NULL COMMENT 'The field type of this component (textfield, select, hidden, etc.).',
  `value` text NOT NULL COMMENT 'The default value of the component when displayed to the end-user.',
  `extra` text NOT NULL COMMENT 'Additional information unique to the display or processing of this component.',
  `mandatory` tinyint(4) NOT NULL default '0' COMMENT 'Boolean flag for if this component is required.',
  `weight` smallint(6) NOT NULL default '0' COMMENT 'Determines the position of this component in the form.',
  PRIMARY KEY  (`nid`,`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about components for webform nodes.';

CREATE TABLE `webform_emails` (
  `nid` int(10) unsigned NOT NULL default '0' COMMENT 'The node identifier of a webform.',
  `eid` smallint(5) unsigned NOT NULL default '0' COMMENT 'The e-mail identifier for this row’s settings.',
  `email` text COMMENT 'The e-mail address that will be sent to upon submission. This may be an e-mail address, the special key "default" or a numeric value. If a numeric value is used, the value of a component will be substituted on submission.',
  `subject` varchar(255) default NULL COMMENT 'The e-mail subject that will be used. This may be a string, the special key "default" or a numeric value. If a numeric value is used, the value of a component will be substituted on submission.',
  `from_name` varchar(255) default NULL COMMENT 'The e-mail "from" name that will be used. This may be a string, the special key "default" or a numeric value. If a numeric value is used, the value of a component will be substituted on submission.',
  `from_address` varchar(255) default NULL COMMENT 'The e-mail "from" e-mail address that will be used. This may be a string, the special key "default" or a numeric value. If a numeric value is used, the value of a component will be substituted on submission.',
  `template` text COMMENT 'A template that will be used for the sent e-mail. This may be a string or the special key "default", which will use the template provided by the theming layer.',
  `excluded_components` text NOT NULL COMMENT 'A list of components that will not be included in the %email_values token. A list of CIDs separated by commas.',
  `html` tinyint(3) unsigned NOT NULL default '0' COMMENT 'Determines if the e-mail will be sent in an HTML format. Requires Mime Mail module.',
  `attachments` tinyint(3) unsigned NOT NULL default '0' COMMENT 'Determines if the e-mail will include file attachments. Requires Mime Mail module.',
  PRIMARY KEY  (`nid`,`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds information regarding e-mails that should be sent...';

CREATE TABLE `webform_last_download` (
  `nid` int(10) unsigned NOT NULL default '0' COMMENT 'The node identifier of a webform.',
  `uid` int(10) unsigned NOT NULL default '0' COMMENT 'The user identifier.',
  `sid` int(10) unsigned NOT NULL default '0' COMMENT 'The last downloaded submission number.',
  `requested` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`nid`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores last submission number per user download.';

CREATE TABLE `webform_roles` (
  `nid` int(10) unsigned NOT NULL default '0' COMMENT 'The node identifier of a webform.',
  `rid` int(10) unsigned NOT NULL default '0' COMMENT 'The role identifier.',
  PRIMARY KEY  (`nid`,`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds access information regarding which roles are...';

CREATE TABLE `webform_submissions` (
  `sid` int(10) unsigned NOT NULL auto_increment COMMENT 'The unique identifier for this submission.',
  `nid` int(10) unsigned NOT NULL default '0' COMMENT 'The node identifier of a webform.',
  `uid` int(10) unsigned NOT NULL default '0' COMMENT 'The id of the user that completed this submission.',
  `is_draft` tinyint(4) NOT NULL default '0' COMMENT 'Is this a draft of the submission?',
  `submitted` int(11) NOT NULL default '0' COMMENT 'Timestamp of when the form was submitted.',
  `remote_addr` varchar(128) default NULL COMMENT 'The IP address of the user that submitted the form.',
  PRIMARY KEY  (`sid`),
  UNIQUE KEY `sid_nid` (`sid`,`nid`),
  KEY `nid_uid_sid` (`nid`,`uid`,`sid`),
  KEY `nid_sid` (`nid`,`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=utf8 COMMENT='Holds general information about submissions outside of...';

CREATE TABLE `webform_submitted_data` (
  `nid` int(10) unsigned NOT NULL default '0' COMMENT 'The node identifier of a webform.',
  `sid` int(10) unsigned NOT NULL default '0' COMMENT 'The unique identifier for this submission.',
  `cid` smallint(5) unsigned NOT NULL default '0' COMMENT 'The identifier for this component within this node, starts at 0 for each node.',
  `no` varchar(128) NOT NULL default '0' COMMENT 'Usually this value is 0, but if a field has multiple values (such as a time or date), it may require multiple rows in the database.',
  `data` mediumtext NOT NULL COMMENT 'The submitted value of this field, may be serialized for some components.',
  PRIMARY KEY  (`nid`,`sid`,`cid`,`no`),
  KEY `nid` (`nid`),
  KEY `sid_nid` (`sid`,`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores all submitted field data for webform submissions.';

CREATE TABLE `wysiwyg` (
  `format` varchar(255) NOT NULL COMMENT 'The filter_format.format of the text format.',
  `editor` varchar(128) NOT NULL default '' COMMENT 'Internal name of the editor attached to the text format.',
  `settings` text COMMENT 'Configuration settings for the editor.',
  PRIMARY KEY  (`format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores Wysiwyg profiles.';

CREATE TABLE `wysiwyg_user` (
  `uid` int(10) unsigned NOT NULL default '0' COMMENT 'The users.uid of the user.',
  `format` varchar(255) default NULL COMMENT 'The filter_format.format of the text format.',
  `status` tinyint(3) unsigned NOT NULL default '0' COMMENT 'Boolean indicating whether the format is enabled by default.',
  KEY `uid` (`uid`),
  KEY `format` (`format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores user preferences for wysiwyg profiles.';

INSERT INTO schema_migrations (version) VALUES ('20120905184235');

INSERT INTO schema_migrations (version) VALUES ('20120905224017');