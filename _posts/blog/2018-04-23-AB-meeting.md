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
  <img src="{{site.url}}//images/ABmeeting/ABmeetig-cover.png" alt="AB conference call screenshot"/>
  <figcaption> Phyloreferencing project Advisory Board had their first meeting via a conference call on Apr 23, 2018 </figcaption>
</figure>

## Phyloreferencing project: Overview, use cases, roadmap, deliverables, and curation tool 

### Overview
We had a meeting [agenda] and were able to cover all the items on it. The conference call started with an overview of the Phyloreferencing project given by [Nico]. She outlined three major drawbacks of using taxonomic names to reference biodiversity knowledge, namely, taxonomic names are ambiguous, names are not available for many nodes of the Tree of Life, and their concepts are not machine interpretatble. The phyloreferencing project attempts to mitigate these problems by creating a way to make [phylogenetic clade definitions] (PCD) machine readable, which we call "phyloreferencing". Nico also described the three types of phylogenetic clade definitions.

### Use cases
[Gaurav] briefly described what a phyloreference is and then presented three [use cases]: 
1. Querying [GBIF] using phyloreferences on the [Open Tree of Life] (OTL),
2. Quantifying the resolvability of phyloreferences (on OTL), and
3. Comparing relationships among phyloreferences on two phylogenies.

The workflow of the first use case goes like this. An user starts with resolving a phyloreference on the synthetic phylogeny of OTL. The user determines species composition in the clade and query data for this list of species in GBIF. Why use a clade definition (a phyloreference) rather than a traditional taxonomic name? Gaurave provided several reasons. First, this allows a user to document the exact clade definition used. Second, it is not dependent on a clade being included in a checklist. Third, some parts of tree of life might not be named for a long time.

<figure>
  <img src="{{site.url}}//images/ABmeeting/OTL_GBIFquery.png" alt="Use case 1"/>
  <figcaption> Flow chart showing the event flow of querying GBIF using a phyloreference resolved on the Open Tree of Life (use case 1) </figcaption>
</figure>

<figure>
  <img src="{{site.url}}//images/ABmeeting/compare_phyloref.png" alt="Use case 3"/>
  <figcaption> Flow chart showing the event flow of comparing relationships among phyloreferences between two different phylogenies (use case 3) </figcaption>
</figure>

A pratical challenge of resolving phyloreferneces is **specifier matching**. Specifiers used in a clade definition may not be identical to labels in a phylogeny against which a phyloreference is resolved. For example, *Homo sapiens* may be spelled as *H. sapiens* or *Homo sapiens* 12345, where the number indicates a sample number. There would be also the senario that specifiers are absent from a phylogeny, rendering a phyloreferencing unresolvable. For an in-depth description of specifier matching, please refer to a previous [blog post] written by Gaurav on this issue.

### Deliverables and roadmap
Next, [Hilmar] outlined four major deliverables of the project: (1) a [specification of phyloreference] construction and resolution, (2) an ontology of phyloreferences, (2) a proof-of-concept application for finding, resolving and validating phyloreferences on a given tree, and (4) a web application demonstrating large-scale biodiversity data integration. Each of these will be described in the following in some detail. 

* Phyloreferencing specification describes computational properties that a phyloreference must, should, and may have. The specification defines a data model and its semantics for phyloreferences, and recommends ontology design patterns and defines expectations.
* Ontology of phyloreferences and phyloreferencing ontology. This is a helper/application ontology, that involves properties, classes, etc, and is needed to express phyloreferences in OWL. The phyloreferencing ontology is the basis of the next product, which is the ontology of phyloreferences. This will be a collection of published and peer-reviewed clade definitions expressed as phyloreferences in OWL.
* Another major product is authoring and using phyloreferences through the phyloreferencing curation tool. This will afford the ability to find, resolve and validate phyloreferences at small-scale.
* Large scale biodiversity data integration app. This entails big picture overview of development work that builds on the previous products.

Hilmar presented a roadmap or a network of activities for the phyloreferencing project. This roadmap has the phyloreferencing curation tool situated at its center and other activities or entities linking to it. 

<figure>
  <img src="{{site.url}}//images/ABmeeting/roadmap.png" alt="Phyloreferencing project roadmap"/>
  <figcaption> A roadmap of the phyloreferencing project, with the curation tool at the center of activities. </figcaption>
</figure>

