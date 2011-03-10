class SeedTags < ActiveRecord::Migration
  def self.up
    tgs = %w( animals architecture  art asia  australia   autumn   baby   band   barcelona   
    beach   berlin   bike   bird   birds   birthday   black california   canada  car   cat   chicago   china   
    christmas   church   city   clouds   club   color   concert   dance   day  dog   england   
    europe   family   fashion   festival   film   florida   flower   flowers   food   
    football   france   friends   fun   garden   geotagged   germany   girl   girls  halloween   hawaii holiday   house   india   iphone   island   italia   italy   japan   kids 
    lake   landscape   light   live   london  macro   me   mexico mountain   
    mountains   museum   music   nature  newyork   newyorkcity   night   nikon   nyc   ocean   old   
    paris   park   party   people   photo   photography   photos   portrait river   rock  scotland   seattle  spain   
    spring   summer   sun  taiwan   texas  thailand  tokyo   toronto   tour   travel  trip   uk   usa   vacation   
    vintage   washington   wedding )
    
    tgs.each do |tg|
      ActsAsTaggableOn::Tag.create!(:name => tg)
    end
  end

  def self.down
  end
end
