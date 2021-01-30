# frozen_string_literal: true

# http://sequel.jeremyevans.net/rdoc/files/doc/migration_rdoc.html

Sequel.migration do
  up do
    create_table(:tickets) do
      primary_key :id
      DateTime :created_at
      DateTime :updated_at
      String :userid
      String :uuid
      String :title
      String :salt
      String :pwd
      Boolean :allow_uploads, :default => true
    end
  end

  down do
    drop_table(:tickets)
  end
end
