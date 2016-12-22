---
layout: post
title: How to split a codebase
author: gaurav
modified:
excerpt: We started in Python, and now we're speaking Java! A few possible ways to manage a split codebase.
tags: ["python", "java", "programming languages", "development plan", "development"]
published: true
comments: true
image:
  feature: how-to-split-a-codebase.png
  teaser: how-to-split-a-codebase.png
  thumb:
---

Our continuous testing process broke last month because the URL we used to download [Apache Jena](https://jena.apache.org/), an RDF framework that is a prerequisite for the [SHACL library we use](https://github.com/TopQuadrant/shacl). While this meant that I needed to [figure out how Maven works](https://maven.apache.org/guides/getting-started/) so that we can pull in the latest version when building this tool, it also made me think about the challenges we’re going to face mixing Python and Java code in our software, and what might be the best way of managing this.

Our working plan for the Phyloreferencing framework looks like this:

  1. A piece of software for converting any phylogeny into an RDF representation using one or more Web Ontology Language (OWL) ontologies, currently available at [phylo2owl](https://github.com/gaurav/phylo2owl).

  2. An OWL ontology for describing phyloreferences, currently [available on Github](https://github.com/hlapp/phyloref/blob/master/phyloref.owl).

  3. A test suite to validate the RDF representations of a phylogeny and a phyloreference, which can use an OWL 2 reasoner to identify which nodes the phyloreference matches, currently [in development](https://github.com/phyloref/phylo2owl/tree/master/tests).

  4. A web application that allow people to process phylogenies and phyloreferences; on the inside, this application will convert both into OWL representations and use an OWL 2 reasoner to process them. We’ll start working on this once the first three steps are complete.

When we started development, we [compared phylogenetics libraries](https://github.com/phyloref/phylo2owl/blob/f9d614866f69611894af9edde0f71c4a72850ed0/README.md#library-options) across major programming languages, and decided that Python 2 best met our needs: it has well-established and well-designed libraries for working with phylogenies, RDF, software testing and web development, it has a package management system for installing software, it comes pre-installed on MacOS X and most Linux distributions, and it is easy to install on Windows. This would allow us to package our software, making it a one-command install for anyone who has Python 2 installed.

Unfortunately, one key piece of software *isn’t* available for Python 2: the [SHACL library](https://github.com/TopQuadrant/shacl) we use is written in Java, and doesn’t come with a command-line interface. This means that I need to write a command-line interface for it so that our Python testing infrastructure can communicate with it, to test and maintain a small piece of Java in the middle of a Python codebase, and --- to get back to where this blog post started --- make sure the development framework sets up both programming languages and all the libraries we need in each one correctly. Java was right behind Python in all the criteria we were interested in, so it’s a great language to incorporate into our project; the challenge is how best to mix these two languages together.

There are three ways in which we can merge languages:

 - **Option 1.** *Leave the entire framework in Python, except for the bare minimum -- right now, that’s just the SHACL testing -- in Java.* This is as close as we can get to a single codebase while accepting that we will need code from other languages from time to time. Living in an open-source world makes this much, much easier: eventually, we can separate out the command-line SHACL testing application as its own open source project, or suggest it as an improvement to the Java SHACL library. Writing our own Python SHACL library is probably beyond the scope of our project, but is certainly an option if we feel that it’s necessary. On the downside, having Python call out to Java code through an intermediate program increases the possibility that changes outside our control could lead to our entire test suite breaking down.

 - **Option 2.** *Leave command-line applications in Python, but move the testing framework into Java.* This would neatly divide our codebase into distinctly Python components (`phylo2owl` and its test suite, probably the web application) and distinctly Java components (the main OWL validation and reasoning test suite) that wouldn’t have to communicate with each other except by sharing RDF files, which are designed to be cross-platform anyway. Future software products could be built on the libraries and code we’d already written in either of these languages, based on which was more appropriate to the task at hand. The downside is that developers who only know Python or Java would be unable to work on the parts of the codebase in the other language.

 - **Option 3.** *Rewrite everything in Java.* I’m a big fan of simplicity, so I love the idea of a single-language codebase, which would completely avoid code duplication or communication problems across the two languages. This would also make it slightly easier to recruit developers for our project in the future, since a Java programmer is easier to find than one comfortable with both Java and Python. The downside here is that Java can be a lot more convoluted to set up and work with than Python, which is built-in on MacOS X and most Linuxes, and doesn’t have built-in automated package installation like Python does.

My preference right now is Option 2, as a neat middle-path between the other two, but I can also see good arguments for either Option 3 or Option 1. What do you think? Let us know in the comments!
