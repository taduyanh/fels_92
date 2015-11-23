# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

tables = ActiveRecord::Base.connection.tables - ['schema_migrations']

tables.each do |table|
  ActiveRecord::Base.connection.execute "DELETE FROM `#{table}`"
  ActiveRecord::Base.connection.execute "UPDATE SQLITE_SEQUENCE SET SEQ=0 WHERE NAME='#{table}';"
end


categories = ["Basic 500", "At a tour", "At Restaurant"]
ActiveRecord::Base.transaction do
  p "Insert Categories"
  10.times do |time|
    print "."
    Category.create(
      name: "#{categories.sample} #{time+1}",
      description: "Suspendisse commodo neque eu tristique lacinia. Nullam sit amet ipsum augue. In ut nisl luctus, dapibus nisl sit amet, euismod massa. Praesent orci arcu, suscipit fermentum ornare vitae, molestie eu dolor. Donec dictum libero arcu, ac finibus lectus scelerisque a. Ut leo massa, congue id consequat eu, dictum pharetra orci. Sed pretium malesuada arcu, vitae luctus arcu malesuada nec. Suspendisse potenti. Pellentesque sem ligula, fermentum at justo non, egestas tincidunt felis. Sed posuere eros vel felis pellentesque sollicitudin. Integer pretium, felis pretium cursus consectetur, velit neque mollis arcu, nec varius libero nisi vel ligula.",
      image: ["http://www.bobbyflaysteak.com/files/d28afc58c82bc17f2e18cef8212265c6_full_size.jpg",
              "http://mobileleadersalliance.com/wp-content/uploads/2015/08/take_Vacation-750x422.jpg",
              "http://bethcarterenterprises.com/wp-content/uploads/2015/05/todays-lessons.jpg"].sample
    )
  end

  p "Insert Words"
  words =[
    ["かわいい", "cute"],
    ["きれい", "beautiful"],
    ["セクシー", "sexy"],
    ["すてき", "nice"]
  ]
  category_ids = Category.limit(4).pluck :id
  2000.times do |time|
    print "."
    word = words.sample
    Word.create(
      text_ja: "#{word[0]} #{time}",
      text_vn: "#{word[1]} #{time}",
      category_id: category_ids.sample
      )
  end

  p "Insert Answers"
  Word.all.each do |word|
    print "."
    answers = [word.text_vn, 
      "#{word.text_vn} a", 
      "#{word.text_vn} b", 
      "#{word.text_vn} c" 
    ]
    4.times do |time|
      answer = answers.delete answers.sample
      Answer.create(
        text: answer,
        word_id: word.id,
        correct: answer.eql?(word.text_vn)
      )
    end
  end
end