FIRST_NAMES=["Chris", "Sam", "Marhsall", "Barney", "Ted", "Jack", "bill"]
LAST_NAMES=["Smith", "Jones", "Jenkins", "Applewood", "Smithfield"]
ADDRESSES=[
  { street: "Main Street",
    city: "Atlanta", 
    state: "NY",
    zipcode: 11123
  }, {
    street: "Fayetteville Street",
    city: "Raleigh", 
    state: "NC",
    zipcode: 23445
  }, {
    street: "Bull Durham Drive",
    city: "Durham", 
    state: "NC",
    zipcode: 54332
  }, {
    street: "Apple Grove Dr",
    city: "Chappel Hill", 
    state: "NC",
    zipcode: 12343
  }, {
    street: "Landsdown Street",
    city: "Boston", 
    state: "MA",
    zipcode: 42412
  }, {
    street: "Orchard Park Rd",
    city: "Buffalo", 
    state: "NY",
    zipcode: 12321
  }, {
    street: "Spring Hill Lane",
    city: "Syracuse", 
    state: "NY",
    zipcode: 76453
  }
]


(0..25).each { |index|
  name = "#{FIRST_NAMES.sample} #{LAST_NAMES.sample}"
  user = User.where(name: name, 
    email: "#{name.split(" ").join("_").downcase}@test.com"
  ).first_or_initialize
  
  if user.new_record?
    user.password = "password"
    
    address = ADDRESSES.sample
    user.address = Address.new({
      address1: "#{rand(6000)} #{address[:street]}",
      city: address[:city],
      state: address[:state],
      zipcode: address[:zipcode]
    })
    puts "Adding New User: #{user.name} -> #{user.email}"
    user.save!
  end

}
