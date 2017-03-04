---
layout: post
title: A Phyloreferencing Experiment
author: gaurav
modified:
excerpt: We set out to create definitions in OWL for a set of clades from a publication and present our very first phyloreference.
tags: ["phyloreferences", "web ontology language"]
published: true
comments: true
image:
  feature: 
  teaser: 
  thumb:
---

Our current goal for Phyloreferencing is a test suite that will allow us to go from phylogeny to a tested phyloreference with the fewest number of human interactions. To test this, I started with a paper published a few years ago by Andrew A. Crowl and colleagues (including one of our PIs!): [*Phylogeny of Campanuloideae (Campanulaceae) with Emphasis on the Utility of Nuclear Pentatricopeptide Repeat (PPR) Genes*](http://dx.doi.org/10.1371/journal.pone.0094199). I wanted to see how many of the twelve named clades in this paper I could represent using Phyloreferencing, and whether those phyloreferences would work across the three phylogenies includes in this paper: plastid tree, pentatricopeptide repeat (PPR) gene family tree, and Plastid + PPR tree. Here's what that process looked like:

1. The authors submitted their trees as supplementary materials. I started with [tree S22, the Plasmid + PPR tree](http://journals.plos.org/plosone/article/file?type=supplementary&id=info:doi/10.1371/journal.pone.0094199.s022), the "Plastid plus PPR" maximum likelihood tree.

2. [Phylo2owl](http://www.github.com/phyloref/phylo2owl) converted the tree to an OWL representation --- the [generated OWL file](https://github.com/phyloref/phylo2owl/blob/ecb065f817e901933668daf82e6543e2c72c2d30/examples/trees/journal.pone.0094199.s022.owl) passed all our current tests! Trying this extraction made me wonder whether phylo2owl supports files containing identically named leaf nodes; since [DendroPy does not](https://github.com/jeetsukumaran/DendroPy/issues/12#issuecomment-65136908), it turns out neither do we. I've [filed an issue](https://github.com/phyloref/phylo2owl/issues/18) to fix this. 
   
3. I started by trying to create a phyloreference for clade C1 as illustrated in [figure 3 of the paper](http://journals.plos.org/plosone/article/figure/image?size=large&id=info:doi/10.1371/journal.pone.0094199.g003). I planned to create a stem-based definition, which take the form "ancestors of taxon *X* that are not also ancestors of taxon *Y*". One way of doing this is by using a logical construct we call [`phyloref:excludes_lineage_to`](https://github.com/hlapp/phyloref/blob/c2a1b813690e3afc78c2abdacab216e368b5c83e/phyloref.owl#L61), which identifies a sibling to some ancestor of the target and that sibling's descendants, but not ancestors of the target themselves. By using this, we can identify the subclade under C1 (= C1 excluding *Trachelium caeruleum*) using the following OWL class definition in Manchester syntax:

    ```has_Descendant value Campanula_latifolia and excludes_lineage_to value Trachelium_caeruleum```

4. To find clade C1's parent, we then need to find this clade's parent node (which would include the excluded *Trachelium caeruleum*):

    ```has_Child some (has_Descendant value Campanula_latifolia and excludes_lineage_to value Trachelium_caeruleum)```

5. From there, it's a simple step to find every node that considers this node its ancestor:

    ```has_Ancestor some (has_Child some (has_Descendant value Campanula_latifolia and excludes_lineage_to value Trachelium_caeruleum))```

Tada --- my first phyloreference! You can see it in Manchester format on our Github repository as [`clade_C1`](https://github.com/phyloref/phylo2owl/blob/ecb065f817e901933668daf82e6543e2c72c2d30/examples/trees/journal.pone.0094199.s022.phylorefs.omn#L25). These phyloreferences are easy to test for small clades, where we can enumerate every node we expect to be included in this clade: you can see an example of that in our repository, named [`clade_C1_expected`](https://github.com/phyloref/phylo2owl/blob/ecb065f817e901933668daf82e6543e2c72c2d30/examples/trees/journal.pone.0094199.s022.phylorefs.omn#L29). Our test suite can now reason over the phyloreference using the OWL representation, and ensure that the two classes continue identical lists of individuals. Internal nodes are hard to check, but we can ensure that only the correct leaf nodes are included -- and they are!

I extended this to two other trees in the paper -- [tree S20, the Plasmid tree](http://journals.plos.org/plosone/article/file?type=supplementary&id=info:doi/10.1371/journal.pone.0094199.s020) and [tree S21, the PPR tree](http://journals.plos.org/plosone/article/file?type=supplementary&id=info:doi/10.1371/journal.pone.0094199.s021). I immediately ran into problems: some of the phyloreferences I came up with refer to leaf nodes that are found in one of the trees but not the others. I've summarized the [differences in the phyloreferences](https://github.com/phyloref/phylo2owl/blob/ecb065f817e901933668daf82e6543e2c72c2d30/examples/trees/journal.pone.0094199.md) as they currently stand, as well as links to all phyloreferences currently in our test suite. These are the sorts of challenges we will facing in developing useful phyloreferences, so running into them in this small experiment is a great start!

The next step is to build better phyloreferences -- ones that will work across all three of the phylogenies we have currently included, based on the different nodes present in each of those trees. New phyloreferences are on their way!
