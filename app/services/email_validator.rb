REDIRECTS = YAML.load_file("#{Rails.root}/config/redirects.yml")

class EmailValidator
  def self.valid?(email)
    regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    regex.match? email
  end
end
