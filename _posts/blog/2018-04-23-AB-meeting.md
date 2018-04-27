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
  feature: ABmeeting/ABmeeting-Baum.png
  teaser: ABmeeting/ABmeeting-Baum.png
  thumb: ABmeeting/ABmeeting-Baum.png
---

Our first meeting with the [Advisory Board] (AB) took place via a conference call on Apr 23, 2018. All four project participants and six AB members attended this meeting. This was a major milestone of our project, which is about to approach the end of its first year. We have six members on the AB, whose expertise spans a wide spectrum of biological and computational sciences, and they are:
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

## Phyloreferencing project: Overview, roadmap, deliverables, use cases and curation tool 
We had a meeting [agenda] and were able to cover all the items on it. The conference call started with an overview of the Phyloreferencing project given by [Nico]. She outlined three major drawbacks of using taxonomic names to reference biodiversity knowledge, namely, taxonomic names are ambiguous, names are not available for many nodes of the Tree of Life, and their concepts are not machine interpretatble. The phyloreferencing project attempts to mitigate these problems by creating a way to make [phylogenetic clade definitions] (PCD) machine readable, which we call "phyloreferencing". Nico described the three types of phylogenetic clade definitions. Mungall asked two questions about PCD - if these definitions are complete and how widely adopted they are in taxonomic databases. A brief exchange took place on these questions. 

[Gaurav] then took the stage. He briefly described what a phyloreference is and then he presented three use cases: 
* Querying [GBIF] using phyloreferences on the [Open Tree of Life] (OTL),
* Quantifying the resolvability of phyloreferences (on OTL), and
* Comparing relationships among phyloreferences on two phylogenies.

A pratical challenge of resolving phyloreferneces is specifier matching. Specifiers used in a clade definition may not be identical to labels in a phylogeny against which a phyloreference is resolved. For example, *Homo sapiens* may be spelled as *H. sapiens* or *Homo sapiens* 12345, where the number indicates a sample number. There would be also the senario that specifiers are absent from a phylogeny, rendering a phyloreferencing unresolvable. For an in-depth description of specifier matching, please refer to a previous [blog post] written by Gaurav on this issue.

Next, [Hilmar] outlined four major deliverables of the project: (1) a [specification of phyloreference] construction and resolution, (2) an ontology of phyloreferences, (2) a proof-of-concept application for finding, resolving and validating phyloreferences on a given tree, and (4) a web application demonstrating large-scale biodiversity data integration. Each of these will be described in the following in some detail.

* Phyloreferencing specification describes computational properties that a phyloreference must, should, and may have. The specification defines a data model and its semantics for phyloreferences, and recommends ontology design patterns and defines expectations.
* Ontology of phyloreferences and phyloreferencing ontology. This is a helper/application ontology, that involves properties, classes, etc, and is needed to express phyloreferences in OWL. The phyloreferencing ontology is the basis of the next product, which is the ontology of phyloreferences. This will be a collection of published and peer-reviewed clade definitions expressed as phyloreferences in OWL.
* Another major product is authoring and using phyloreferences through the phyloreferencing curation tool. This will afford the ability to find, resolve and validate phyloreferences at small-scale.
* Large scale biodiversity data integration app. This entails big picture overview of development work that builds on the previous products.

David Baum asked several questions: (1) what is the difference between phyloreferencing ontology and ontology of phyloreferencing, (2) what is the relationship of the ontology of phyloreferencing to the *Regnum*, and (3) how easy it is to extract data from the *Regnum*. Nico and Hilmar responded to his questions. The main messages are that phyloreferencing ontology is the basis for building the ontology of phyloreferencing, and phyloreferencing does more than the phylocode/*Regnum*. 

<figure>
  <img src="{{site.url}}//images/ABmeeting/ABmeeting-Baum.png" alt="Baum asking questions about phyloreferecing roadmap and deliverables"/>
  <figcaption> David Baum asking questions about phyloreferecing roadmap and deliverables </figcaption>
</figure>

Gaurav proceeded to present the phyloreference [curation tool]. The goals of creating this tool include (1) collect real-world examples of clade definitions, (2) find limits of our phyloreferencing model, and (3) test whether phyloreferences resolve as expected. There is also the question of how we make phyloreferences testable. Gaurav also provided a live demonstration of the curation tool. Chris Mungall and Gaurav had a brief discussion on curation time, and if the individual components of the curation tool should be provided as separate services. With this the meeting agendas were fulled covered and we proceeded to free discussion. 

<figure>
  <img src="{{site.url}}//images/ABmeeting/curationtool.png" alt="Phyloreferencing curation tool interface"/>
  <figcaption> Phyloreference curation tool interface, experimental release, available at http://www.phyloref.org/curation-tool/# </figcaption>
</figure>

Hilmar made two remarks on the challenges ahead. A major computational challenge is specifier matching. As aforementioned, the absence of specifiers on a phylogeny will be a pervasive problem. Another challenge is developing a product that drives collaboration with trait (clade) oriented research groups. Mungall then asked about the plan to query GBIF and EOL as outlined in the grant proposal. Hilmar responded by saying “the principal idea is make large scale biodiversity data queryable using phylogenetic clade definitions/phyloreferences. None of the current databases has phylogenetic querying ability. The use case that Gaurav presented on using a phyloreference to query GBIF could also be done with EOL.” Baum asked the last question, which is "Could this [the phyloreference curation tool] be made into a reverse pipeline, where you have a phyloreference anchored in the curation tool, and you could just create a clade definition entry for *Regnum*?" This was noted by Nico and Gaurav as a possiblity in future.

## Advisory Board comments and questions

Overall the meeting was informative and productive, and filled with positive vibe and a fair amount of enthusiams from the AB. We are planning to have a in person AB meeting, which will afford the opportunity for more in-depth discussions and more constructive engagement in the various aspects of project development.

[Advisory Board]: http://www.phyloref.org/people/
[agenda]: https://hackmd.io/Zf4YpcTtSdK6vKE10Evcww?view#Agenda
[blog post]: http://www.phyloref.org/blog/2018/01/matching-nodes-to-phyloreferences/
[Chris Mungall]: http://biosciences.lbl.gov/profiles/chris-mungall-2/
[curation tool]: http://www.phyloref.org/curation-tool/
[David Baum]: https://botany.wisc.edu/staff/baum-david/
[GBIF]: gbif.org
[Gaurav]: http://www.ggvaidya.com/
[Hilmar]: http://lappland.io/
[Holly Bik]: https://www.hollybik.com/
[Jim Balhoff]: https://orcid.org/0000-0002-8688-6599
[Michael Sanderson]: https://eeb.arizona.edu/people/dr-michael-sanderson
[Nico]: https://www.floridamuseum.ufl.edu/museum-voices/nico-cellinese/
[Open Tree of Life]: https://tree.opentreeoflife.org
[phylogenetic clade definitions]: ttps://en.wikipedia.org/wiki/PhyloCode#Phylogenetic_nomenclature
[specification of phyloreference]: https://github.com/phyloref/specification
[Susan Perkins]: https://www.amnh.org/our-research/staff-directory/susan-perkins/

