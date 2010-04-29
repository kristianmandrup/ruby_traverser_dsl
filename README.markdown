# Ruby code Query and Manipulation language ##

This Ruby DSL enables querying, traversing and manipulating Ruby code using a nice Rubish DSL.

1. First parsing the ruby code into an object graph using `ripper2ruby`
2. Query the graph to find the code constructs of interest using the Query API
3. Manipulate the code constructs using the Manipulation API

This project is a DSL layer on top of `ripper2ruby` which again is on top of `ripper` which comes with ruby 1.9. 
Ruby 1.9 is therefore a requirement! 

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

### Insert ##
* insert(position, code, &block)

### Update ##
* update(:select, :with, &block)
* update(:select, :with_code, &block)
* update(:value, &block)

Supports updating 
* arguments (for method calls, block and method definitions)
* assignment values (for assignments)

Argument find for update
* by position (fx :arg => '#1')
* by key name (fx :arg => :src) 
* by value (fx :arg => 'blip')

Note:
Update needs some polishing and is still a little buggy!
                                                              
TODO:
update identifier of module, class, method call and method definition. 

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