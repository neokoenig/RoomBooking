# How to contribute

Third-party patches are essential for keeping the DBMigrate plug-in great.
Without your help we simply can't access the huge number of database platforms
to test each type of migration on, although we do our best. We want to keep
it as easy as possible to contribute changes that get things working in your
environment. There are a few guidelines that we need contributors to follow so
that we can have a chance of keeping on top of things.

## Getting Started

* Make sure you have a [GitHub account](https://github.com/signup/free)
* Submit a ticket for your issue, assuming one does not already exist.
  * Clearly describe the issue including steps to reproduce when it is a bug.
  * Make sure you fill in the earliest version that you know has the issue.
* Fork the repository on GitHub

## Making Changes

* Create a topic (aka feature) branch from where you want to base your work.
  * This is usually the master branch.
  * To quickly create a topic branch based on master; `git branch
    fix/master/my_contribution master` then checkout the new branch with `git
    checkout fix/master/my_contribution`.  Please avoid working directly on the
    `master` branch.
* Make commits of logical units.
* Check for unnecessary whitespace with `git diff --check` before committing.
* Make sure your commit messages are in the proper format.
* Please _DO NOT_ use cfscript code unless _absolutely_ necessary.

````
    This patch fixes this problem and this is how it does so

````

## Submitting Changes

* Push your changes to a topic branch in your fork of the repository.
* Submit a pull request to the repository
* Update your issue  mark that you have submitted code and are ready for it to be reviewed.
  * Include a link to the pull request in the ticket
