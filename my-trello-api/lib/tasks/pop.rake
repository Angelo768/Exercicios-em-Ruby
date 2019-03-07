namespace :pop do
  desc "TODO"
  task setup: :environment do
    puts "Resetando base de dados"
    %x(rails db:drop db:create db:migrate)

    puts "Criando boards, listas e tasks..."
    10.times do |bl|
      Board.create!(name: Faker::Nation.nationality)
      List.create!(
        name: Faker::Nation.capital_city,
        board_id: bl+1
      )
    end
    40.times do |t|
      Task.create!(
        name: Faker::Nation.national_sport,
        description: Faker::Music.band,
        list_id: t+1
      )
    end
    puts "Board, Listas e Tasks criadas com sucesso!!!"

  end

end
