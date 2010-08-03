2010-08-03
==========
* Renamed to ThumbsUp from vote\_fu.
* Updated for Rails 3, using ActiveRecord/Arel.
* Cleaned up some dead code, some shitty code, and made a few methods take up quite a lot less memory and time (voters\_who\_voted).
* Removed some shitty example code - this gem is self-explanatory and straight-forward as-is.

2010-02-04
==========
* Remove vote.rb and votes_controller.rb from gem lib

2009-02-11
==========
* Merge in xlash's bugfix for PostgreSQL and his has\_karma patch for multi-model support.

2008-12-02
==========
* Merge in maddox's README typo fix and his ActiveSupport.Dependency patch
* Merge in nagybence's updates that make the code usable as a Gem in addition to being a Rails plugin.
* Thanks for the bugfixes and proofreading, nagybence and maddox!
* Updated the gemplugin support to be compatible with maddox and nagybence's changes.
* Added details on the MyQuotable reference application.

2008-07-20
==========
* Protect against mass assignment misvotes using attr\_accessible
* Update acts\_as mixins to use self.class.name instead of the deprecated self.type.name

2008-07-15
==========
* Added examples directory
* Changed this file to markdown format for GitHub goodness
* Added a commented out unique index in the migration generator for "one person, one vote"
* Removed votes\_controller.rb from lib/ and moved to examples

2008-07-10
==========

* Added a generator class for the migration.
* Implemented rails/init.rb
* Implemented capability to use any model as the initiator of votes.
* Implemented acts\_as\_voter methods.
