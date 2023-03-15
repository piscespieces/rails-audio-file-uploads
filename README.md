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
