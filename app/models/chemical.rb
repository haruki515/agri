class Chemical < ApplicationRecord
  self.primary_key = "id"

  def self.get_chemical_list
    find_by_sql(['select * from chemicals limit 100'])
  end

end

