# Ruby traverser ##

A DSL for traversing ruby code as an object model (graph), which lets you find parts of the ruby code of interest.
The traverser leverages `ripper2ruby`, which leverages `ripper`, which comes with ruby 1.9. Ruby 1.9 is thus required.

See the unit tests in the test directory for examples of use. 
