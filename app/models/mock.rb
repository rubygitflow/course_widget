class Mock < ApplicationRecord
  def self.deferred_deletion(id)
    find(id).destroy    
  end
end
