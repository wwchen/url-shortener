class Url < ActiveRecord::Base
  validates :href, format: { with: /[a-zA-Z]+:\/\/.*/, message: 'Invalid URI' },
                   presence: true
  validates :alias, format: { with: /[a-zA-Z0-9]*/ },
                    uniqueness: true,
                    presence: true
  validates :views, numericality: { only_integer: true }

  before_validation do 
    self.alias.chomp!
    if self.alias.empty?
      # generate one
      self.alias = loop do
        str = generate_random_string
        break str unless Url.exists? alias: str
      end
    end
  end

  # generate a random string
  def generate_random_string(size = 5)
    charset = ('a'..'z').to_a + (0..9).to_a
    (0...size).map { charset[rand(charset.size)] }.join
  end
end
