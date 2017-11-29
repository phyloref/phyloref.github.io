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

The Phyloreferencing (hereafter as Phyloref) project team had their second face-to-face meeting on Oct 11 & 12, 2017. The first took place in Apr, 2017. This time the range of topics we covered focused on concept taxonomy, Phyloref specifications and future plans.

The meeting kicked off with [Gaurav] laying out an agenda and reviewing the timeline of the project. On top of the list was Phyloref specifications, which Gaurav has been working on quite extensively, but which faces several challenges, theoretical as well as practical. Curation workflow was also on the list, and its deficiencies were discussed during the second day. Hilmar suggested the curation be driven by compelling user stories. We brainstormed that idea by looking at primates, amphibians (e.g., *Rana*), butterflies and plants, clades that exemplify or magnify the challenges Phyloref is aiming to address. This exercise resulted in the resolution to reach out to NSF GoLife projects, a task which [Guanyang] will spearhead. He will be working along with Nico to contact GoLife project PIs to explain what we are doing and how opportunities for cross-project collaboration could look like. GoLife projects stand out in their utility to inform our work because they place special emphasis on generating data layers and integrating data with phylogenies, which aligns them well with one of the key objectives of our work, namely enabling and facilitating large-scale data integration.

![Discussion agenda items laid  on whiteboard: user stories, prototype, Phyloref specifications adn timeline]({{ site.url }}/images/2ndmeeting.whiteboard1.JPG)

In terms of *timeline*, and milestones precipitated by it, we discussed planning ahead for pertinent major conferences and for project-specific meetings in the coming year. In the latter category, our first Advisory Board meeting (to be held virtually) is currently targeted for February or March 2018. In the former category, both the [2018 Evolution Meetings] and the [TDWG conference] will take place in August 2018, about 1 week apart. We resolved to have a prototype, in the form of a MVP (Minimum Viable Product), as one of the major milestones to be accomplished in time for presentation at either meeting. 

This prototype should have the following features. 

1. Reciprocal queries using a phylogeny or a phyloreference as an input. When a phylogeny is provided as an input, a query should generate a list of phyloreferences pertaining to that phylogeny. On the other hand, if a phyloreference is used as an input, the query should resolve to a node/clade on a phylogeny.
2. Clear benefits to users, as motivated by the user stories we plan to elicit.
3. Usable for biologist end-users.

The second and third points are quite self-explanatory. In summary, the prototype should be useful, appealing and accessible to biologists.

