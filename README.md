# WubePrint

## Contents

-  [Description](#description)
-  [Version](#version)
-  [Problem](#problem)
-  [Solution](#solution)
-  [Requirements](#requirements)
-  [Installation](#installation)
-  [Usage](#usage)
-  [Changelog](#changelog)
-  [Versioning](#versioning)
-  [Copyright and License](#copyright-and-license)
   -  [The MIT License](#the-mit-license)


---

# Description

Program to create blueprints for the Factorio game using hand-created data instead of building the blueprints in-game.


[TOP](#contents)

---
## Version

0.1.0-objects-1-color

[TOP](#contents)

---
## Problem

I was making a collection of blueprints for train stops and they were all the same, to 95%. The name, the color of the train stop itself, and one or two settings in the atttached constant combinator were specific to the print. Making each change, and remembering to change all that I was supposed to, makeing anew print, giving it the proper icons and name and moving it into the proper book got to be _very_ boring. It's a _game_ not a _duty_! I figured there had to be a way to access the blueprints outside the game, make changes and import them again. There are several blueprint editors online which can do that. Using them, however, would be the same as doing it in-game anyway, with all the same boring details.


[TOP](#contents)

---
## Solution

My first thought was to make a master print with place holder data and use Regular Expressions to change the few parts, after all, what I was changeing was string data anyway. Two problems with that plan: 1) Regular Expressions are _a_ tool, not the only tool, nor even **the** tool, for dealing with textual data, 2) I still had no clue how to interpret the "export string" from the game. Problem #1 was not a "problem" as long as problem #2 existed. Someone in Discord gave the one clue I needed by pointing me to the official definition of the blueprint string from Wube: [Blueprint string format](https://wiki.factorio.com/Blueprint_string_format). Lerning to use that information, resulted in the creation of the [Facatorio Blueprint Conversions project](https://github.com/chindraba-work/Facatorio-Blueprint-Conversions). I later found that there are some on-line versions of the same thing, though on-line didn't do me much good at the time as my internet access was serverly limited.

Now, with problem #2 solved, problem #1 became the issue. I started, barely, to use that tool to do what I wanted with blueprints. Turned out the be almost as much work as it was in-game. I could make changes faster, but I had to make all the same changes, in each place they occured. For example, with a trio of prints for a loading station, drop-off station, and the train between them, the `[item=iron-plate]` definition is used in the name of both stations, (in their print and in the schedule section of the train's print), in the filter (160 times) for the cargo wagons, in controling constant combinators at each stop, in the icons for each print and in the name of each print. Full circle back to RegEx with a place holder. There was alos the mental overhead of making sure I properly formatted the entire collection as blueprints for a single blueprint book to import again.

In addition, I had dreams of making variations for each train, length and configuration, to place in the book so that the train I needed now was there, as were other options I might choose later without having to make a new print, again. While the idea took time to formalize, I wanted to be able to make a "definition" dataset and turn that into a collection of prints in a book to import as one string. Even better would be if I could create several datasets and have each make its collection and put them into a series and structure of multiple books. One sample could a book holding one book each for a set of "factories" which could have upto 4 different, unique, products, each of which would need a load stop, drop stop and the assorted trains between them. Perhaps 35 products split into 8 books, all in one book.
Easy to do, conceptually, with a program. Not so easy to do, and keep all the JSON correct, with hand editing (even with RegEx) of JSON files.

Therefore, this project was born. (And at this time is still developing and not yet usable.)

[TOP](#contents)

---
## Requirements

The requirements for this program is a working Perl installation with the following packages available:
-  Compress::Zlib
-  MIME::Base64
-  JSON

Of the three, Compress::Zlib is the most likely to not already be installed on a system which has been use for a while. It is also the hardest one to find useful commmand line tools for, which prompted the creation of this project.

A nice text editor for creating the data files would also be rather handy. :D


[TOP](#contents)

---
## Installation

Copy the files and directories to where you want them, then create a link to `wube-print.pl` somewhere in your execution search path. Use `echo $PATH` on Linux and `echo %PATH%` on Windows to see what that is. (Linux users can probably place a sym-link in `$HOME/bin/`, Windows users probably just want to make a shortcut that opens `CMD` or `PowerShell` in the directory where the files are copied to.) For Linux, verify that the execute privilege is set on `wube-print.pl`. It should be, but check.

[TOP](#contents)

---
## Usage

1.  Create the dataset file with a text editor.
2.  Run the WubePrint program.
3.  Copy/paste the resulting string into the game.
4.  Continue with the objective of **The Factory Must Grow**

Well, that's the plan anyway. In its final form sample dataset files will be available, along with a much more detailed description of what is, or can (and cannot) be in the data, how it's used and what's used if it's not there.

[TOP](#contents)

---
## Changelog

The current version is locked at 0.1.0-objects.x, with x growing as I implement the creation of each object from the Wube specification above. Here will be the growing list of objects (and version numbers) while development progresses. Each will probably include some form of hint as to the dataset information it processes as well. This list represents the Changelog until such time as the program becomes functional. At that time an actual CHANGELOG file will be created and maintined.

All dataset information is as it will be in the text file. As a rule the `buildXYZ` subroutines (usually in `build/XYZ.pl`) will create the data as needed for the `wubeXYZ` subroutines (usually in `wube/XYZ.pl`) which create the data structure for conversion to JSON formated `XYZ` object in the blueprint string format definition above.

### Version 0.1.0-objects:

1.  `.1-color`: add the `Color` object. (will be optional)
2.  `.2-itemFilter`: add the `ItemFilter` object (will be optional)

### Dataset information

-  `color => `, 2 options:
   1.  string of hexcode, with the leading "#" `color => '#cc9933',`
   2.  arrayRef of 3 numeric (0 .. 255) RGB color values `color => [ 204, 153, 51 ],`
-  `first_filter =>`, numeric (first item slot to be filtered) `first_filter => 4,`
-  `filter_input =>`, arrayRef of 2 options:
   1.  string, item to filter (filter one slot to item)
   2.  arrayRef, `[ number, string ]` (filter numeber of slots to item)
   A complex filter for a cargo wagon can be:
   -  3 slots unfiltered
   -  1 wood
   -  5 coal
   -  10 iron-ore
   -  1 pump
   -  remaining slots unfiltered
```
        first_filter => 4,
        filter_input => [
            'wood',
            [5, 'coal'],
            [10, 'iron-ore'],
            'pump',
        ],
```
   The `first_filter` will be updated as filters are added, allowing for extra calls to `buildItemFilter_list()` outside the structure if needed. Might be a while before that functionality is included in my code, however. It applies to cargo wagons, for now, but could be used elsewhere when I get there.

[TOP](#contents)

---
## Versioning

The **WubePrint** project uses Semantic Versioning v2.0.0.

[Semantic Versioning](https://semver.org/spec/v2.0.0.html) was created by [Tom Preston-Werner](http://tom.preston-werner.com/), inventor of Gravatars and cofounder of GitHub.

Version numbers take the form X.Y.Z where X is the major version, Y is the minor version and Z is the patch version. The meaning of the different levels are:

* Major version increases indicates that there is some kind of change in the API (how this program works as seen by the user) or the program features which is incompatible with previous version

* Minor version increases indicates that there is some kind of change in the API (how this program works as seen by the user) or the program features which might be new, while still being compatible with all other versions of the same major version

* Patch version increases indicate that there is some internal change, bug fixes, changes in logic, or other internal changes which do not create any incompatible changes within the same major version, and which do not add any features to the program operations or functionality

[TOP](#contents)

---
## Copyright and License

The MIT license applies to all the code within this repository.

Copyright © 2022  Chindraba (Ronald Lamoreaux)

   <[projects@chindraba.work](mailto:projects@chindraba.work?subject=Factorio_Blueprint_Conversions)>

- All Rights Reserved

### The MIT License

    Permission is hereby granted, free of charge, to any person
    obtaining a copy of this software and associated documentation
    files (the "Software"), to deal in the Software without restriction,
    including without limitation the rights to use, copy, modify, merge,
    publish, distribute, sublicense, and/or sell copies of the Software,
    and to permit persons to whom the Software is furnished to do so,
    subject to the following conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGE-
    MENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
    FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
    CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
    WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[TOP](#contents)
