require 'config/module'
require 'config/misc'
require 'config/has_ext'
require 'config/patch'

module Ruby
  class Node               
    include Extension::Patch    
    include Extension::Module
    include Extension::Misc
    include Extension::Has
  end    
end   

     