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

The phyloreferencing (hereafter as phyloref) project team had their second face-to-face meeting on Oct 11 & 12, 2017. The first took place in Apr, 2017. See meeting [blog/report here]. During this two-day meeting, we covered a range of topics, with an emphasis on concept taxonomy, phyloref specifications and future plans.

The meeting kicked off with Gaurav laying out an agenda and reviewing the timeline of the project. On top of the list was phyloref specifications, which Gaurav had been working on quite extensively, but was facing several challenges, theoretical or practical. Curation workflow was also on the list, and was discussed during the second day, with a focus on its current deficiencies. Hilmar suggested the curation be driven by compelling user stories. We brainstormed around that idea including primates, amphibians (e.g., *Rana*), butterflies and plants. This idea precipitated to a resolution, i.e., outreaching to NSF GoLife project teams, and this task was assigned to Guanyang. He will be working along with Nico to contact [GoLife] project PIs to explain what we are doing and why it is relevant to their projects. Nico also mentioned specifically that GoLife projects are different from the previous “Tree of Life” projects as the former put a special emphasis on generating data layers and integrating data with phylogenies. These are in line with one of the objectives of the phyloref project, i.e., enabling and facilitating large-scale data integration.

In terms of timeline, we discussed specifically two events. First, the Evolution 2018 meeting is still on the [^horizon] horizon and we would need to be ready to submit an abstract by Jan 2018 to a symposium, either the one proposed by Guanyang or another, if the former fails to be accepted by the meeting. In that abstract, we need to specify a mvp (minimal viable product) or a goal that we could deliver or accomplish and present at the actual meeting in Aug 2018. The second event that actually comes a lot more sooner is our first advisory board meeting, scheduled to happen in Feb. This is going to be an online meeting. It could also be a good time for Hilmar to come down to Gainesville for another in-person project meeting.

We would like to have a prototype by Aug 2018, which should have the following features. 

1. Reciprocal queries using a phylogeny or a phyloref as an input. When a phylogeny is provided as an input, a query should generate a list of phylorefs pertaining to that phylogeny. On the other hand, if a phyloref is used as an input, the query should resolve to a node/clade on a phylogeny. 
2. Clear benefits to users, as motivated by the user stories we plan to create. 
3. Easy to handle (user-friendly). The second and third points are quite self-explanatory. In summary, the prototype needs to be useful, appealing and accessible to biologists.

![Discussion agenda items laid  on whiteboard: user stories, prototype, phyloref specifications adn timeline]({{ site.url }}/images/2ndmeeting.whiteboard1.JPG)

During the second half of the Oct 11 morning session, Guanyang gave a presentation on concept-based taxonomic reconciliation methods, focusing on two approaches: concept taxonomy and Avibase. Concept taxonomy attempts to resolve ambiguities of taxonomic names by specifying the source of concept circumscription when a name is used. Guanyang discussed an example of using concept taxonomy to reconcile taxonomic history of southeastern orchids in the genus complex Cleistes/Cleistesiopsis and integrate specimen records of these plants. This was based on one of Nico Franz’s grant proposals, which was published in the journal RIO. In his presentation, Guanyang specifically addressed some perceived limitations of concept taxonomy. After a somewhat extended discussion on concept taxonomy, Guanyang proceeded to discuss Avibase, which is a taxonomic and biodiversity database that utilizes taxonomic concepts. A more detailed description of concept taxonomy and Avibase is reserved for a separate blog entry.

For the remaining of the first day and much of the second day, we moved on to discuss phyloref specifications and curation workflow. One issue that we discussed for some length is multiple specifiers or qualifiers. Nico explained that qualifiers are sometimes used in a phylogenetic clade definition, which act as a “safety measure”, i.e., when a qualifier falls outside a clade, then the clade definition disintegrates. This could happen when phylogeny changes or updates. A straightforward solution to create a phyloref for a clade with multiple specifiers/qualifiers is find the union of these specifiers (the least inclusive clade that contains all of them) (Fig. 7). During the course of discussing multiple specifiers, Hilmar mentioned that the OWL ontology structure does not express paths. Guanyang followed up that remark and asked why we chose to use OWL. Hilmar explained that OWL has a large community with many existing resources available for use, and contrasted the value of developing a system within an existing knowledge representation and transfer framework. A previous attempt at implementing phyloreferences by [Keesey (2007)] was based on MathML, which requires custom-written software to resolve phyloreferences. By constrast, [any OWL reasoner] should be able to resolve definitions in an OWL-based phyloreference system. But the question if OWL is an appropriate format for expressing phylorefs, especially when they are nested on a phylogeny, remains not fully answered. The next question is what is an OTU and what kind of things can be used to represent it? Guanyang’s opinion is that OTU is a rather ambiguous term and interpreted in highly variable ways by different communities/domain experts, and it is perhaps better-off that we do not use this term at all. Hilmar mentioned that matching OTUs is actually an objective stated in the grant proposal. He gave an analogy of resolving individual persons using social security numbers. In terms of the kinds of things or entities that can represent an OTU, the option is many. It could be a taxonomic name, a sample ID, a specimen accession number, a Genbank accession number, etc.

![Phyloreference specifications - multiple specifiers and OTUs]({{ site.url }}/images/2ndmeeting.whiteboard2.JPG)


Gaurav demonstrated using [Protege] to visualize phyloref OWL files. Hilmar pointed out that these OWL files are themselves project outputs: they should be polished into clearly documented ontologies that any person familiar with OWL should be able to understand. Editing, testing and fixing the input JSON-LD files should also occur through a graphical user interface (GUI) — curators of phyloreferences should not be expected to edit JSON-LD files by hand, and a GUI could simplify the process of importing multiple phyloreferences from a single paper. This would help us expand our test suite quickly, and might form the basis of the prototype we’re aiming to develop next.

Towards the end of the meeting, we did some planning for future activities. We planned out a visit for Guanyang and Gaurav to Duke in December. If selected for the Phenoscape workshop, Guarav and Guanyang can combine the visit to Hilmar with the [^workshop] workshop. Additionally, we will be having our first advisory board meeting in early 2018. 

Below is a list of pending issues that we are still exploring:

1. How is phyloref different from other taxonomic resolution/reconciliation approaches? What is it that phyloref can do that other services cannot? What do biologists need that we might be able to provide?
2. Why should we be using OWL ontology?
3. Can phyloreferences be fully portable from one phylogeny to another, in other words, independent of a particular phylogeny?
4. In relation to question 3, how do we model or create phyloref for a clade when the underlying phylogeny changes? Can we test this?

[^horizon]: The symposium proposal submitted by Guanyang was not accepted for Evolution 2018, but Gaurav should still look into submitting a talk abstract to another symposium.
[^workshop]: Both Gaurav and Guanyang were accepted to attend the Phenoscape workshop and this trip will take place in the early part of Dec. 

[blog/report here]: http://www.phyloref.org/blog/2017/04/first-face-to-face-project-meeting/
[GoLife]: https://www.nsf.gov/funding/pgm_summ.jsp?pims_id=5129
[Keesey (2007)]: http://onlinelibrary.wiley.com/doi/10.1111/j.1463-6409.2007.00302.x/full
[any OWL reasoner]: http://owl.cs.manchester.ac.uk/tools/list-of-reasoners/
[Protege]: https://protege.stanford.edu/
