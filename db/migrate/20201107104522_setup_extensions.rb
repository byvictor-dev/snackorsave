class SetupExtensions < ActiveRecord::Migration[6.0]
  def change
    enable_extension "plpgsql"
    enable_extension "uuid-ossp"
    enable_extension "pg_trgm"
    enable_extension "hstore"
    enable_extension "pg_stat_statements"
  end
end
