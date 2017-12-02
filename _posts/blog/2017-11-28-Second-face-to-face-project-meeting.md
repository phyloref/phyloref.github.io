---
layout: post
title: Second face to face project meeting
author: gyzhang
modified:
excerpt: A report of our second face-to-face project meeting in Gainesville from Oct 11-12, 2017.
tags: ["development plan", "project plan", "project meeting"]
published: true
comments: true
image:
  feature: 
  teaser: tol_9_19_2011-400x250.jpeg
  thumb: 
---

The Phyloreferencing (hereafter as Phyloref) project team had their second face-to-face meeting on Oct 11 & 12, 2017. ([The first one] took place in April.) This time we focused on Phyloref specifications, diversifying our driving use-cases, the curation workflow, concept taxonomy, and on creating a development roadmap with milestones and dates.

## Diversifying our driving use-cases

Driving biological use-cases play a critically important role in guiding our ongoing work on the Phyloref specification and the (inherently closely related) curation workflow, and in ultimately validating the results. Although several motivating use-cases are explained in the original proposal, they aren't at a sufficiently concrete level, and they aren't tied to stakeholders external to the project personnel. We brainstormed how we can best diversify our driving use-cases, in a way that bases them off of concrete user stories[^user stories], and that engages early on stakeholders external to our project. We looked at a number of clades that exemplify or magnify the challenges Phyloref is aiming to address, including primates, amphibians (e.g., *Rana*), butterflies and plants. This exercise resulted in re-committing ourselves to reach out to NSF GoLife projects, a task which [Guanyang] will spearhead. GoLife projects stand out in their utility to inform our work because they place special emphasis on generating data layers and integrating data with phylogenies, which aligns them well with one of the key objectives of our work, namely enabling and facilitating large-scale data integration. Guanyang will be working with Nico to contact GoLife project PIs to explain what we are doing and how opportunities for cross-project collaboration could look like.

![Discussion agenda items laid  on whiteboard: user stories, prototype, Phyloref specifications adn timeline]({{ site.url }}/images/2ndmeeting.whiteboard1.JPG)

## Concept taxonomy

