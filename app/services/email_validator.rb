class EmailValidator
  def self.valid?(email)
    regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    regex.match? email
  end
end
