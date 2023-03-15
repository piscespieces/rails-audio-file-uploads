# How To Upload Many Audio Files With Active Storage? — Tutorial

#### App Overview

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
