Sifttter Redux [![Build Status](https://travis-ci.org/bachya/Sifttter-Redux.png?branch=master)](https://travis-ci.org/bachya/Sifttter-Redux)
==============

Siftter Redux is a modification of Craig Eley's [Sifttter](http://craigeley.com/post/72565974459/sifttter-an-ifttt-to-day-one-logger "Sifttter"), a script to collect information from [IFTTT](http://www.ifttt.com "IFTTT") and place it in a [Day One](http://dayoneapp.com, "Day One") journal.

Siftter Redux has several fundamental differences:

* Interactive logging of today's events or events in the past
* "Catch Up" mode for logging several days' events at once
* Packaged as a command line app, complete with documentation and help
* Easy installation on cron for automated running

# Prerequisites

In addition to Git (which, given you being on this site, I'll assume you have), there are two prerequisites needed to run Sifttter Redux in a *NIX environment:

* Ruby (version 1.9.3 or greater)
* UUID (required on the Raspberry Pi because it doesn't come with a function to do this by default)

To install on a Debian-esque system:

```
$ sudo apt-get install ruby
$ sudo apt-get install uuid
```

# Installation

```
gem install sifttter-redux
```

# Usage

Syntax and usage can be accessed by running `srd help`:

```
$ srd help
NAME
    srd - Sifttter Redux

    A customized IFTTT-to-Day One service that allows for
    smart installation and automated running on a standalone
    *NIX device (such as a Raspberry Pi).

SYNOPSIS
    srd [global options] command [command options] [arguments...]

VERSION
    0.3.9

GLOBAL OPTIONS
    --help         - Show this message
    --[no-]verbose - Turns on verbose output
    --version      - Display the program version

COMMANDS
    exec - Execute the script
    help - Shows a list of commands or help for one command
    init - Install and initialize dependencies
```

## Initialization

```
$ srd init
```

Initialization will perform the following steps:

1. Download [Dropbox Uploader](https://github.com/andreafabrizi/Dropbox-Uploader "Dropbox-Uploder") to a location of your choice.
2. Automatically configure Dropbox Uploader.
3. Collect some user preferences:
 * The location on your filesystem where Sifttter files will be temporarily stored
 * The location of your Sifttter files in Dropbox
 * The location on your filesystem where Day One files will be temporarily stored
 * The location of your Day One files in Dropbox

## Basic Execution

```
$ srd exec
#### EXECUTING...
---> INFO: Creating entry for February 15, 2014...
---> INFO: Downloading Sifttter files...DONE.
---> SUCCESS: Entry logged for February 15, 2014...
---> INFO: Uploading Day One entries to Dropbox...DONE.
---> INFO: Removing downloaded Day One files...DONE.
---> INFO: Removing downloaded Sifttter files...DONE.
#### EXECUTION COMPLETE!
```

## "Catch-up" Mode

Sometimes, events occur that prevent Sifttter Redux from running (power loss to your device, a bad Cron job, etc.). In this case, Sifttter Redux's "catch-up" mode can be used to collect any valid journal on or before today's date.

There are many ways to use this mode (note that "today" in these examples is **February 15, 2014**):

### Yesterday Catch-up

To create an entry for yesterday:

```
$ srd exec -y
#### EXECUTING...
---> INFO: Creating entry for February 14, 2014...
---> INFO: Downloading Sifttter files...DONE.
---> SUCCESS: Entry logged for February 14, 2014...
---> INFO: Uploading Day One entries to Dropbox...DONE.
---> INFO: Removing downloaded Day One files...DONE.
---> INFO: Removing downloaded Sifttter files...DONE.
#### EXECUTION COMPLETE!
```

### Last "N" Days Catch-up

Sifttter Redux allows you to specify the number of days back it should look for new entries:

```
$ srd exec -n 3
#### EXECUTING...
---> INFO: Creating entries for dates from February 12, 2014 to February 14, 2014...
---> INFO: Downloading Sifttter files...DONE.
---> SUCCESS: Entry logged for February 12, 2014...
---> SUCCESS: Entry logged for February 13, 2014...
---> SUCCESS: Entry logged for February 14, 2014...
---> INFO: Uploading Day One entries to Dropbox...DONE.
---> INFO: Removing downloaded Day One files...DONE.
---> INFO: Removing downloaded Sifttter files...DONE.
#### EXECUTION COMPLETE!

$ srd exec -n 12
#### EXECUTING...
---> INFO: Creating entries for dates from February 03, 2014 to February 14, 2014...
---> INFO: Downloading Sifttter files...DONE.
---> SUCCESS: February 03, 2014...
---> SUCCESS: February 04, 2014...
---> SUCCESS: February 05, 2014...
---> SUCCESS: February 06, 2014...
---> SUCCESS: February 07, 2014...
---> SUCCESS: February 08, 2014...
---> SUCCESS: February 09, 2014...
---> SUCCESS: February 10, 2014...
---> SUCCESS: February 11, 2014...
---> SUCCESS: February 12, 2014...
---> SUCCESS: February 13, 2014...
---> SUCCESS: February 14, 2014...
---> INFO: Uploading Day One entries to Dropbox...DONE.
---> INFO: Removing downloaded Day One files...DONE.
---> INFO: Removing downloaded Sifttter files...DONE.
#### EXECUTION COMPLETE!
```

Note that this option goes until yesterday ("yesterday" because you might not be ready to have today's entries scanned). If you'd rather include today's date, you can always add the `-i` switch:

```
$ srd exec -i -n 3
#### EXECUTING...
---> INFO: Creating entries for dates from February 12, 2014 to February 15, 2014...
---> INFO: Downloading Sifttter files...DONE.
---> SUCCESS: Entry logged for February 12, 2014...
---> SUCCESS: Entry logged for February 13, 2014...
---> SUCCESS: Entry logged for February 14, 2014...
---> SUCCESS: Entry logged for February 15, 2014...
---> INFO: Uploading Day One entries to Dropbox...DONE.
---> INFO: Removing downloaded Day One files...DONE.
---> INFO: Removing downloaded Sifttter files...DONE.
#### EXECUTION COMPLETE!
```

### Last "N" Weeks Catch-up

Sifttter Redux also allows you to specify a number of weeks back that should be scanned for new entries:

```
$ srd exec -w 1
#### EXECUTING...
---> INFO: Creating entries for dates from February 03, 2014 to February 14, 2014...
---> INFO: Downloading Sifttter files...DONE.
---> SUCCESS: Entry logged for February 03, 2014...
---> SUCCESS: Entry logged for February 04, 2014...
---> SUCCESS: Entry logged for February 05, 2014...
---> SUCCESS: Entry logged for February 06, 2014...
---> SUCCESS: Entry logged for February 07, 2014...
---> SUCCESS: Entry logged for February 08, 2014...
---> SUCCESS: Entry logged for February 09, 2014...
---> SUCCESS: Entry logged for February 10, 2014...
---> SUCCESS: Entry logged for February 11, 2014...
---> SUCCESS: Entry logged for February 12, 2014...
---> SUCCESS: Entry logged for February 13, 2014...
---> SUCCESS: Entry logged for February 14, 2014...
---> INFO: Uploading Day One entries to Dropbox...DONE.
---> INFO: Removing downloaded Day One files...DONE.
---> INFO: Removing downloaded Sifttter files...DONE.
#### EXECUTION COMPLETE!

$ srd exec -w 3
#### EXECUTING...
---> INFO: Creating entries for dates from January 20, 2014 to February 14, 2014...
---> INFO: Downloading Sifttter files...DONE.
---> SUCCESS: Entry logged for January 20, 2014...
---> SUCCESS: Entry logged for January 21, 2014...
---> SUCCESS: Entry logged for January 22, 2014...
---> SUCCESS: Entry logged for January 23, 2014...
---> SUCCESS: Entry logged for January 24, 2014...
---> SUCCESS: Entry logged for January 25, 2014...
---> SUCCESS: Entry logged for January 26, 2014...
---> SUCCESS: Entry logged for January 27, 2014...
---> SUCCESS: Entry logged for January 28, 2014...
---> SUCCESS: Entry logged for January 29, 2014...
---> SUCCESS: Entry logged for January 30, 2014...
---> SUCCESS: Entry logged for January 31, 2014...
---> SUCCESS: Entry logged for February 01, 2014...
---> SUCCESS: Entry logged for February 02, 2014...
---> SUCCESS: Entry logged for February 03, 2014...
---> SUCCESS: Entry logged for February 04, 2014...
---> SUCCESS: Entry logged for February 05, 2014...
---> SUCCESS: Entry logged for February 06, 2014...
---> SUCCESS: Entry logged for February 07, 2014...
---> SUCCESS: Entry logged for February 08, 2014...
---> SUCCESS: Entry logged for February 09, 2014...
---> SUCCESS: Entry logged for February 10, 2014...
---> SUCCESS: Entry logged for February 11, 2014...
---> SUCCESS: Entry logged for February 12, 2014...
---> SUCCESS: Entry logged for February 13, 2014...
---> SUCCESS: Entry logged for February 14, 2014...
---> INFO: Uploading Day One entries to Dropbox...DONE.
---> INFO: Removing downloaded Day One files...DONE.
---> INFO: Removing downloaded Sifttter files...DONE.
#### EXECUTION COMPLETE!
```

As you'd expect, you can always add the `-i` switch:

```
$ srd exec -i -w 1
#### EXECUTING...
---> INFO: Creating entries for dates from February 03, 2014 to February 15, 2014...
---> INFO: Downloading Sifttter files...DONE.
---> SUCCESS: Entry logged for February 03, 2014...
---> SUCCESS: Entry logged for February 04, 2014...
---> SUCCESS: Entry logged for February 05, 2014...
---> SUCCESS: Entry logged for February 06, 2014...
---> SUCCESS: Entry logged for February 07, 2014...
---> SUCCESS: Entry logged for February 08, 2014...
---> SUCCESS: Entry logged for February 09, 2014...
---> SUCCESS: Entry logged for February 10, 2014...
---> SUCCESS: Entry logged for February 11, 2014...
---> SUCCESS: Entry logged for February 12, 2014...
---> SUCCESS: Entry logged for February 13, 2014...
---> SUCCESS: Entry logged for February 14, 2014...
---> SUCCESS: Entry logged for February 15, 2014...
---> INFO: Uploading Day One entries to Dropbox...DONE.
---> INFO: Removing downloaded Day One files...DONE.
---> INFO: Removing downloaded Sifttter files...DONE.
#### EXECUTION COMPLETE!
```

### Date Range Catch-up

To create entries for a range of dates:

```
$ srd exec -f 2014-02-01 -t 2014-02-12
#### EXECUTING...
---> INFO: Creating entries for dates from February 01, 2014 to February 12, 2014...
---> INFO: Downloading Sifttter files...DONE.
---> SUCCESS: Entry logged for February 01, 2014...
---> SUCCESS: Entry logged for February 02, 2014...
---> SUCCESS: Entry logged for February 03, 2014...
---> SUCCESS: Entry logged for February 04, 2014...
---> SUCCESS: Entry logged for February 05, 2014...
---> SUCCESS: Entry logged for February 06, 2014...
---> SUCCESS: Entry logged for February 07, 2014...
---> SUCCESS: Entry logged for February 08, 2014...
---> SUCCESS: Entry logged for February 09, 2014...
---> SUCCESS: Entry logged for February 10, 2014...
---> SUCCESS: Entry logged for February 11, 2014...
---> SUCCESS: Entry logged for February 12, 2014...
---> INFO: Uploading Day One entries to Dropbox...DONE.
---> INFO: Removing downloaded Day One files...DONE.
---> INFO: Removing downloaded Sifttter files...DONE.
#### EXECUTION COMPLETE!
```

Even more simply, to create entries from a specific point until yesterday ("yesterday" because you might not be ready to have today's entries scanned):

```
$ srd exec -f 2014-02-01
#### EXECUTING...
---> INFO: Creating entries for dates from February 01, 2014 to February 12, 2014...
---> INFO: Downloading Sifttter files...DONE.
---> SUCCESS: Entry logged for February 01, 2014...
---> SUCCESS: Entry logged for February 02, 2014...
---> SUCCESS: Entry logged for February 03, 2014...
---> SUCCESS: Entry logged for February 04, 2014...
---> SUCCESS: Entry logged for February 05, 2014...
---> SUCCESS: Entry logged for February 06, 2014...
---> SUCCESS: Entry logged for February 07, 2014...
---> SUCCESS: Entry logged for February 08, 2014...
---> SUCCESS: Entry logged for February 09, 2014...
---> SUCCESS: Entry logged for February 10, 2014...
---> SUCCESS: Entry logged for February 11, 2014...
---> SUCCESS: Entry logged for February 12, 2014...
---> INFO: Uploading Day One entries to Dropbox...DONE.
---> INFO: Removing downloaded Day One files...DONE.
---> INFO: Removing downloaded Sifttter files...DONE.
#### EXECUTION COMPLETE!
```

In this case, once more, you can use the trusty `-i` switch if you want:

```
$ srd exec -i -f 2014-02-01
#### EXECUTING...
---> INFO: Creating entries for dates from February 01, 2014 to February 15, 2014...
---> INFO: Downloading Sifttter files...DONE.
---> SUCCESS: Entry logged for February 01, 2014...
---> SUCCESS: Entry logged for February 02, 2014...
---> SUCCESS: Entry logged for February 03, 2014...
---> SUCCESS: Entry logged for February 04, 2014...
---> SUCCESS: Entry logged for February 05, 2014...
---> SUCCESS: Entry logged for February 06, 2014...
---> SUCCESS: Entry logged for February 07, 2014...
---> SUCCESS: Entry logged for February 08, 2014...
---> SUCCESS: Entry logged for February 09, 2014...
---> SUCCESS: Entry logged for February 10, 2014...
---> SUCCESS: Entry logged for February 11, 2014...
---> SUCCESS: Entry logged for February 12, 2014...
---> SUCCESS: Entry logged for February 13, 2014...
---> SUCCESS: Entry logged for February 14, 2014...
---> SUCCESS: Entry logged for February 15, 2014...
---> INFO: Uploading Day One entries to Dropbox...DONE.
---> INFO: Removing downloaded Day One files...DONE.
---> INFO: Removing downloaded Sifttter files...DONE.
#### EXECUTION COMPLETE!
```

Two notes to be aware of:

* `-f` and `-t` are *inclusive* parameters, meaning that when specified, those dates will be included when searching for Siftter data.
* Although you can specify `-f` by itself, you cannot specify `-t` by itself.

Sifttter Redux makes use of the excellent [Chronic gem](https://github.com/mojombo/chronic "Chronic"), which provides natural language parsing for dates and times. This means that you can run commands with more "human" dates:

```
$ srd exec -f "last monday" -t "yesterday"
#### EXECUTING...
---> INFO: Creating entries for dates from February 10, 2014 to February 14, 2014...
---> INFO: Downloading Sifttter files...DONE.
---> SUCCESS: Entry logged for February 10, 2014...
---> SUCCESS: Entry logged for February 11, 2014...
---> SUCCESS: Entry logged for February 12, 2014...
---> SUCCESS: Entry logged for February 13, 2014...
---> SUCCESS: Entry logged for February 14, 2014...
---> INFO: Uploading Day One entries to Dropbox...DONE.
---> INFO: Removing downloaded Day One files...DONE.
---> INFO: Removing downloaded Sifttter files...DONE.
#### EXECUTION COMPLETE!
```

See [Chronic's Examples section](https://github.com/mojombo/chronic#examples "Chronic Examples") for more examples.

# Cron Job

By installing an entry to a `crontab`, Sifttter Redux can be run automatically on a schedule. The aim of this project was to use a Raspberry Pi; as such, the instructions below are specifically catered to that platform. That said, it should be possible to install and configure on any *NIX platform.

One issue that arises is the loading of the bundled gems; because cron runs in a limited environment, it does not automatically know where to find installed gems.

## Using RVM

If your Raspberry Pi uses RVM, this `crontab` entry will do:

```
55 23 * * * /bin/bash -l -c 'source "$HOME/.rvm/scripts/rvm" && srd exec'
```

## Globally Installing Bundled Gems

Another option is to install the bundled gems to the global gemset:

```
$ bundle install --global
```

# Known Issues

* Sifttter Redux makes no effort to see if entries already exist in Day One for a particular date. This means that if you're not careful, you might end up with duplicate entries. A future version will address this.
* Multiline updates aren't caught by Sifttter Redux; it counts on content being on single lines.
* If the contents of `~/.dropbox_uploader` should ever be incorrect, Sifttter Redux fails without warning. Working on a fix, but it's slow-going.

# Future Releases

Some functionality I would like to tackle for future releases:

* Plugin architecture for services that IFTTT doesn't support
* Interactive cron job installer
* Smarter checking of the config file to see if an old version is being used
* Multiline Sifttter entries

# Bugs and Feature Requests

To report bugs with or suggest features/changes for Sifttter Redux, please use the [Issues Page](http://github.com/bachya/sifttter-redux/issues).

Contributions are welcome and encouraged. To contribute:

* [Fork Sifttter Redux](http://github.com/bachya/sifttter-redux/fork).
* Create a branch for your contribution (`git checkout -b new-feature`).
* Commit your changes (`git commit -am 'Added this new feature'`).
* Push to the branch (`git push origin new-feature`).
* Create a new [Pull Request](http://github.com/bachya/sifttter-redux/compare/).

# License

(The MIT License)

Copyright © 2014 Aaron Bach <bachya1208@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Credits

* Craig Eley for [Sifttter](http://craigeley.com/post/72565974459/sifttter-an-ifttt-to-day-one-logger "Sifttter") and for giving me the idea for Sifttter Redux
* Dave Copeland for [GLI](https://github.com/davetron5000/gli "GLI") and [Methadone]("https://github.com/davetron5000/methadone" Methadone)
* Andrea Fabrizi for [Dropbox Uploader](https://github.com/andreafabrizi/Dropbox-Uploader "Dropbox Uploader")
* Tom Preston-Werner and Lee Jarvis for [Chronic](https://github.com/mojombo/chronic "Chronic")