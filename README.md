# How To Upload Many Audio Files With Active Storage? — Tutorial

### App Overview

We're going to make an app where a User can create many Sample Packs, and within each Sample Pack, many Samples—_containing an Audio File_—can be created.

> A Sample Pack is a collection of sounds intended for musicians to use to produce music.

Our User Story would be the following:

A User can create, edit, and delete a `SamplePack`
A `SamplePack` has a name, an image cover, and many `Samples`
A `SamplePack` has one audio file attached, and a name.
### Create the project

The rails command I used to bootstrap this project:

`rails new active_storage_audio_tutorial -T -d postgresql -c tailwind -j esbuild`

1. `-T` to skip tests. Minitest is the testing framework that comes for default when you run `rails new` and we will be using RSpec instead.
2. `-d postgresql` for Postgresql as database
3. `-c` for TailwindCSS as UI Library
4. `-j` for Esbuild as a bundler, instead of Webpack

I like to make my first commit the command I used to bootstrap the project. I find this more descriptive than just "Initial commit" and it actually tells my future me how I started everything. This is a little trick I learned from [Justin Searls](https://twitter.com/searls) So I'll go ahead and do:

```git
git add .
git commit -m "rails new active_storage_audio_tutorial -T -d postgresql -c tailwind -j esbuild"
```

### Our Models

#### The Sample Pack Model

Let's get started scaffolding our `SamplePack`.

```bash
rails g scaffold SamplePack name:string
```

Here we are telling rails to generate a few things for the `SamplePack`.

- A database migration file with a `name` column that takes a string as it's value
- The routes for our CRUD operations (create, read, update, delete)
- A model for our `SamplePack`
- The views matching our controller actions
- All the basic controller actions that respond to our routes and CRUD operations (index, new, create, edit, update, destroy)

You'll see a list of generated files in your terminal after running the scaffold command, and it should look like this:

```bash
      invoke  active_record
      create    db/migrate/20230315123233_create_sample_packs.rb
      create    app/models/sample_pack.rb
      invoke  resource_route
       route    resources :sample_packs
      invoke  scaffold_controller
      create    app/controllers/sample_packs_controller.rb
      invoke    erb
      create      app/views/sample_packs
      create      app/views/sample_packs/index.html.erb
      create      app/views/sample_packs/edit.html.erb
      create      app/views/sample_packs/show.html.erb
      create      app/views/sample_packs/new.html.erb
      create      app/views/sample_packs/_form.html.erb
      create      app/views/sample_packs/_sample_pack.html.erb
      invoke    resource_route
      invoke    helper
      create      app/helpers/sample_packs_helper.rb
      invoke    jbuilder
      create      app/views/sample_packs/index.json.jbuilder
      create      app/views/sample_packs/show.json.jbuilder
      create      app/views/sample_packs/_sample_pack.json.jbuilder
```

Now let's head over our newly generated `SamplePack` model file `models/sample_pack.rb`, and add the following:

```ruby
class SamplePack < ApplicationRecord
  has_many :samples, dependent: :destroy
end
```

Ruby is a very English like language — and Rails takes advantage of that. This code is pretty much self explanatory.
Rails models are Ruby classes that inherits from Rails [ActiveRecord](https://guides.rubyonrails.org/association_basics.html) and it's reponsability is to retrieve, store, validate data, and perform business logic.

In this case `has_many :samples`, we're telling our `SamplePack` model that it is the parent of many `Samples`. And `dependent: :destroy` means that when a `SamplePack` gets deleted, all `Sample` children will be cascade deleted.

We're done here with the `SamplePack` for now but we will come back later.
#### The Sample

Let's repeat the scaffolding proccess for our `Sample` but this time it'll look a little bit different. Go ahead and run:

```bash
rails g scaffold SamplePack name:string sample_pack:references
```

What `sample_pack:references` tells rails to do, is to add to the `Samples` database table, a column called `sample_pack_id` which will have a (https://www.cockroachlabs.com/blog/what-is-a-foreign-key/)[Foreign Key] as it's value.
This way our `Sample`s will know to which `SamplePack`s they belongs by having a reference to it's parent id.

This will generate our migration files, as well as the model file, views, and controller file.

Let's take a look at our newly generated `models/sample.rb` file

```ruby
class Sample < ApplicationRecord
  belongs_to :sample_pack
end
```

As we can see, it already added the `belongs_to :sample_pack` which tells our model that a `Sample` belongs to a `SamplePack`.

This sets up our one-to-many association between `SamplePack` and `Sample`.

We're done for now with the `Sample` model, but we will come back later.

#### Routes — Let's rendering something on the screen

Let's take a look at our `routes.rb` file which by now should something like this:

```ruby
Rails.application.routes.draw do
  resources :samples
  resources :sample_packs
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
```

Rails added the `resources :samples` and `resources :sample_packs` to our `routes.rb` file when we ran the respective scaffold commands for our `Sample`s and `SamplePack`s.
This tells Rails to create CRUD endpoints for our resources (samples and sample_packs are the resources).

Let's go ahead and uncomment the `root "articles#index"` and change it by the following:

```ruby
Rails.application.routes.draw do
  resources :samples
  resources :sample_packs
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "sample_packs#index"
end
```

Now when we load our application in the `"/"` path, we'll get on the screen whatever is the `sample_packs#index` controller action and `views/sample_packs/index.html.erb` rendering.

Let's head over our terminal and

1. Create our database — Which we haven't done so far
2. Run the migration files — Which we haven't done either
3. Run the application

In one single command

```bash
bin/rails db:create db:migrate && bin/dev
```

And then in our browser head over to `localhost:3000`

We should be seeing a blank page with the text "Sample packs" and a button with the text "New sample pack".

Nice. So far we have been able to create our project, established the association between `SamplePack` and `Sample` models and got to render the app on our browser.

We'll now go ahead and setup our `SamplePack` for it's image cover.