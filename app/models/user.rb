require 'digest/sha1'

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :extensions, :dependent => :destroy
  
  def self.per_page
    25
  end
  
  def self.extension_authors
    find(:all, :conditions => ["extensions_count > 0"])
  end
  
  def self.extension_authors_count
    count(:conditions => ["extensions_count > 0"])
  end
  
  def to_param
    [id, name_or_login].join('-').strip.gsub(/[^a-z0-9]+/i, '-').downcase
  end
  
  # TODO: what here?
  def to_xml(options={}, &block)
    super(options.reverse_merge(:except => [:crypted_password, :salt, :identity_url, :remember_token, :remember_token_expires_at]), &block)
  end
  
  def to_s
    name
  end
  alias to_str to_s

end
