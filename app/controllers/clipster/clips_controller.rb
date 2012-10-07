require_dependency "clipster/application_controller"

module Clipster
  class ClipsController < ApplicationController
    def index
      create
      render 'create'
    end

    def list
      #list all or recent clips
    end
    
    def create
      @clip = Clip.new(params[:clip])
      
      #only do validation if something was actually posted.
      if !params[:clip].nil? && @clip.valid?
        @clip.save
        
        # craft url based on url_hash
        # TODO: look for cleaner way to do this as well as the select
        redirect_to :action => "show", :id => @clip.url_hash
        return #early return so we don't have else statement
      end
      
      # Get all languages we have syntax for and remove debugging languages.
      @languages = CodeRay::Scanners.all_plugins
      @languages.delete(CodeRay::Scanners::Raydebug)
      @languages.delete(CodeRay::Scanners::Debug)
    end
    
    def show
      @clip = Clip.find_by_url_hash(params[:id])
    end
  end
end
