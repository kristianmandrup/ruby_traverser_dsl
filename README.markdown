# Ruby traverser ##

A DSL for traversing ruby code as an object model (graph), which lets you find parts of the ruby code of interest.
The traverser leverages `ripper2ruby`, a library for generating a model from ruby source code. `ripper2ruby` leverages `ripper` which comes with ruby 1.9. 

See the unit tests in the test directory for examples of use.

See the [Wiki](http://wiki.github.com/kristianmandrup/ruby_traverser_dsl "Wiki") for more details.

## Requirements ##
* Ruby 1.9
* ripper2ruby >= 0.0.2 

## Ruby code Query API ##

See [Query API](http://wiki.github.com/kristianmandrup/ruby_traverser_dsl/finder-api "Query API")

* find(type, name, options, &block)
* inside (alias for find which requires a block argument)

The following symbols are supported `[:module, :class, :variable, :assignment, :call, :block, :def]`

## Manipulation API ##

See [Manipulation API](http://wiki.github.com/kristianmandrup/ruby_traverser_dsl/manipulation-api "Manipulation API")

The insert and update API support blocks and always returns the updated or inserted node
Note: The mutation API code was developed quickly in a test-driven fashion, but is in need of a major refactoring overhaul sometime soon...

### Insert ##
* insert(position, code, &block)

### Update ##
* update(:select, :with, &block)
* update(:select, :with_code, &block)
* update(:value, &block)

### Delete ##
* delete

## Note on Patches/Pull Requests ##
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright ##

Copyright (c) 2010 Kristian Mandrup. See LICENSE for details.