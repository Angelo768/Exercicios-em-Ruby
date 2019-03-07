namespace :dev do
  desc "Popula o banco de dados"
  task setup: :environment do

    puts "Resetando matriz de dados..."
    %x(rails db:drop db:create db:migrate)

    puts "Cadastrando os tipos de contatos..."

    kinds = %w(Amigo Comercial Conhecido Parente)

    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end
    puts "Tipos cadastrados"

    #-------------------------------------------------------------------------
    puts "Cadastrando contatos..."
    10.times do |i|
      Contact.create!(
        name: Faker::Name.name_with_middle,
        email: Faker::Internet.free_email,
        birthdate: Faker::Date.between(65.years.ago, 18.years.ago),
        kind: Kind.all.sample
      )
    end

    puts "Contatos cadastrados com sucesso"
    #-------------------------------------------------------------------------

    puts "Cadastrando Telefones..."
    Contact.all.each do |contact|
      Random.rand(5).times do |i|
        phone = Phone.create!(number:Faker::PhoneNumber.phone_number)
        contact.phones << phone
        contact.save!
      end
    end
    puts "Telefones cadastrados com sucesso!"
    #-------------------------------------------------------------------------

    puts "Cadastrando endereços..."
    Contact.all.each do |contact|
      Address.create!(
        street:Faker::Address.street_address,
        city:Faker::Address.city,
        contact: contact
      )
    end

    puts "Endereços cadastrados com sucesso!"

  end
end
