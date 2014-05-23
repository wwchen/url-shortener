class Url < ActiveRecord::Base
  validates :href, format: { with: /[a-zA-Z]+:\/\/.*/, message: 'Invalid URI' },
                   presence: true
  validates :alias, format: { with: /[a-zA-Z0-9]*/ },
                    uniqueness: true,
                    presence: true
  validates :views, numericality: { only_integer: true }

  def alias_url
    #root_url + self.alias
    self.alias
  end

  def to_param
    self.alias
  end

  before_validation do
    self.alias.chomp!
    if self.alias.empty?
      # generate one
      self.custom = false
      self.alias = loop do
        str = generate_random_string
        break str unless Url.exists? alias: str
      end
    elsif self.alias_changed?
      self.custom = true
    end
  end

  before_save do
    if self.alias_changed?
      self.views = 0
    end
  end

  # generate a random string
  def generate_random_string(size = 5)
    charset = ('a'..'z').to_a + (0..9).to_a
    (0...size).map { charset[rand(charset.size)] }.join
  end
end
