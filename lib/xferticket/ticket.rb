# frozen_string_literal: true

require 'sequel'
require 'ostruct'
require 'sanitize'
require 'bcrypt'

module XferTickets
  # Tickets 
  class Ticket < Sequel::Model
    #Sequel::Model.plugin :timestamps, force: true, :update_on_create => true

    def before_destroy 
      puts "Deleting: #{self.uuid}"
      # replace w/ delete dir
      begin
        self.set_allow_uploads(true)
        FileUtils.remove_entry_secure(self.directory, true)
      rescue
        puts "Hmmmm... could not find data dir #{self.directory}."
      end
    end

    def before_create
      self.uuid = SecureRandom.urlsafe_base64(n=32)
      Dir.mkdir(self.directory, 0777)
      File.chmod(0777, self.directory)
      self.created_at ||= Time.now
      self.updated_at ||= self.created_at
      super
    end

    def expirydate
      return self.created_at + XferTickets::Application.settings.expiration_time * 24 * 60 * 60
    end

    def directory
      return File.join(XferTickets::Application.settings.datadir, self.uuid)
    end

    def files
      return Dir.glob(File.join(self.directory, "*"))
    end

    def set_allow_uploads(val)
      if val
        self.allow_uploads = true
        File.chmod(0777, self.directory)
      else
        self.allow_uploads = false
        File.chmod(0555, self.directory)
      end
    end

    def set_password(str)
      if(str.empty?)
        self.pwd = nil
      else
        self.pwd = BCrypt::Password.create(str).to_s
      end
    end

    def check_password(str)
      !self.pwd || BCrypt::Password.new(self.pwd).is_password?(str)
    end
  end
end
