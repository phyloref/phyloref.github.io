---
layout: post
title: Third face to face project meeting
author: gyzhang
modified:
excerpt: A report of our third face-to-face project meeting in Gainesville from Mar 21-23, 2018.
tags: ["development plan", "project plan", "project meeting"]
published: true
comments: true
image:
  feature:
  teaser:
  thumb:
---

The [Phyloreferencing project] team had their third face to face project meeting from Mar 21-23, 2018, at the UF campus in Gainesville. Lasting three days, this meeting was more extensive than the previous two, but we felt the extra day was necessary to accomplish our meeting goals. We had a rather long list of [agenda], and it was quite a miracle that we covered nearly all the items on the agenda. This blog will report on the four major parts that we discussed at meeting: ontology of phyloreferences, phyloreference curation tool, use case development, and project organization. Overall, this meeting set a clear direction for the way ahead, laid out goals, and planed tasks for the next six months.

## Ontology of phyloreferences
We will prioritize our time for up to August to work on a project to transcribe the content of the new Phyloregnum, essentially a list of clade definitions, that is to be published as a book in the near future, into an ontology of phyloreferences. We plan to write a paper that would describe the ontology itself, how it works, and some illustrative examples as to what research questions can be answered with it. This paper will, however, not focus on the theory of phyloreferencing and its relevance in the broad biology research context. The intent is to publish this paper more or less simultanesouly with the publication of the clade definition book. We discussed the outline of this paper, which would include a brief description of phyloreferencing, a list of phyloreferences in OWL format (deposited in a database and referred to in the paper), ontology specifications, and two use cases that will illustrate the use of the ontology of phyloreferences. To complete these tasks that are essential for writing this paper, we will need to first get an idea of the time requirement of curating a clade definition, converting it to a phyloreference (in OWL format), and validating the phyloreference against the reference phylogeny based on which the clade definition is made. Then we will be able to assess if it is realistic to shoot for Aug/Sep as a target time to finish the paper. To demonstrate the usefulness of this ontology of phyloreferences, we will need to show that it affords capabilities not offered by the Phylorgnum database alone. We came out with two meaningfully and potentially implementable use cases. The first is to determine relationships between phyloreferences on the original (reference) phylogeny. We ask the question "Can relationships between clade definitions be computationally determined within a given phylogeny?" We wil supply a list of clade definitions and a phylogeny to the machine, and we expect it to return a list of statements about the relationships between these definitions. For example, on the phylogeny in the figure below, the computer should tell us that *Exostratum* and *Leucophanes* are disjoint and *Alifolium* includes *Exostratum* and *Leucophanes*. In other words, the computer should be able to determine that *Exostratum* and *Leucophanes* do not share descendants, but all the descendants of *Exostratum* and *Leucophanes* are also descentants of *Alifolium*. We would like to do this with an OWL reasoner. 



Show cases where it resolves to a place where Open Tree has a name
Show cases where it resolves to a place where Open Tree does not have a name
Show cases where the Open Tree has a node elsewhere.
Show cases where it doesn’t resolve.

We anticipated some practical challenges ahead of us. A larger percentage of the phylogenies won't be available in a machine-readable format (e.g., a newick/nexus file). Some of these phylogenies may not even contain all the specifiers used in a definition. Those problems will need to resolved in an efficient way. We discussed if we need to and how to maintain this ontology of phyloreferences, e.g., how to incorporate new clade definitions as they are made and published. We decided that sustainability is outside the scope of this paper. 

## Phyloreference curation tool 

## Use case development

## Project organization
Advisory board meeting.

[agenda]: https://github.com/phyloref/organization/wiki/Third-Face-to-Face-Meeting
[Phyloreferencing project]: https://www.nsf.gov/awardsearch/showAward?AWD_ID=1458604
http://www.ggvaidya.com/curation-tool/#
