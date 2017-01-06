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

Our current goal for Phyloreferencing is a test suite that will allow us to go from phylogeny to a tested phyloreference with the fewest number of human interactions. To test this, I started with a paper published a few years ago by Andrew A Crowl and colleagues (including one of our PIs!): [*Phylogeny of Campanuloideae (Campanulaceae) with Emphasis on the Utility of Nuclear Pentatricopeptide Repeat (PPR) Genes*](http://dx.doi.org/10.1371/journal.pone.0094199). I wanted to see how many of the twelve named clades in this paper I could represent using Phyloreferencing, and whether those phyloreferences would work across the three phylogenies includes in this paper: plastid tree, pentatricopeptide repeat (PPR) gene family tree, and Plastid+PPR tree. Here's what that process looked like:

1. The authors submitted their trees as supplementary materials. I started with [tree S22](http://journals.plos.org/plosone/article/file?type=supplementary&id=info:doi/10.1371/journal.pone.0094199.s022), the “Plastid plus PPR” maximum likelihood tree.

2. [Phylo2owl](http://www.github.com/phyloref/phylo2owl) converted the tree to an OWL representation --- the [generated OWL file](https://github.com/gaurav/phylo2owl/blob/eb483878db6c487c09ea9624b27eefa4ef24decb/examples/trees/journal.pone.0094199.s022.owl) passed all our current tests! 

   * Trying this extraction made me wonder whether phylo2owl supports files containing duplicate taxa; since [DendroPy does not](https://github.com/jeetsukumaran/DendroPy/issues/12#issuecomment-65136908), it turns out neither do we. I've [filed an issue](https://github.com/phyloref/phylo2owl/issues/18) to fix this. 
   
   * Also, phylo2owl.py writes out an empty file if it can't read the input file; I've fixed this [as part of a series](https://github.com/gaurav/phylo2owl/commit/ada567cce992dff5cacc7d9efc2b73b1036534ad) of code cleanups.

3. I started by trying to create a phyloreference for clade C1 as illustrated in [figure 3 of the paper](http://journals.plos.org/plosone/article/figure/image?size=large&id=info:doi/10.1371/journal.pone.0094199.g003). One way of doing this is by using a logical construct we call [`phyloref:excludes_lineage_to`](https://github.com/hlapp/phyloref/blob/c2a1b813690e3afc78c2abdacab216e368b5c83e/phyloref.owl#L61), which identifies nodes that are siblings to ancestors of the target, but not ancestors of the target themselves. By using this, we can identify the subclade just under C1 (= C1 excluding *Trachelium caeruleum*) using the following OWL class definition in Manchester syntax:

    ```Node that has_Descendant value Campanula_latifolia and excludes_lineage_to value Trachelium_caeruleum```

4. To find clade C1's parent, we then need to find this clade's parent node (which would include the excluded *Trachelium caeruleum*):

    ```Node that has_Child some (has_Descendant value Campanula_latifolia and excludes_lineage_to value Trachelium_caeruleum)```

5. From there, it's a simple step to find every node that considers this node its ancestor:

    ```Node that has_Ancestor some (has_Child some (has_Descendant value Campanula_latifolia and excludes_lineage_to value Trachelium_caeruleum))```

Tada --- our first phyloreference! You can see it in Manchester format [on our Github repository](https://github.com/gaurav/phylo2owl/blob/eb483878db6c487c09ea9624b27eefa4ef24decb/examples/trees/journal.pone.0094199.s022.phylorefs.omn#L10), as well as its corresponding "_expected" class: our automated test suite compares the individuals in each class with their "_expected" class and fails if they don't contain the same set of individuals. I can't check the internal nodes in the expected class easily, but I checked the list of leaf nodes against those in the figures printed in the paper --- they match perfectly!

This is where things get trickier: this approach only works when we know which taxon is present in a sister-lineage to the one we're interested in. I'd like the next phyloreference we produce to identify the last common ancestor of two taxa within the clade; for example, can we match Clade G as the last common ancestor of *Campanula cruetzbergii* and *Campanula drabifolia*? That's what we'll be working on next!
