class User < ApplicationRecord
  validates(:first_name, { presence: true, uniqueness: true})
  validates(:last_name, { presence: true, uniqueness: true})
  validates(:email, { presence: true, uniqueness: true})
private
  def self.search(search_term)
    info = search_term.gsub(/[\s+, \,]/, ' ').split(/\s+/)
    where({first_name: info[0].downcase, last_name: info[1].downcase, email: info[2].downcase})
  end
end