Concept-based taxonomic reconciliation methods have received increasing attention as a possible approach to capturing and reconciling the semantics of taxonomic concepts in a way that could be machine-accessible. To more thorougly explore and better understand the delineation between our work and concept taxonomy, Guanyang took us on an in-depth tour of concept-based taxonomic reconciliation methods, focusing on two approaches: concept taxonomy and Avibase. Concept taxonomy attempts to resolve ambiguities of taxonomic names by specifying the source of concept circumscription when a name is used. In a grant proposal by Nico Franz [published in the journal RIO][RIO], this is illustrated with an example of using concept taxonomy to reconcile taxonomic history of southeastern orchids in the genus complex *Cleistes*/*Cleistesiopsis*. Avibase, a taxonomic and biodiversity database, also utilizes taxonomic concepts, but in a much different way. A more detailed juxtaposition of the two approaches is beyond the scope of this report, but will be forthcoming as a separate blog post.

## Phyloref specification and phyloreference curation

Most of the meeting was spent discussing Phyloref specifications and the curation workflow. In particular, two hairy issues were discussed at length: the role and semantics of specifiers given as _qualifiers_ in nomenclatural phylogenetic clade definitions, and how best to model OTUs.

![Phyloreference specifications - multiple specifiers and OTUs]({{ site.url }}/images/2ndmeeting.whiteboard2.JPG)

### Qualifier specimens

Specifiers in a phylogenetic clade definition normally identify the nodes that define the ancestor anchoring the clade, by having to be descended from or (for _branch-based_ definitions) not being descended from the ancestor. However, sometimes published phylogenetic clade definitions give a specifier as a _qualifier_. A specifier in this role acts in a way as a conditional self-destruction device. A qualifier does not itself take part in determining the common ancestor anchoring the clade, but serves as an enduring requirement, for example to fall within the clade, in the face of evolving phylogenetic knowledge. If, for example, new data were to put the qualifier outside of the clade, the clade definition would then become invalid from the standpoint of nomenclature.

From the Phyloref perspective, phyloreferences don't become invalid. (As ontology terms, one might state axioms declaring them as obsolete, but that is quite different.) This raises therefore the question as to how best to represent, in the form of logic (OWL) axioms, the intent of the author who published the phylogenetic clade definition. We concluded that a phyloreference that in a given tree doesn't "match" any nodes would correspond most closely with the nomenclatural case of a phylogenetic clade definition that self-destructs when inclusion of its qualifiers isn't met anymore by the prevailing phylogenetic knowledge. How best to implement this in OWL will need to be investigated; so far only our OWL model for branch-based clade definitions (which work by exclusion) allows a phyloreference not to match, namely when a given phylogeny does not support the exclusion. One of the challenges here is due to a limitation of OWL, our chosen language for modeling data semantics, in that OWL lacks a notion of property chain length, and thus lacks property path length as an attribute that could be used in axioms. Although the benefits of using OWL, including its large supporting community and tool ecosystem, are strong, at some point the question of best suitable implementation context for phyloreferences may need revisiting, and suggest that it is advisable to decouple the language in which phyloreference semantics are formally defined and modeled (OWL) from the one in which a machine reasoner might operate or be implemented.

### Representing OTUs

What is an [OTU] and what kind of properties and property values can be used to identify it? OTU is a rather ambiguous term and interpreted in highly variable ways by different communities/domain experts. When modeling OTUs in an ontology, what kinds of ontological commitment do we have to make, and is it possible to avoid using the concept altogether? Matching OTUs is necessary to accomplish our stated objective of resolving phyloreferences against phylogenies, and because there is no universal standard for identifying OTUs, the options are many in terms of the kinds of things or entities that could be used in the wild to identify an OTU. It could be a taxonomic name, a sample ID, a specimen accession number, a Genbank accession number, etc. Given this wide variety, and to avoid ontological confusion[^otu confusion], determined that explicitly modeling OTUs as a concept will need to be part of the Phyloref specification, even if perhaps as an addendum rather than the core.

## Timeline, milestones, MVP

In terms of *timeline*, and milestones precipitated by it, we discussed planning ahead for project-specific meetings and pertinent major conferences in the coming year. In the former category, our first Advisory Board meeting (to be held virtually) is currently targeted for February or March 2018. In the latter category, both the [2018 Evolution Meetings] and the [TDWG conference] will take place in August 2018, about 1 week apart. We resolved to have a prototype, in the form of an MVP (Minimum Viable Product), as one of the major milestones to be accomplished in time for presentation at either meeting. 

This prototype should have the following features. 

1. Reciprocal queries using a phylogeny or a phyloreference as an input. When a phylogeny is provided as an input, a query should generate a list of phyloreferences pertaining to that phylogeny. On the other hand, if a phyloreference is used as an input, the query should resolve to a node/clade on a phylogeny.
2. Clear benefits to users, as motivated by the user stories we plan to elicit.
3. Usable for biologist end-users.

The second and third points are quite self-explanatory. In summary, the prototype should be demonstrably useful, appealing and accessible to biologists.

### Phyloreferences as products

Gaurav demonstrated using [Protege] to visualize phyloreference OWL files. Hilmar pointed out that these OWL files are themselves project outputs: they should be polished into clearly documented ontologies that any person familiar with OWL should be able to understand. Editing, testing and fixing the input JSON-LD files should also occur through a graphical user interface (GUI) — curators of phyloreferences should not be expected to edit JSON-LD files by hand, and a GUI could simplify the process of importing multiple phyloreferences from a single paper. This would help us expand our test suite quickly, and might form the basis of the prototype we’re aiming to develop next.

### Development-focused exchange visit with Duke

Among the postdoc training and project coordination activities anticipated in the original grant proposal is an annual exchange visit of the postdocs in Nico's lab with Hilmar's group at Duke, to focus on ontology, reasoning, and software development issues, as well as to take advantage of knowledge exchange with the professional software developers in Hilmar's team. We planned out a visit for Guanyang and Gaurav to Duke in December. If selected for the [Phenoscape workshop], Guarav and Guanyang can combine the visit with the workshop.[^workshop]

## Ongoing issues left pending

We discussed several issues that have surfaced in our ongoing work, but whcih we had to leave unresolved pending further research and exploration. These include the following:

1. Part of honing our outreach and research publishing is answering the question how Phyloref differs from other taxonomic resolution/reconciliation approaches. How can we most succinctly articulate what Phyloref can do that other services cannot? Relatedly, how do we most persuasively communicate about what biologists need to do that we might be able to provide, in contrast to or better than other approaches or services?
2. In light of some recent uncertainties about OWL-DL expressivity being capable of capturing all phyloreference definitions encountered in the wild, how do we best drive towards verifying that OWL remains the best formal logics language for implementing the machine-readable clade semantics part?
3. Although phyloreferences are fully portable from one phylogeny to another in theory, what will limit this portability in practice, given that specifiers still need to be matched somehow?
4. What does it mean for the concept of a clade as originally published if a phyloreference is applied to a phylogeny that has evolved from the one for which it was originally published? Can we create tests that flag and possibly visualize such changes?

[^workshop]: Both Gaurav and Guanyang were accepted to attend the Phenoscape workshop and this trip will take place in the early part of Dec.
[^user stories]: A [User Story](https://en.wikipedia.org/wiki/User_story) has a formal role in software development. For our purposes, we use it in the sense of goals that a user wants to accomplish and why, and that currently can be accomplished either only in a way that is unsatisfactory in some important way, or not at all.
[^otu confusion]: As the Evolutionary Informatics Working Group at NESCent [concluded many years ago][OTU], _the use of "taxon" for both an OTU and for a class in Organismal Taxonomy is a cause of confusion_.

[the first one]: {% post_url /blog/2017-04-26-first-face-to-face-project-meeting %}
[GoLife]: https://www.nsf.gov/funding/pgm_summ.jsp?pims_id=5129 
[RIO]: https://riojournal.com/article/10610/
[Keesey (2007)]: http://onlinelibrary.wiley.com/doi/10.1111/j.1463-6409.2007.00302.x/full
[any OWL reasoner]: http://owl.cs.manchester.ac.uk/tools/list-of-reasoners/
[OTU]: https://evoinfo.nescent.org/Concept_Glossary#Operational_Taxonomic_Unit
[Protege]: https://protege.stanford.edu/
[2018 Evolution Meetings]: http://evolutionmontpellier2018.org
[TDWG conference]: http://spnhc-tdwg2018.nz
[Phenoscape workshop]: https://github.com/phenoscape/KB-DataFest-2017
