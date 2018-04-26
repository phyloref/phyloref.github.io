---
layout: post
title: Advisory Board meeting
author: gyzhang
modified:
excerpt: The first Advisory Board online meeting took place on Apr 23, 2018.
tags: ["Advisory Board", "milestone", "project meeting"]
published: true
comments: true
image:
  feature:
  teaser: 
  thumb: 
---

Our first meeting with the [Advisory Board] (AB) took place via a conference call on Apr 23, 2018. All four project participants and six AB members attended this meeting. This was a major milestone of our project, which is about to approach the end of its first year. We have six members on the AB, whose expertise spans a wide spectrum of biological and computational sciences.
* [Jim Balhoff] (RENCI - Renaisssance Computing Institute), ontology developer and computational biologist
* [David Baum] (University of Wisconsin, Madison), botanist and systemtic biologist
* [Holly Bik] (University of California, Riverside), microbiologist, nematologist, and genomics-based biodiversity researcher
* [Chris Mungall] (Lawrence Berkeley National Laboratory), ontology develper and computatioanl biologist
* [Susan Perkins] (American Museum of Natural History), parasitologist, systematic biologist
* [Michael Sanderson] (University of Arizona), botanist and systematic biologist

<figure>
  <img src="{{site.url}}//images/ABmeeting/ABmeetig-cover.png" alt="Phyloreferencing Advisory Board meeting"/>
  <figcaption>First Phyloreferencing project Advisory Board meeting took place on Apr 23, 2018 via an online conference. Six AB members and four project participants joined the meeting. </figcaption>
</figure>

We had a meeting [agenda] and were able to cover all the items on it. The conference call started with an overview of the Phyloreferencing project given by Nico. She outlined three major drawbacks of using taxonomic names to reference biodiversity knowledge, namely, taxonomic names are ambiguous, names are not available for many nodes of the Tree of Life, and their concepts are not machine interpretatble. The phyloreferencing project attempts to mitigate these problems by creating a way to make [phylogenetic clade definitions] (PCD) machine readable, which we call "phyloreferencing". Nico described the three types of phylogenetic clade definitions. Mungall asked two questions about PCD - if these definitions are complete and how widely adopted they are in taxonomic databases. A brief exchange took place on these questions. 

Gaurav then took the stage. He briefly described what a phyloreference is and then he presented three use cases: 
* Querying GBIF using phyloreferences on the [Open Tree of Life] (OTL),
* Quantifying the resolvability of phyloreferences (on OTL), and
* Comparing a phyloreference on different phylogenies.

A pratical challenge of resolving phyloreferneces is specifier matching. Specifiers used in a clade definition may not be identical to labels in a phylogeny against which a phyloreference is resolved. For example, *Homo sapiens* may be spelled as *H. sapiens* or *Homo sapiens* 12345, where the number indicates a sample number. There would be also the senario that specifiers are absent from a phylogeny, rendering a phyloreferencing unresolvable. 

Next, Hilmar outlined four major deliverables of the project: (1) a specification of phyloreference construction and resolution, (2) an ontology of phyloreferences, (2) a proof-of-concept application for finding, resolving and validating phyloreferences on a given tree, and (4) a web application demonstrating large-scale biodiversity data integration. Each of these will be described in the following in some detail.

* Phyloreferencing specification describes computational properties that a phyloreference must, should, and may have. The specification defines a data model and its semantics for phyloreferences, and recommends ontology design patterns and defines expectations.
* Ontology of phyloreferences and phyloreferencing ontology. This is a helper/application ontology, that involves properties, classes, etc, and is needed to express phyloreferences in OWL. The phyloreferencing ontology is the basis of the next product, which is the ontology of phyloreferences. This will be a collection of published and peer-reviewed clade definitions expressed as phyloreferences in OWL.
* Another major product is Authoring and using phyloreferences through the phyloreferencing curation tool. This will afford the ability to find, resolve and validate phyloreferences at small-scale.
* Large scale biodiversity data integration app. This entails big picture overview of development work that builds on the previous products.

A couple of questions 

[Advisory Board]: http://www.phyloref.org/people/
[agenda]: https://hackmd.io/Zf4YpcTtSdK6vKE10Evcww?view#Agenda
[Chris Mungall]: http://biosciences.lbl.gov/profiles/chris-mungall-2/
[David Baum]: https://botany.wisc.edu/staff/baum-david/
[Holly Bik]: https://www.hollybik.com/
[Jim Balhoff]: https://orcid.org/0000-0002-8688-6599
[Michael Sanderson]: https://eeb.arizona.edu/people/dr-michael-sanderson
[Open Tree of Life]: https://tree.opentreeoflife.org
[phylogenetic clade definitions]: ttps://en.wikipedia.org/wiki/PhyloCode#Phylogenetic_nomenclature
[Susan Perkins]: https://www.amnh.org/our-research/staff-directory/susan-perkins/