Hilmar also discussed three challenges ahead. A major computational challenge is specifier matching. As aforementioned, the absence of specifiers on a phylogeny will be a pervasive problem. Another challenge is use case and tech development for a large-scale data integration application. And the last challenge is engagement with trait (clade) oriented community and research groups. 

### Curation tool
Gaurav proceeded to present the phyloreference [curation tool]. The goals of creating this tool include (1) collect real-world examples of clade definitions, (2) find limits of our phyloreferencing model, and (3) test whether phyloreferences resolve as expected. There is also the question of how we make phyloreferences testable. Gaurav also provided a live demonstration of the curation tool. Chris Mungall and Gaurav had a brief discussion on curation time, and if the individual components of the curation tool should be provided as separate services. With this the meeting agendas were fulled covered and we proceeded to free discussion. 

<figure>
  <img src="{{site.url}}//images/ABmeeting/curationtool.png" alt="Phyloreferencing curation tool interface"/>
  <figcaption> Phyloreference curation tool interface, experimental release, available at http://www.phyloref.org/curation-tool/# </figcaption>
</figure>

## Advisory Board comments and questions

Members of the AB asked questions throughout the conference call, which we summarize in the following.

Chris Mungall asked two questions about PCD - if these definitions are complete and how widely adopted they are in taxonomic databases. A brief exchange took place on these questions. Hilmar remarked that there are numerous ways how taxonomic groups are defined, and what we focus on strictly here are monophyletic groups. For that purpose, the three types of PCD are sufficient. There is a database of PCDs, which is *Regnum*. Three hundred phylogenetic clade definitions that cover entire tree of life exist. This database is analogous to Linnaeaus’ Systema Naturae.”

After Gaurav presented the use case on querying GBIF Chris also asked about the plan to query GBIF and EOL as outlined in the grant proposal. Hilmar responded by saying “the principal idea is make large scale biodiversity data queryable using phylogenetic clade definitions/phyloreferences. None of the current databases has phylogenetic querying ability. The use case that Gaurav presented on using a phyloreference to query GBIF could also be done with EOL.” 

Chris asked about the time it takes to curate one paper. Gaurav's estimate was an hour, but it depends on familarity and other things.

David Baum asked several questions concerning the ontology of phyloreferences: (1) what is the difference between phyloreferencing ontology and ontology of phyloreferencing, (2) what is the relationship of the ontology of phyloreferencing to the *Regnum*, and (3) how easy it is to extract data from the *Regnum*. Nico and Hilmar responded to his questions. The main messages are that phyloreferencing ontology is the basis for building the ontology of phyloreferencing, and phyloreferencing does more than the phylocode/*Regnum*. David inquired the meaning of "legal", to which Nico's answer was the following: "Any definitions need to be published. Currently, in *Regnum*, definitions can be entered, even if it’s not code-compliant." David also asked "could the curation tool be made into a reverse pipeline, where you have a phyloreference anchored in the curation tool, and you could just create a clade definition entry for *Regnum*?" This was noted by Nico and Gaurav as a possiblity in future.

Jim Balhoff asked "can a specifier be a phyloreference?” Gaurav said, "A specifier is anything that is matchable on the phylogeny. A specifier can be defined broadly and can be a phyloreference as well." 

Two questions or suggestions were brought up after the meeting via email. Michael Sanderson suggested we could test compatibility among phyloreferences on a given phylogeny. David suggested we provide a service to resolve a clade definition on the OTL and send the output to the author of the definition. These are noted and will be explored as potential use cases in future.

## Advisory Board comments and questions
**This is an alternative structure for the AB questions part, as a list of Q & A.** Only two are given for illustration purpose. If this is the preferred format, I will rewrite the AB questions part in this format. 
* **Q.** Are the three types of phylogenetic clade definitions complete?

  **A.** There could be new definitions in the future. Currently, there are numerous ways how taxonomic groups are defined. What we focus on strictly here are monophyletic groups. For that purpose, the three types of PCD are sufficient. 

* **Q.** How widely adopted are PCDs in taxonomic databases? 

  **A.** There is a database of PCDs, which is *Regnum*. Three hundred phylogenetic clade definitions that cover entire tree of life exist. This database is analogous to Linnaeaus’ Systema Naturae.


##
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
[use cases]: https://hackmd.io/39c0gFdHSfWSTsEcXhfutg?view