During the second half of the Oct 11 morning session, Guanyang took us on an in-depth tour of concept-based taxonomic reconciliation methods, focusing on two approaches: concept taxonomy and Avibase. Concept taxonomy attempts to resolve ambiguities of taxonomic names by specifying the source of concept circumscription when a name is used. In a grant proposals by Nico Franz [published in the journal RIO][RIO], this is illustrated with an example of using concept taxonomy to reconcile taxonomic history of southeastern orchids in the genus complex *Cleistes*/*Cleistesiopsis*. Avibase, a taxonomic and biodiversity database, also utilizes taxonomic concepts, but in a much different way. A more detailed juxtaposition of the two approaches is beyond the scope of this report, but will be forthcoming as a separate blog post.

We spent much of the remainder of the meeting discussing Phyloref specifications and the curation workflow. One issue we spoke about for some length is the role and semantics of specifiers sometimes given as _qualifiers_ in nomenclatural phylogenetic clade definitions. A specifier that is given as a qualifier in a phylogenetic clade definition acts in a way as a conditional self-destruction device. A qualifier does not itself take part in determining the common ancestor anchoring the clade, but serves as an enduring requirement, for example to fall within the clade, in the face of evolving phylogenetic knowledge. If, for example, new data were to put the qualifier outside of the clade, the clade definition would then become invalid from the standpoint of nomenclature. However, from the Phyloref perspective, phyloreferences don't become invalid (as ontology terms, one might state axioms declaring them as obsolete, but that is quite different), raising the question as to how best to represent, in the form of logic (OWL) axioms, the intent of the author who published the phylogenetic clade definition. We concluded that a phyloreference that in a given tree doesn't "match" any nodes would correspond most closely with the nomenclatural case of a phylogenetic clade definition that self-destructs when inclusion of its qualifiers isn't met anymore by the prevailing phylogenetic knowledge. How best to implement this in OWL will need to be investigated; so far only our OWL model for branch-based clade definitions (which work by exclusion) allows a phyloreference not to match, namely when a given phylogeny does not support the exclusion. One of the challenges here is due to a limitation of OWL, our chosen language for modeling data semantics, in that OWL lacks a notion of property chain length, and thus lacks property path length as an attribute that could be used in axioms. Although the benefits of using OWL, including its large supporting community and tool ecosystem, are strong, at some point the question of best suitable implementation context for phyloreferences may need revisiting, and suggest that it is advisable to decouple the language in which phyloreference semantics are formally defined and modeled (OWL) from the one in which a machine reasoner might operate or be implemented.

The next question is what is an OTU and what kind of things can be used to represent it? Guanyang’s opinion is that OTU is a rather ambiguous term and interpreted in highly variable ways by different communities/domain experts, and it is perhaps better-off that we do not use this term at all. Hilmar mentioned that matching OTUs is actually an objective stated in the grant proposal. He gave an analogy of resolving individual persons with social security numbers. In terms of the kinds of things or entities that can represent an OTU, the option is many. It could be a taxonomic name, a sample ID, a specimen accession number, a Genbank accession number, etc.

![Phyloreference specifications - multiple specifiers and OTUs]({{ site.url }}/images/2ndmeeting.whiteboard2.JPG)

Gaurav demonstrated using [Protege] to visualize phyloreference OWL files. Hilmar pointed out that these OWL files are themselves project outputs: they should be polished into clearly documented ontologies that any person familiar with OWL should be able to understand. Editing, testing and fixing the input JSON-LD files should also occur through a graphical user interface (GUI) — curators of phyloreferences should not be expected to edit JSON-LD files by hand, and a GUI could simplify the process of importing multiple phyloreferences from a single paper. This would help us expand our test suite quickly, and might form the basis of the prototype we’re aiming to develop next.

Towards the end of the meeting, we did some planning for future activities. We planned out a visit for Guanyang and Gaurav to Duke in December. If selected for the Phenoscape workshop, Guarav and Guanyang can combine the visit to Hilmar with the [^workshop] workshop. Additionally, we will be having our first advisory board meeting in early 2018.

Below is a list of pending issues that we are still exploring:

1. How is Phyloref different from other taxonomic resolution/reconciliation approaches? What is it that Phyloref can do that other services cannot? What do biologists need that we might be able to provide?
2. Why should we be using OWL ontology, while it is not clear whether it is capable of expressing nested phyloreferences?
3. Can phyloreferences be fully portable from one phylogeny to another, in other words, independent of a particular phylogeny?
4. In relation to question 3, how do we model or create a phyloreference for a clade when the underlying phylogeny changes? Can we test this?

[^workshop]: Both Gaurav and Guanyang were accepted to attend the Phenoscape workshop and this trip will take place in the early part of Dec. 

[blog/report here]: {% post_url /blog/2017-04-26-first-face-to-face-project-meeting %}
[GoLife]: https://www.nsf.gov/funding/pgm_summ.jsp?pims_id=5129 
[RIO]: https://riojournal.com/article/10610/
[Keesey (2007)]: http://onlinelibrary.wiley.com/doi/10.1111/j.1463-6409.2007.00302.x/full
[any OWL reasoner]: http://owl.cs.manchester.ac.uk/tools/list-of-reasoners/
[Protege]: https://protege.stanford.edu/
[2018 Evolution Meetings]: http://evolutionmontpellier2018.org
[TDWG conference]: http://spnhc-tdwg2018.nz
