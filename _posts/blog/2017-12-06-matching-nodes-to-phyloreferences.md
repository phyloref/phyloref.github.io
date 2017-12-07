---
layout: post
title: Matching nodes to phyloreferences in OWL using specifiers
author: gaurav
modified:
excerpt: 
tags: ["development", "web ontology language"]
published: true
comments: true
image:
  feature: blog_post_dec2017_matching_nodes/node_matching_illustration.png
  teaser: blog_post_dec2017_matching_nodes/node_matching_illustration.png
  thumb: blog_post_dec2017_matching_nodes/node_matching_illustration.png
---

Since developing a [system for phyloreferencing based on nodes in a particular phylogeny](http://www.phyloref.org/blog/2017/03/a-phyloreferencing-experiment/) earlier this year, we've been working on extended it to support node- and branch-based definitions — if you know how to read [pytest](https://www.pytest.org/) and [TAP](https://en.wikipedia.org/wiki/Test_Anything_Protocol) output, you can see this system [correctly resolving](https://travis-ci.org/phyloref/curation-workflow/builds/285935181) most currently curated phyloreferences on Travis CI! Before those phyloreferences are ready for a proper release, however, we need to create a flexible system for matching phyloreferences to nodes.

Nodes on a phylogeny may be identified to a specimen, a species or a higher taxon; in a phylogenetic analysis, terminal nodes may also be associated with morphological or molecular character data. In the [Comparative Data Analysis Ontology](https://bioportal.bioontology.org/ontologies/CDAO) (CDAO, described in [Prosdocimi *et al.*, 2009](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2747124/)), this connection goes through an intermediate entity called a [Taxonomic Unit](http://purl.obolibrary.org/obo/CDAO_0000138) (or TU), which CDAO defines as "a unit of analysis that may be tied to a node in a tree and to a row in a character matrix". It therefore combines the commonly used but poorly defined concept of an [operational taxonomic unit](https://en.wikipedia.org/wiki/Operational_taxonomic_unit) with the less often used concept of an [hypothetical taxonomic unit](https://en.wiktionary.org/wiki/hypothetical_taxonomic_unit). A Node can be associated with a taxonomic unit through the [*represents_TU*](http://purl.obolibrary.org/obo/CDAO_0000187) property, which in turn can be linked to an external taxonomic resource through the [*has_External_Reference*](http://purl.obolibrary.org/obo/CDAO_0000164) property. External taxonomic resources may be drawn from [NCBITaxon](http://obofoundry.org/ontology/ncbitaxon.html), an ontology of taxonomic names from the [NCBI Taxonomy](http://dx.doi.org/10.1186/2041-1480-4-34). Other lineage-specific taxonomy ontologies also exist, such as the [Vertebrate Taxonomy Ontology](https://doi.org/10.1186/2041-1480-4-34) or the [Teleost Taxonomy Ontology](https://bioportal.bioontology.org/ontologies/TTO).

While these ontologies allow us to refer to entire taxa, we can also craft OWL expressions to refer to a part of a taxon. This may be done by explicitly using the [*part_of*](http://www.ontobee.org/ontology/UBERON?iri=http://purl.obolibrary.org/obo/BFO_0000050) relation, as in General Class Inclusion (GCI) axioms in [Uberon](http://uberon.github.io/). [Mungall *et al.*, 2012](http://dx.doi.org/10.1186/gb-2012-13-1-r5) provides the following as an example of a GCI:

```
uberon:parathyroid_gland and part_of some ncbitaxon:Xenopus 
  SubClassOf develops_from some uberon:pharyngeal_arch_3
```

Some properties also make it clear that they may apply to a part of the taxon. This approach is taken by the Gene Ontology, which uses [taxonomic constraints](https://github.com/obophenotype/uberon/wiki/Taxon-constraints) to specify that certain genes and processes are found "[*only in taxon*](http://purl.obolibrary.org/obo/RO_0002160)" or "[*never in taxon*](http://purl.obolibrary.org/obo/RO_0002161)", indicating that the property applies to some but not necessarily all members of that taxon. [Deegan *et al.*, 2010](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-11-530) has more details on taxonomic constraints.

Let's work through an example of linking a node in a phylogeny with a taxonomic unit: [TreeBASE tree #4419](https://treebase.org/treebase-web/search/study/taxa.html?id=1269&treeid=4419) (found in study #1269) contains a terminal node labeled "Rana zweifelii", which TreeBASE has identified to [NCBI Taxon #299667](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=299667). A reference to this taxonomic name has been created in OWL by the [Vertebrate Taxonomy Ontology](http://www.obofoundry.org/ontology/vto.html) as [VTO_0002750](http://purl.obolibrary.org/obo/VTO_0002750). We could therefore model this node as:

```
:Node_1234 a cdao:Node;
  rdfs:label "Rana zweifelii";
  cdao:represents_TU [
    cdao:has_External_Reference <http://purl.obolibrary.org/obo/VTO_0002750>
  ].
```

(Note that I use human-readable names like "*cdao:represents_TU*" in place of the actual machine-readable identifier, which in this case is [obo:CDAO_0000187](http://purl.obolibrary.org/obo/CDAO_0000187)).




This phylogeny was published in [Hillis and Wilcox, 2005](https://doi.org/10.1016/j.ympev.2004.10.007), who provide some additional information on the specimen this node is based upon. In table 1, we learn that it has a specimen identifier of "KU&nbsp;195310", that it was collected in "Mexico: Oaxaca: 1.6 mi S Cuyotepej", and that the sequence information used in this analysis for this node has been accessioned as [GenBank AY779219](https://www.ncbi.nlm.nih.gov/nuccore/AY779219). It also reveals an error in the node label: the correct taxonomic name is *Rana zweifeli*, not *Rana zweifelii*. We can add this additional information to taxonomic units through CDAO's [*has_Value*](http://purl.obolibrary.org/obo/CDAO_0000215) property. I could not find an example of taxonomic names being stored in CDAO trees outside of a label, but the recommended method for doing this appears to be by creating custom classes that extend [cdao:TUAnnotation](http://purl.obolibrary.org/obo/CDAO_0000066). This may look like this:


```
:TaxonNameAnnotation a cdao:TUAnnotation.
:SpecimenIdentifierAnnotation a cdao:TUAnnotation.

:Node_1234 a cdao:Node;
  rdfs:label "Rana zweifelii";
  cdao:represents_TU [
    cdao:has_External_Reference <http://purl.obolibrary.org/obo/VTO_0002750>;
    cdao:has_Annotation [
      a cdao:TaxonNameAnnotation;
      cdao:has_Value "Rana zweifeli Hillis, Frost and Webb 1984"
    ];
    cdao:has_Annotation [
      a cdao:SpecimenIdentifierAnnotation;
      cdao:has_Value "KU 195310"
    ]
  ].
```

But this seems unnecessarily convoluted. We could instead use [Darwin Core](http://rs.tdwg.org/dwc/terms/) terms imported into the [Biological Collections Ontology](http://www.ontobee.org/ontology/BCO), which defines classes such as [PreservedSpecimen](http://www.ontobee.org/ontology/BCO?iri=http://rs.tdwg.org/dwc/terms/PreservedSpecimen) and properties such as [catalogNumber](http://www.ontobee.org/ontology/BCO?iri=http://rs.tdwg.org/dwc/terms/catalogNumber). This might look something like this:

```
:Node_1234 a cdao:Node;
  rdfs:label "Rana zweifelii";
  cdao:represents_TU [
    cdao:has_External_Reference <http://purl.obolibrary.org/obo/VTO_0002750>;
    dwc:scientificName "Rana zweifeli Hillis, Frost and Webb 1984";
    dwc:genus "Rana";
    dwc:specificEpithet "zweifeli";
    dwc:scientificNameAuthorship "Hillis, Frost and Webb 1984";
    phyloref:derived_from_specimen [
      a dwc:PreservedSpecimen;
      dwc:institutionCode "KU";
      dwc:catalogNumber "195310";
      dwc:locality "Mexico: Oaxaca: 1.6 mi S Cuyotepej"
    ]
  ].
```

One last level of indirection: instead of associating name properties directly with the taxonomic unit, we could create a new property to separate the name into its own class. We could use the "Scientific Name" class in the Nomen ontology, not yet published but [available on Github](https://github.com/SpeciesFileGroup/nomen/blob/dd899b94c2a6cb58bdb5665018546697072f2a46/src/ontology/nomen.owl#L1003):

```
:Node_1234 a cdao:Node;
  rdfs:label "Rana zweifelii";
  cdao:represents_TU [
    cdao:has_External_Reference <http://purl.obolibrary.org/obo/VTO_0002750>;
    phyloref:has_scientific_name [
      a nomen:ScientificName;
      dwc:scientificName "Rana zweifeli Hillis, Frost and Webb 1984";
      dwc:genus "Rana";
      dwc:specificEpithet "zweifeli";
      dwc:scientificNameAuthorship "Hillis, Frost and Webb 1984"
    ];
    phyloref:derived_from_specimen [
      a dwc:PreservedSpecimen;
      dwc:institutionCode "KU";
      dwc:catalogNumber "195310";
      dwc:locality "Mexico: Oaxaca: 1.6 mi S Cuyotepej"
    ]
  ].
```

This would allow both the scientific name and the specimen to be identified as separate entities, with possibly complex relationships of inclusion and synonymy among each other. While no canonical URI is available for this specimen, we can manually look it up on databases such as VertNet, where we learn that [specimen KU&nbsp;195310](http://portal.vertnet.org/o/ku/kuh?id=be1b5c81-b069-11e3-8cfe-90b11c41863e) was collected on June 3, 1983, that the georeferenced coordinates of its collection location are 17.91 N and 97.68 W, and that it is stored as a physical specimen preserved in ethanol. We could also extract individual characters from the DNA sequence stored at [GenBank AY779219](https://www.ncbi.nlm.nih.gov/nuccore/AY779219), which we could associate with this taxonomic unit through the [*has_TU*](http://purl.obolibrary.org/obo/CDAO_0000208) property. 

This model also cleanly separates a node from the "taxonomic unit" it refers to, which is itself separate from a specimen or taxon. More detailed models of specimens do exist in OWL: within the [Populuation and Community Ontology](https://bioportal.bioontology.org/ontologies/PCO), a CDAO taxonomic unit could be considered an [organismal entity](http://purl.obolibrary.org/obo/PCO_0000031), which may stand-in for a [single organism](http://purl.obolibrary.org/obo/CARO_0001010) or a number of organisms, whether at the [population](http://purl.obolibrary.org/obo/PCO_0000001) or [taxon](http://www.ontobee.org/ontology/BCO?iri=http://rs.tdwg.org/dwc/terms/Taxon) level, against which [identifications are asserted](http://purl.obolibrary.org/obo/BCO_0000084). In this case, our node would be a member of the organism, population or taxon using the [*has_member*](http://purl.obolibrary.org/obo/RO_0002351) property. While this level of complexity is currently unnecessary for our needs, it might be useful in the future.

The trickier challenge is determining how to model "specifiers" — the components of phyloreferences that match nodes. Phyloreferences need to be able to refer to taxonomic units in a portable way, so that as many phyloreferences can be matched as accurately as possible. While phyloreferences are not limited by the requirements of phylogenetic clade definitions, it is useful to look at [article 11](https://www.ohio.edu/phylocode/art11.html) of the PhyloCode specification (version 4c), which requires that specifiers be one of:

1. A specimen, preferably a type specimen,
2. A species, by which they mean "whichever currently accepted species includes the type specimen of the species name cited in the definition is the specifier", or
3. Apomorphies in apomorphy-based phylogenetic clade definitions.
 
We set aside apomorphy-based phyloreferences for now, so the only two entities we need to match are specimens and species. Specifiers could follow the same representation as taxonomic units to store information about taxonomy and specimens, such as:

```
:Specifer_1 a phyloref:Specifier;
  cdao:has_External_Reference <http://purl.obolibrary.org/obo/VTO_0002750>;
  phyloref:has_scientific_name [
    a nomen:ScientificName;
    dwc:scientificName "Rana zweifeli";
    dwc:genus "Rana";
    dwc:specificEpithet "zweifeli";
  ];
  phyloref:derived_from_specimen [
    a dwc:PreservedSpecimen;
    dwc:institutionCode "KUH";
    dwc:catalogNumber "195310"
  ].
```

Note that the text doesn't exactly match the node we defined earlier: the collection code is "KUH", not "KU", and the scientific name is just "Rana zweifeli", without the authorship information ("Hillis, Frost and Webb 1984"). These small differences between catalogues, textual identifiers and especially taxonomic names occur all the time (do you know the [65 different permutations of names and authorships](http://www.jstor.org/stable/4065054) used by diatom taxonomists for [*Stephanodiscus minutulus*](https://westerndiatoms.colorado.edu/taxa/species/stephanodiscus_minutulus)?), and form one of the most challenging aspects of our project.

OWL is not the best place to carry out these matches: while it can represent the result of a match, OWL's class expressions cannot carry out complex text matches. We will therefore infer these relationships by comparing taxonomic units to specifiers outside of OWL and inserting axioms to represent these relationships within it. This matching might initially occur through simple text matching; we can extend this to more complex taxonomic name matching through algorithms such as [Taxamatch](https://doi.org/10.1371/journal.pone.0107510) as the need arises. When we discover nodes or specifiers that cannot be matched through simple text matching, we can add them to our test suite and use them to motivate improvements in matching strategies.

Once specifiers have been matched with taxonomic units matched by them, this matching can be extended to the nodes associated with each taxonomic unit, such as:

```
:Specifier_1 phyloref:matches_TU :TaxonomicUnit_204 .
:Node_1234 cdao:represents_TU :TaxonomicUnit_204 .
:Specifier_1 phyloref:matches_node :Node_1234
```

Once specifiers have been matched with nodes, we should be able to craft an OWL class expression for phyloreferences that correctly identify the clade of interest.

If we wanted to, we *could* implement an extremely basic taxon matching system using OWL class expressions. For external identifiers, constructing such a class expression is trivial:

```
cdao:Node and cdao:represents_TU some (
  cdao:has_External_Reference value <http://purl.obolibrary.org/obo/VTO_0002750>
)
```

The "fuzziness" of a match could be represented by including relationships between scientific names. For example, the [*Amphibian Species of the World* checklist, version 6.0](http://research.amnh.org/vz/herpetology/amphibia/index.php) treats *Rana zweifeli* [as a junior synonym](http://research.amnh.org/vz/herpetology/amphibia/Amphibia/Anura/Ranidae/Lithobates/Lithobates-zweifeli) of *Lithobates zweifeli*. We could encode this information as:

```
:Name_Rana_zweifeli a nomen:ICZN_name;
  nomen:ICZN_synonym :Name_Lithobates_zweifeli;
  dwc:scientificName "Rana zweifeli Hillis, Frost and Webb 1984".

:Name_Lithobates_zweifeli a nomen:ICZN_name;
  dwc:scientificName "Lithobates zweifeli (Hillis, Frost, and Webb, 1984)".
```

This information will allow the Nomen ontology to infer that *Rana zweifeli* is invalid, that *Lithobates zweifeli* is valid, and will allow us to detect cases where a single name is asserted to be both valid and invalid at the same time. We might then be able to automatically propagate nomenclatural relationships back to nodes and specifiers by using [OWL Property Chains](https://www.w3.org/TR/2012/REC-owl2-primer-20121211/#Property_Chains), such as by asserting:


1. That *phyloref:uses_scientific_name* is a subproperty of the property chain (*phyloref:has_scientific_name*&nbsp;&rarr;&nbsp;*nomen:ICZN_synonym*), and 
2. That *phyloref:includes_TU* is a subproperty of the property chain (*cdao:represents_TU&nbsp;&rarr;&nbsp;phyloref:uses_scientific_name*).

Incorporating all of this complexity into OWL has a few advantages: it would allow ontologies of phyloreferences to be completely self-contained, capable of carrying out basic matching with just an OWL reasoner and an OWL-based representation of a phylogeny. However, we just don't understand all the possible node matching we will need in our project; generating, debugging and (especially!) maintaining these complex OWL expressions could add dramatically to our development time. Therefore, we plan to start with basic matching outside of OWL, added to our model as a direct relationship between specifiers and nodes. We can look again at OWL-based matching once we have a larger test set of phyloreferences and associated specifiers that will need to be matched.
