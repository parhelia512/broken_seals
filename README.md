# Broken Seals

A 3D third person RPG. With both multiplayer, and singleplayer capabilities.

The main gameplay-loop goal is to create an experience with enough complexity and depth, that can rival the more old-school MMO- and action rpgs, because nowadays I feel like that is something that got lost.

I want the game to run on every platform, but the game design is PC first. From the testing I've done this is not going to be an issue.

This project uses a custom version of ![godot (3.x branch)](https://github.com/godotengine/godot/tree/3.x) as it's engine.

#### On Desktop

![Broken Seals desktop](pictures/screenshot_desktop.jpg)

#### On Touchscreens

![Broken Seals on touchscreen](pictures/screenshot_touchscreen.jpg)

## Project overview

As stated in the opening section the project uses a custom version of the godot engine.

The project's workflow has been set up so you can easily compile this version for yourself if you want to.
See the [Compiling](#compiling) section if you want to know how to do this.

### Engine

Currently [my fork](https://github.com/Relintai/godot) of godot is used as a base for the engine (3.x). \
This contains a port of TokageItLab's SkeletonEditor pr (https://github.com/godotengine/godot/pull/45699).\
The original godot source will likely work too if you want that for some reason.

Also the engine needs to have some engine modules built in. For example:

Except for a few scripts, entities, spells and auras are handled by the 
[entity_spell_system](https://github.com/Relintai/entity_spell_system)
module c++ side.

Threading is handled by [ThreadPool](https://github.com/Relintai/thread_pool).

The terrain is handled by [Terraman](https://github.com/Relintai/terraman.git).

Most of the models are imported as MeshDataResources, these are meshes that are meant to be merged.
These come from the [MeshDataResource](https://github.com/Relintai/mesh_data_resource) module.
Currently I'm working on the mesh_data_resource_editor addon that will enable these to be edited directly inside the editor.

Actually [here's the full list](#the-required-engine-modules).

### Game

The [/game](https://github.com/Relintai/broken_seals/tree/master/game) folder contains the game's code and assets.
This is the folder you are supposed to open in the editor.

The game's folder structure should be mostly self explanatory.

#### Game Modules

Except for probably the game modules.
I designed the game's code to be highly modular, so I created a [loader module](https://github.com/Relintai/broken_seals/tree/master/game/scripts/game_modules). It will look for files named ` game_module.tres ` and call methods on them on certain events.
This system uses the [DataManager](https://github.com/Relintai/broken_seals/blob/master/game/scripts/game_modules/DataManager.gd) singleton.

For example this is how the ui initializes itself. The player's [body](https://github.com/Relintai/broken_seals/blob/master/game/player/Body.gd) script, requests the instantiated ui from the [DataManager](https://github.com/Relintai/broken_seals/blob/master/game/scripts/game_modules/DataManager.gd) singleton like ` var ui = DataManager.request_instance(DataManager.PLAYER_UI_INSTANCE) `.

And the data manager will instance it's player ui scene, and call all module's ` on_request_instance ` methods.

These module scripts are also responsible for collecting all spells and then setting them into the ESS singleton, so they are castable.
For exmaple the [module](https://github.com/Relintai/broken_seals/blob/master/game/modules/entity_classes/naturalist/game_module.tres) for the naturalist, and it's [resource db](https://github.com/Relintai/broken_seals/blob/master/game/modules/entity_classes/naturalist/resource_db.tres), which will be merged into a central resource db for ESS. 

Note that the module resources are sorted by their resource paths, so spells should always get the same id, on every platform every time.
This is to optimize networkd spell casts.

Most of the game assets ended up under the modules folder [here](https://github.com/Relintai/broken_seals/tree/master/game/modules) for this reason,
however these might get moved, if I find a better arrangement.

#### Terrain generation

The terrain generation is now handled by the new [world_generator](https://github.com/Relintai/broken_seals/tree/master/game/addons/world_generator)
addon. 

The idea right now is that the terrain is only going to be pseudo-random, as generating proper connected worlds are kind of super difficult,
especially if you also have to mesh them in 3d. I think this solution can be extended later to be able to do a full continent / world randomization
/ generation. However for now the idea is that we have a World resource, this contains Continents, those zontain Zones, and those contain SubZones.
The position and size is predetermined by the creator. And then when a chunk needs to be generated it gets put into this world, and setup.

World does mostly nothing on it's own for now, except for holding continents.
Right continents should handle things like oceans, and big mountains.
Zones generate proper terrain, and add props. They need to blend into continents.
SubZones can be used as spawners, prop spawners, or they can even do terrain mods.

The editor contains an addon to help with editing the world.

## Editing the game

Grab an engine with the required modules and then open the project inside the `game` folder.

After the initial import it might need an editor restart, however everything should work after that.

If you want to use master, you will likely need to build the editor for it if the c++ side had breaking changes since the last release.

## Compiling

First make sure, that you have everything installed to be able to compile the godot engine. See: See the [official docs for compiling Godot](https://docs.godotengine.org/en/latest/development/compiling/index.html) for more info. My setup/compile script uses the same tools, so
you don't need to install anything else.

Now let's clone this repository:

``` git clone https://github.com/Relintai/broken_seals ```

cd into the new folder:

``` cd broken_seals ```

Now let's run the project's setup script, by calling scons without arguments.

``` scons ```

This will clone and setup the engine, and all of the required modules into a new `engine` folder inside the project, using http.

(If you want to use the github's ssh links append `repository_type=ssh` like ``` scons repository_type=ssh ```)

Once it is done you can compile the engine.

To build the editor on windows with 4 threads run the following command:

``` scons bew -j4 ```

To build the editor on linux with 4 threads run the following command:

``` scons bel -j4 ```

I call this feature of the setup script build words. [See](#Build words).

Once the build finishes you can find the editor executable inside the `./engine/bin/` folder.

For convenience there is a provided `editor.sh`, or `editor.bat` for running it from the project's folder.
These will create a copy, so you can even compile while the editor is running.

Alternatively if you don't want to use build words, you can also just go into the engine folder:

``` cd engine ```

And compile godot as per the [official docs](https://docs.godotengine.org/en/latest/development/compiling/index.html).

### Build words

The project's setup script contains support for "build words". These can be used from the root of this project.

For example to build the editor for windows with 4 threads you can use:

``` scons bew -j4 ```

The first argument must start with b (build), then it needs to be followed by a few abbreviations (the order does not matters)

The rest of the arguments will be passed directly to godot's scons script.

#### Editor

Append `e` to build with `tools=yes` a.k.a. the editor.

``` scons bew -j4 ```

if you omit `e`, the system will build the export template for you. For example:

``` scons bw -j4 ```

This will be the `release_debug` windows export template.

#### Platform abbreviations

`l`: linux \
`w`: windows \
`a`: android \
`j`: Javascript \
`i`: iphone (Not yet finished, use `build_ios.sh`, and `build_ios_release.sh`) \
Mac OSX: Not yet finished, use `build_osx.sh`

#### Target abbreviations

By default the system builds in release_debug.

Append `d` for debug, or `r` for release.

``` scons bewd -j4 ```

build editor windows debug

``` scons bwr -j4 ```

build windows release (this will build the windows release export template)

#### Shared modules

Note: This only works on linux!

append `s` to the build string. 

Optionally you can also make the build system only build a target module, by appending one of these:

`E`: Entity Spell System \
`T`: Texture Packer \
`V`: Voxelman \
`W`: World Generator \
`P`: Procedural Animations

Example:

``` scons belsE -j4 ```

build editor linux shared (Entity Spell System) with 4 threads

Note: to easily run the editor you can use the `editor.sh` or `editor.bat` in the root of the project.

#### Other

Append `v` to pass the `vsproj=yes` parameter to the build script. This will generate Visual Studio project files.

#### Postfixes

There are a few postfixes for the build words. These are more complex options. You have to append them to your build word with an underscore.

You can use as many as you want.

For example:

``` scons bel_slim_latomic -j4 ```

##### slim

With this postfix you can build a slimmed down version of the engine. This disables quite a few unneeded modules.

``` scons bel_slim -j4 ```

##### latomic

If you get linker errors while building the game/editor about undefined referenced with atomic related functions you can use this postfix.
It will add the ` -latomic ` command line switch to the linker flags.

I ran into this issue while building on a raspberry pi 4 with the x11 platform. It might be related to the recent reworks to threading.

``` scons bel_latomic -j4 ```

##### strip

Appends `debug_symbols=no` to the build command, which will strip the resulting binary from debug symbols.

``` scons bel_strip -j4 ```

#### Scons cache, and sdk locations

In order to use scons cache and to tell the build system where some of the required sdks are located you usually 
have to use environment variables. Most of the time you might just want to add them globally, 
howewer this is sometimes unfeasible (e.g. you don't have administrator access, or you just want to have
multiple sdk versions installed).

In order to solve this a build config file was added.

If you want to use the config simply rename the provided `build.config.example` to `build.config`, and customize 
the settings inside.

### Manual Setup

If you you don't want to use the setup script (or just want to know what it actually does), 
this section will explain how to set everything up manually.

First clone godot. Either my fork (recommended at the moment):

``` git clone https://github.com/Relintai/godot.git ```

or the official 3.x master:

``` git clone https://github.com/godotengine/godot.git -b 3.x ```

go into engine's modules fodler.

``` cd godot/modules/ ```

Now go ahead and get every single required engine module from [here](#the-required-engine-modules).

``` cd ../../ ```

Now if you look at the [HEADS file](https://github.com/Relintai/broken_seals/blob/master/HEADS).

It contains the commit hashes for that particular revision for every module and the engine.

You need to go through them and checkout the proper commits.

Now you can go ahead and compile godot normally.

#### The required engine modules

These are the required engine modules, they are listed here for completeness`s sake, the project's setup script will install these for you automatically! See the [Compiling](#compiling) section.

https://github.com/Relintai/entity_spell_system.git \
https://github.com/Relintai/ui_extensions.git \
https://github.com/Relintai/texture_packer.git \
https://github.com/Relintai/godot_fastnoise.git \
https://github.com/Relintai/mesh_data_resource.git \
https://github.com/Relintai/props.git \
https://github.com/Relintai/mesh_utils.git \
https://github.com/Relintai/broken_seals_module.git \
https://github.com/Relintai/thread_pool.git \
https://github.com/Relintai/terraman.git

## Pulling upstream changes

First pull the changes by calling

``` git pull orgin master ```

Then just run `scons`, to will update the modules.

## Upgrading the modules

Note: this is how to update the HEADS file. Normally you don't need to do this.

If you want to update the modules, and the engine to the latest, you can use (`action=update`):

``` scons a=u ``` 

You can also update different targets: `all`, `engine`, `modules`, `all_addons`, `addons`, `third_party_addons`

For example to update the engine to the latest: ``` scons a=u target=engine ```
