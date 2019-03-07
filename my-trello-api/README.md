# Introduction
This application simulates an aplication similar of trello, all develop in language-programing ruby and a framework rails!!

# Requirements for this application run

- Ruby Version: 2.5.3
- Database: SQL Lite
- Rails Version: 5.2.2

# Commands for runnig this application

- bundle
- rails db:create
- rails db:migrate
- rails pop:setup
- rails s


# Resource-User

**Create a User**

{

    "name": "angeliano",
    "email": "angeliano@angelo.com",
    "password": "12345678",
    "password_confirmation": "12345678"
    
}

**Login as User**

{

    "name": "angeliano",
    "email": "angeliano@angelo.com",
    "password": "12345678",
    "password_confirmation": "12345678"
    
}

# Resources-Boards

**Create an board (POST)**

{

    "name": "Moldovans" (required)

}

**Updating an board by id (PATCH)**

{

    "id": 2,                
    "name": "Moldovans"    (required)

}

# Resources-Lists

**Create an list (POST)**

{

    "list": {
        "name": "TO DO",      (required)
        "board_id": 1,        (required)
        "tasks": []           (optional)
    }
}

**Updating an list by id (PATCH)**

{

    "list": {
        "id": 2,
        "name": "Doing",       (required)
        "board_id": 1,         (required)
        "tasks": []            (optional)
        
        }
}

# Resources-Tasks

**Create an task (POST)**

{

    "name": "field hockey",        (required)
    "description": "Cream",        (optional)
    "list_id": 1                   (id which an belongs to list)
    
}

**Updating an task (PATCH)**

{

    "id": 1,
    "name": "field hockey",        (required)
    "description": "Cream",        (optional)
    "list_id": 1                   (id which an belongs to list)

}

# Routes for create and sign_in users

  - post "auth", to: "devise_token_auth/registrations#create" # Create user
  - post "auth/sign_in", to: "devise_token_auth/sessions#create" # Login of user

# Routes for CRUD

 # From boards
  - get "boards", to: "boards#index" -> Show all boards
  - get "boards/:id", to: "boards#show" -> "Show a board by id"
  - post "boards", to: "boards#create" -> "To create a board"
  - patch "boards/:id", to: "boards#update" -> "To update a board by id
  - delete "boards/:id", to: "boards#destroy" -> "To destroy a board by id"

  # From lists
  - post "boards/:id/list", to: "lists#create" -> "Create a list in a board chosen by id"
  - get "lists/:id", to: "lists#show" -> "Show a list chosen by id"
  - patch "lists/:id", to: "lists#update" -> "Updating a list chosen by id"
  - delete "lists/:id", to: "lists#destroy" -> "Destroy a list chosen by id"

  # From tasks
  - post "boards/:id/list/:id/task", to: "tasks#create" -> "Create a task in an list"
  - get "tasks/:id", to: "tasks#show" -> "Show an task chosen by id"
  - patch "tasks/:id", to: "tasks#update" -> "Updating a task chosen by id"
  - delete "tasks/:id", to: "tasks#destroy" -> "Destroy a task chosen by id"

  
