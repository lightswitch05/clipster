module Clipster
  class Clip < ActiveRecord::Base
    before_create :init_id
    set_primary_key :id
    attr_accessible :clip, :language, :title, :private
    
    private
      def init_id
        self.id = Time.now.to_f.to_s.gsub('.','').to_i.to_s(36)
      end
  end
end
