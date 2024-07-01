# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.where(email: 'djohansen112@gmail.com').first_or_initialize
user.update!(
  password: 'Lucydog1!',
  password_confirmation: 'Lucydog1!',
  role_id: '1',
  username: 'Dan'
)

Category.create(name: 'testing')
Category.create(name: 'software')
Category.create(name: 'dev')
Category.create(name: 'etc')

# Generate 10 fake posts
10.times do |i|
  Post.create title: "Blog Post #{i}", published_at: Time.current, category_id: rand(1..4), content: "I'm baby cardigan glossier celiac leggings everyday carry taiyaki try-hard hella affogato tumblr. Irony 3 wolf moon salvia tacos hoodie. Hell of schlitz photo booth poke pour-over. IPhone live-edge echo park praxis gochujang neutra vexillologist pour-over, church-key meggings before they sold out narwhal paleo air plant leggings. Chicharrones pok pok bitters messenger bag hella slow-carb poutine butcher leggings twee viral jawn praxis ramps.
Try-hard synth solarpunk cray kinfolk. Poutine taiyaki four loko, echo park sartorial tonx truffaut fashion axe fixie gochujang taxidermy. Tumeric normcore hot chicken, taxidermy fanny pack hell of humblebrag hoodie lyft keffiyeh small batch mixtape. Lo-fi selvage gentrify artisan distillery. Paleo VHS fanny pack mlkshk, pop-up street art tousled bushwick vibecession gastropub.
Hot chicken blog gochujang wolf echo park microdosing literally shabby chic chia listicle. Chia kale chips actually kinfolk ennui tumeric gatekeep flexitarian echo park tacos pok pok. Pabst fixie vinyl venmo marfa gatekeep pitchfork plaid migas tbh grailed food truck direct trade mumblecore. Snackwave kinfolk tumeric humblebrag waistcoat fixie glossier.
Kinfolk man braid cronut seitan raclette four dollar toast fingerstache fanny pack grailed. Hell of typewriter four dollar toast succulents austin jawn pour-over chia keytar. Banjo photo booth 3 wolf moon, green juice DIY aesthetic sustainable pinterest actually. Neutra tacos tbh tonx. Meditation gochujang crucifix narwhal roof party cred sartorial pork belly mumblecore letterpress bitters four dollar toast. Church-key yr taiyaki umami tattooed af jianbing twee ennui tote bag green juice sustainable. Echo park grailed enamel pin pork belly fixie wolf irony godard semiotics dreamcatcher bushwick offal 90's JOMO.
Meditation shoreditch sriracha prism butcher mumblecore waistcoat roof party small batch vegan viral. Craft beer occupy banh mi twee DIY, palo santo pickled snackwave cardigan locavore squid crucifix try-hard mlkshk green juice. Tousled gastropub fit, yuccie brunch green juice marxism banh mi forage affogato keffiyeh woke man braid. VHS tacos you probably haven't heard of them 90's small batch. Austin health goth art party hoodie cred pabst forage leggings messenger bag listicle mukbang. Banh mi food truck shoreditch, marxism jianbing celiac JOMO neutra.
Dummy text? More like dummy thicc text, amirite?"
end
