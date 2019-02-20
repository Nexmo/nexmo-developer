# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)

unless Rails.env.test?
  User.create!(email: 'admin@nexmo.com', password: 'development', admin: true)
end

Event.create!({
  title: 'Small business hackathon',
  starts_at: Time.zone.parse('2020-03-04'),
  ends_at: Time.zone.parse('2020-03-05'),
  url: 'http://www.smallbizhack.com/',
  description: 'Hack to create new innovations that help small businesses save time so they can get back to their passions',
  city: 'Mountain View',
  country: 'US',
})

Event.create!({
  title: 'Forward JS',
  starts_at: Time.zone.parse('2020-03-01'),
  ends_at: Time.zone.parse('2020-03-01'),
  url: 'https://forwardjs.com/',
  description: 'Illuminating lectures, & enlightening workshops',
  city: 'Ottawa',
  country: 'CA',
})

Event.create!({
  title: 'Render',
  starts_at: Time.zone.parse('2020-03-30'),
  ends_at: Time.zone.parse('2020-03-31'),
  url: 'http://2020.render-conf.com/',
  description: 'A 2-day conference for front-end developers',
  city: 'Oxford',
  country: 'GB',
})

devrel_con = Event.create!({
  title: 'DevRelCon London 2016',
  starts_at: Time.zone.parse('2016-12-07'),
  ends_at: Time.zone.parse('2016-12-07'),
  url: 'https://london-2016.devrel.net/',
  description: 'A one day conference about developer relations, developer experience and developer marketing. December 7th 2016, London.',
  city: 'London',
  country: 'GB',
})

Session.create!({
  title: 'Introduction to the AAARRRP devrel strategy framework',
  description: 'Building a DevRel programme is hard. What are the goals of the programme, how do they align with the company goals, what activities should the new Developer Relations team undertake, how do those activities help other departments within the company and how should the success of the team be measured?',
  author: 'Phil Leggetter',
  event: devrel_con,
  video_url: 'https://www.youtube.com/watch?v=i7EZDYYfFmc',
  published: true,
})
