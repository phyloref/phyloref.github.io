---
layout: post
title: "Guest post: About phyloreferences"
status: draft
author: odontomachus
modified:
excerpt: A guest post from Jonathan Rees, originally published on his own blog in June 2018. 
tags: ["guest post", "theory"]
image:
  feature:
  teaser: tol_9_19_2011-400x250.jpeg
  thumb:
---

_The following is a guest post by [Jonathan Rees]. It was [originally published](https://odontomachus.wordpress.com/2018/06/13/about-phyloreferences/) in June 2018 on Jonathan's own blog, and is reposted here with his permission. All opinions stated in this post are Jonathan's. Our syndication of his post does not imply any kind of endorsement from our project, nor is it meant to indicate that we share these opinions. One of our main goals with this blog has always been to stimulate discussion and to engage our community in our project objectives, whether you agree with our approach or not. We hope that syndicating Jonathan's post contributes to that. If you have, or know of a piece that would be suitable for reposting here as well, please contact the PIs._

# About phyloreferences

Gaurav Vaidya has written two interesting articles on phyloreferences:

* [A phyloreferencing experiment]
* [Matching nodes to phyloreferences in OWL using specifiers]

The following is my attempt to make some sense of phyloreferences, and re-express the ideas (to the extent I understand them) in my personal idiolect. I make no claims of novelty.

## Classification and inference

In any area of study where one deals with lots of things, it is important to discover natural groupings (classes, taxa) of those things. Define a grouping G to be natural if membership of an item X in G helps to predict properties of X, beyond just those properties that led it to being placed in G. That is, if other members of the group have some property P, then X is more likely to have property P than it would be otherwise. (I am being intentionally imprecise; read on.)

Biology certainly has to deal with lots of things, and lots of kinds of things – molecules, alleles, specimens, species, and so on – so for the purpose of prediction, it puts a lot of energy into finding natural classifications.

In the case of evolved entities, groupings that are consistent with evolution are often called out as ones that are likely to be natural. Such a grouping has the property that all of its members descend from some hypothetical founder; such groupings are called monophyletic groups, or clades. The search for natural groupings, and the search for evolutionary history, are not logically related a priori, but the assumption that clades are natural is a sensible heuristic, because properties are for the most part inherited.

(For the sake of focus I won’t talk about the relation of non-hierarchical or recombinant effects, i.e. sex, lateral gene transfer, hybridization, and so on, to classification, although they are undeniably important.)

## Phylogenetic trees

Membership in a clade can be difficult to determine, both because we might not know much about the clade’s founder, and because ancestry can be very difficult to work out. Formal methods for obtaining hypotheses of ancestry and relatedness are collectively known as phylogenetic analysis, and its results have been impressive. On the other hand, hypotheses proposed by phylogenetic analysis are sometimes very weak, in which case nobody puts much confidence in them.

Phylogenetic analysis starts with a fixed set S of items, understood to be mutually distinct or disjoint. The items are only a small set of samples among some much larger universe U of items under study. (E.g. 25 individual mammal specimens from museums might be used to infer aspects of the evolutionary history of all mammals.) The output of the analysis is a tree T (‘tree’ in the computer science sense) with tip nodes corresponding to the items, together with internal nodes and a root node. The nodes are connected by arcs, which we can take as directed away from the root of T.

It is conventional to interpret the nodes of T as clades, but additional assumptions are needed to for this to make sense, because appropriate clades may not exist, or there may be many appropriate clades to choose from.

For each node N in T, we can consider the clades C, among all the clades in U, that are ‘compatible’ with N in the following technical sense: C is compatible with N if C contains all of the items in S whose nodes are reachable from N, and excludes all of the items in S whose nodes are not reachable from N. Any node N expresses a hypothesis that there exists (or once existed) a clade compatible with N.

For given N, there may be no compatible clade in U (i.e. N’s hypothesis about evolution may be incorrect). If there is a compatible clade C, there will be many of them, identical in terms of which items from S they contain (and don’t), but differing regarding containment of other items in U.

For given N it is often useful to select a single clade C(N) for use in further analysis. We might be able to get away with saying: “Suppose there are compatible clades; let C(N) be such any such clade,” if the choice doesn’t matter. Or, we might say: “We will decide which clade we care about later, after more information is in” treating C(N) as a variable to be solved for. Other conventional rules for selection are to pick the crown clade (the smallest clade in U compatible with N), the stem clade (the largest clade in U compatible with N), or the compatible unique clade that originates some particular evolutionary innovation (apomorphy).

## Item specifier matching

The items in the item set S are not given directly, but rather are specified with bits of writing (identifiers, descriptions, etc.) that we have to interpret, so any use of a phylogenetic analysis in conjunction with other data has to start with scrutiny of those item specifiers. Consider in particular the case of comparing the evolutionary hypotheses expressed by a tree T1 with those expressed by a tree T2, where either their item sets S1 and S2 are different, or their items are specified in different ways, or both. To get a meaningful comparison, the item specifiers in T1 have to be matched with item specifiers in T2, consistent with their respective intended meanings.

I don’t have much to say about how the matching is done. Gaurav suggests using automated ontology-based inference such as OWL DL, and that sounds like a fine idea to me. Given item specifiers I1 from T1 and I2 from T2, the outcome of a match attempt could be that they specify the same item, or different ones; or, if the items are themselves groupings (such as species, as opposed to specimens or DNA samples), we might have a subsumption or non-subsumption overlap relation between the groupings.

When an item specifier match exists and is unique, we are ready to move on. But when we get 1-to-n or n-to-n’ matches, interpretation is harder. Suppose the matching phase says that the items specified by I2a, I2b, and I2c from T2 are subsumed by the item specified by I1 in T1. If there is a node N2 from which I2a, I2b, and I2c are reachable, and no other matched item specifiers are, we can hypothesize the existence of a clade C(N2) that is the same as one of the clades compatible with the I1 node. In harder cases, such as where there is no such node N2, or if matching items overlap without either subsuming the other, one will have to think harder about what to do.

With a completed matching, we are in a position to ask whether, for nodes N1 (in T1) and N2 (in T2), it would be consistent to assume the existence of a clade C compatible with both N1 and N2. If so, it would be natural to say that nodes N1 and N2 are ‘compatible’. With this notion of node compatibility in hand, we can then ask, which nodes N2 in T2 (if any) are compatible with N1?

## Phyloreferences

The following definition of ‘phyloreference’ is my own, and perhaps incompatible with the way others use the term.

A phyloreference is an information-thing, perhaps a bit of writing, intended to refer to a clade. A phyloreference consists of:

1. a nonempty set I of item specifiers (‘in-specifiers’),
2. a set O of item specifiers (‘out-specifiers’), necessarily nonempty if I is a singleton set,
3. a clade choice rule: either ‘crown’, ‘stem’, or ‘apomorphy A’ for some A, allowing one to choose a single clade among all the clades containing the items specified by I and not containing the items specified by O.

To connect to the preceding exposition, phyloreferences are effectively nodes in degenerate phylogenetic trees. Given a phyloreference P, let T(P) be the tree defined as follows:

1. Let T(P)’s root have a child N,
2. let T(P)’s root also have a child for each item specifier in O,
3. let N have a child for each item specifier in I.

Now, from the clades compatible with N, let C(P) = the one determined by P’s choice rule (if one exists). C(P) is then the clade that we intend, when we take P to refer to a clade.

Any use of a phyloreference as a reference builds in the implicit hypothesis that such a clade exists, much as 5/y > 2 builds in the hypothesis that y is nonzero.

A phyloreference P may be used to locate a node in a given tree, say T. Assume that all of P’s item specifiers are matched to item specifiers associated with tips of T. Observe that for any clade C, C is compatible with at most one node in that tree. (This is not true in the case of an apomorphy choice rule, where the location of the apomorphy in the tree is not known; dealing with this situation is left as an exercise for the reader.) So we can interpret P to find a unique node of T, when there is one that’s compatible.

Because trees can express incompatible phylogenetic hypotheses, there is no guarantee that a phyloreference locates nodes compatible with the same clade in every tree. There might be an item specified in T1 and T2 but not in P whose specifier is reachable from N1 but not from N2. When we go to find clades for N1 and N2, we will have to choose different clades for them.

## An application of phyloreferences?

Unfortunately I still don’t know what phyloreferences are for – for what problem they provide the best available solution. So I will just talk about my own experience with them.

I was interested at one point for using them in the Open Tree of Life project. The problem to be solved was what I like to call “transfer of annotation”. Somebody (or a piece of software) wants to point to a node N1 in tree T1 and say something about it or some related entity, such as a clade. Suppose they want to say A1(N1). A1(N1) might be a comment, a bug report, a citation, a link to a data source, etc. The problem then is what to do with all the annotations when a new tree T2 is published as an improvement on T1. One would like to stick one’s neck out and say: perhaps A1(N2), because A1(N1) and N2 is an awful lot like N1.

Well this looks like a lost cause. ‘An awful lot like N’ doesn’t provide enough predictability for users. If you are talking about nodes in trees, then the truth of what you are saying could depend on just about any detail of the entire tree, or of anyone’s interpretation of the tree. That is, node annotations are, strictly speaking, not transferable at all, lacking further understanding of what the annotation is trying to say. And ‘further understanding’ is usually not something a big data aggregator has.

This attitude is too pessimistic. A better approach is to establish a simple, consistent rule for annotation transfer, and to be transparent about it. We might give each annotation point a rule (call it a ‘locator’) that (1) uniquely selects that node from the tree and (2) will select the node in other trees to which the annotations will be attached.

This means that the annotations are primarily connected with the locator, not with the node. If everyone understands that, and can see what the locators are and how they work, then at least the whole process is transparent and unambiguous.

The more inclusive the locator (fewer constraints), the more annotations will be transferred, possibly creating ambiguities and/or false positives. The more restrictive the locator (more constraints), the more likely an annotation would have no good place to go, and would become lost or difficult to find. There is no way to be perfect.

I wanted locators to be small and easy to use and understand. Each locator would have a unique identifier for easy reference. We called the identifiers ‘node ids’ or ‘OTT ids’ but under this plan they would be locator ids. Annotations would be connected to nodes via locators specified by their locator ids.

Phyloreferences seemed a good tool to use here (although I didn’t know the word at the time). They are easy to understand, easy to compute with, and moderately robust in the sense that using a given phyloreference on two trees is ‘likely’ to yield the same, or compatible, interpretations (clades) relative to the two trees.

So, for example, we might have a node N in tree T1 subtending all and only mammals (mammal-item nodes). We create a phyloreference / locator P for N with, say, I={platypus, koala, rat}, O={garter snake}, A=’whatever it takes to be called a mammal’, and store it. (Yes the name business is cheating but taxon names are often the closest we have to an apomorphy in this kind of bulk informatics.) When we want to use P in the context of ‘improved’ tree T2, we match P’s item specifiers to item specifiers in T2, and if we’re lucky these all match uniquely. Then we can resolve P, i.e. look at nodes in taxonomy T2 that subtend T2’s I-nodes and exclude T2’s O-nodes. This will usually yield a unique node N2 in T2.

If there is no N2, we have a conflict between evolutionary hypotheses, and there is not much to say. If T2 has multiple ‘mammal’ pseudo-apomorphy points, this is a pathological case and should probably be flagged for manual intervention.

_Added 6/15: More on the names business: Automatic bulk phyloreference-to-tree resolution is already heuristic, and names seem a plausible practical cue to use when there is an ambiguity based on I and O. But many nodes don’t have names, and you can easily go wrong using names to match. So it might be better just to stick with the crown or stem rule uniformly. There is a lot of room for improvement in this theory._

## What happened

This design was rejected by the project, and not pursued further. I’m not complaining; I think the theory was not well enough developed at the time to warrant the investment.

One objection was the arbitrariness of the choices of I and O. These sets had to be chosen automatically as we had no way to manually review phyloreferences for over 100,000 internal nodes. In my prototype I used heuristics to guess at which items (usually species) were most likely to persist into the future. It was hard to figure out how big I and O should be (2 items? 5? 30? arbitrarily large?).

Another objection was to their summary nature. We have the entire trees T1 and T2, the thinking went, so why not make use of the entire trees somehow, rather than use a small summary? After all, the use of summaries can lead to false positive matches. Computational feasibility did not seem to be a very principled reason.

Another objection was identifier (and therefore annotation) instability as the members of I and O ‘moved’ across the ‘apomorphy’. It is useful to be able to transfer annotations for groups whose membership changes, but if the summary I and O contain items that move, then the old locator no longer locates a node in the new tree. For example, if a cockroach is in the O-set for termites, then a new tree putting cockroaches inside of termites would not have a node for the termite locator; this would be unfortunate since it is our understanding of cockroach evolution, not the apomorphy for termites, that has changed. Termites are ‘unchanged’, even if we were ‘wrong’ before about whether cockroaches are termites.

Open Tree’s multiple taxonomy version sequences would provide an empirical basis for studies that test to see how frequently phyloreferences of this kind “break” (become unresolvable or ambiguous in some trees). If the number of failures is small enough that failures can be processed manually, then perhaps the approach is feasible after all.

Beyond this little study, I do not want to say that there are no uses for phyloreferences; I am confident that the people working on them do so for very good reasons, and that I am just a slouch for not having discovered them. I look forward to hearing how this line of work continues.

Thanks to Gaurav Vaidya for all his help. All errors are mine.

## Appendix: A note on terminology

One thing that often irritates me in others’ writing is confusion about whether someone is talking about information-things or biology-things. For example, the word “clade” is used in both ways: sometimes a clade is a node in a tree (information), and sometimes it is a monophyletic group of organisms (biological things). The term “metonymy” describes these switcheroos, which consist of the replacement of a thing (e.g. a clade) with some related thing (e.g. something that can be
interpreted as a clade). In ordinary language, metonymy is very common and people usually make sense of it without noticing it. But when you combine difficulties with knowing what is true (e.g. phylogenetics) with a need for formal rigor (ontology and programming), metonymy is a train wreck. It is too easy to make statements that are confusing to the reader or inference system and that, when implemented computationally, can lead to wrong answers or inconsistency.

(“Clade” has a third use – perhaps the most common – as “clade hypothesis” or “hypothetical clade”, something that might be expressed by an information-thing such as a node. If we are both looking at a phylogenetic tree that groups turtle with weasel putting opossum outside that group, what the tree says makes no difference to whether there is actually a clade containing turtle and weasel but excluding opossum. There isn’t any such clade! We all know that! But there does exist a (false) clade *hypothesis* that _claims_ that there is such a clade. There are things that we might say about the hypothesis, and so on. There is nothing inconsistent about this, unless one uses “clade” metonymously.)

In light of this I’ve tried to use words carefully. An “item” is a biological thing, a real-world entity that you can see or touch or measure or reason about, and that is situated in space and time. So, a pinned insect in a museum, and the DNA in a well in a plate in a wet lab, are items. An “item specifier” is an information-thing, a bit of writing that people can copy from place to place. (To be extra careful one would distinguish each particular copy of the item specifier, situated in space and time, from the common pattern to which all copies conform.)

Part of the reason that “clade” is so difficult to keep straight is that while clades are a biological things, and easily characterized, they are very difficult to know anything about. This difficulty in knowing makes the biological sense of the word almost useless to biologists, who with good reason only want to talk about clade hypotheses, not some unknowable reality.

These distinctions become critical as one moves from natural language to logical frameworks such the Web Ontology Language (OWL), and infinitely more so if there is the possibility of integration with other frameworks. A system that manages on technical grounds to be logically consistent, yet confuses information-things with biological-things, may cause some second system to become inconsistent when the two are combined.

I can’t expect others to follow my lead, but I wish they would. Of course I may have slipped up and used the wrong word somewhere – it is easy to do. And informal prose can become stilted and unpleasant to read if one is too pedantic; e.g. in some contexts “weasel” works much better than “an item specifier for the weasel clade” for communication with humans.

By the way I don’t want “item” to escape the context of this article. I just used it because I was uncomfortable with Gaurav’s “taxonomic unit” and I couldn’t think of anything better than “item”.

[Jonathan Rees]: https://odontomachus.wordpress.com
[A phyloreferencing experiment]: {% post_url /blog/2017-03-21-a-phyloreferencing-experiment %}
[Matching nodes to phyloreferences in OWL using specifiers]: {% post_url /blog/2018-01-29-matching-nodes-to-phyloreferences %}
