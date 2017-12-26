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

Since developing a [system for phyloreferencing based on nodes in a particular phylogeny]({% post_url 2017-03-21-a-phyloreferencing-experiment %}) earlier this year, we've been working on extended it to support node- and branch-based definitions — if you know how to read [pytest](https://www.pytest.org/) and [TAP](https://en.wikipedia.org/wiki/Test_Anything_Protocol) output, you can see this system [correctly resolving](https://travis-ci.org/phyloref/curation-workflow/builds/285935181) most currently curated phyloreferences on Travis CI! Before those phyloreferences are ready for a proper release, however, we need to create a flexible system for matching phyloreferences to nodes.

Nodes on a phylogeny may be identified to a specimen, a species or a higher taxon; in a phylogenetic analysis, terminal nodes may also be associated with morphological or molecular character data. In the [Comparative Data Analysis Ontology](https://bioportal.bioontology.org/ontologies/CDAO) (CDAO, described in Prosdocimi *et al.*, 2009[^prosdocimi_et_al_2009]), this connection goes through an intermediate entity called a [Taxonomic Unit](http://purl.obolibrary.org/obo/CDAO_0000138) (or TU), which CDAO defines as "a unit of analysis that may be tied to a node in a tree and to a row in a character matrix". It therefore combines the commonly used but vaguely defined concept of an [operational taxonomic unit](https://en.wikipedia.org/wiki/Operational_taxonomic_unit) with the less often used concept of an [hypothetical taxonomic unit](https://en.wiktionary.org/wiki/hypothetical_taxonomic_unit). A Node can be associated with a taxonomic unit through the [*represents_TU*](http://purl.obolibrary.org/obo/CDAO_0000187) property, which in turn can be linked to an external taxonomic resource through the [*has_External_Reference*](http://purl.obolibrary.org/obo/CDAO_0000164) property. External taxonomic resources may be drawn from the [NCBITaxon ontology](http://obofoundry.org/ontology/ncbitaxon.html), an ontology of taxonomic names from the [NCBI Taxonomy](http://dx.doi.org/10.1186/2041-1480-4-34), or a lineage-specific taxonomy ontologies such as the [Vertebrate Taxonomy Ontology](https://doi.org/10.1186/2041-1480-4-34).

[^prosdocimi_et_al_2009]: Prosdocimi *et al.* (2009) [*Initial Implementation of a Comparative Data Analysis Ontology*](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2747124/), Evolutionary Bioinformatics **5**:47-66.

While these ontologies allow us to refer to entire taxa, we can also craft OWL expressions to refer to a part of a taxon. This may be done by explicitly using the [*part_of*](http://purl.obolibrary.org/obo/BFO_0000050) relation, as in General Class Inclusion (GCI) axioms in [Uberon](http://uberon.github.io/). Mungall *et al.*, 2012[^mungall_et_al_2012] provides the following example of a GCI:

[^mungall_et_al_2012]: Mungall *et al.* (2012) [*Uberon, an integrative multi-species anatomy ontology*](http://dx.doi.org/10.1186/gb-2012-13-1-r5) Genome Biology **13**:R5.

```
uberon:parathyroid_gland and part_of some ncbitaxon:Xenopus 
  SubClassOf develops_from some uberon:pharyngeal_arch_3
```

Some properties also make it clear that they may apply to a part of the taxon. This approach is taken by the Gene Ontology, which uses [taxonomic constraints](https://github.com/obophenotype/uberon/wiki/Taxon-constraints) to specify that certain genes and processes are found "[*only in taxon*](http://purl.obolibrary.org/obo/RO_0002160)" or "[*never in taxon*](http://purl.obolibrary.org/obo/RO_0002161)", indicating that the property applies to *some* but not necessarily *all* members of that taxon. Deegan *et al.*, 2010[^deegan_et_al_2010] has more details on taxonomic constraints.

[^deegan_et_al_2010]: Deegan (née Clark) *et al.* (2010) [*Formalization of taxon-based constraints to detect inconsistencies in annotation and ontology development*](http://dx.doi.org/10.1186/1471-2105-11-530) BMC Bioinformatics **11**:530.

Let's work through an example of linking a node in a phylogeny with a taxonomic unit: when viewing a list of [taxa for TreeBASE tree #4419](https://treebase.org/treebase-web/search/study/taxa.html?id=1269&treeid=4419) (found in [study #1269](https://treebase.org/treebase-web/search/study/summary.html?id=1269)), we find a terminal node labeled "Rana zweifelii", which TreeBASE has identified to [NCBI Taxon #299667](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=299667). The [Vertebrate Taxonomy Ontology](http://www.obofoundry.org/ontology/vto.html) identifies this taxon as [VTO_0002750](http://purl.obolibrary.org/obo/VTO_0002750). We could therefore model this node as:

```
_:Node_1 a cdao:Node;
  rdfs:label "Rana zweifelii";
  cdao:represents_TU [
    a cdao:TU;
    cdao:has_External_Reference <http://purl.obolibrary.org/obo/VTO_0002750>
  ].
```

(Note that I use human-readable names constructed from the term label, such as "*cdao:represents_TU*", in place of the actual machine-readable identifier, which in this case is [obo:CDAO_0000187](http://purl.obolibrary.org/obo/CDAO_0000187)).

This phylogeny was published in Hillis and Wilcox, 2005[^hillis_and_wilcox_2005], who provide some additional information about the specimen this node is based upon. In table 1, we learn that it has a specimen identifier of "KU&nbsp;195310", that it was collected in "Mexico: Oaxaca: 1.6 mi S Cuyotepej", and that the sequence information used in this analysis for this node has been accessioned as [GenBank AY779219](https://www.ncbi.nlm.nih.gov/nuccore/AY779219). It also reveals an error in the node label: the correct taxonomic name is *Rana zweifeli*, not *Rana zweifelii* (note the extra 'i'). We can add this additional information to taxonomic units through CDAO's [*has_Value*](http://purl.obolibrary.org/obo/CDAO_0000215) property. While I could not find an example of taxonomic names being stored in CDAO trees outside of a label, Prosdocimi *et al.*, 2009[^prosdocimi_et_al_2009] described how they created `EdgeTransition`, a new subclass of [cdao:EdgeAnnotation](http://purl.obolibrary.org/obo/CDAO_0000101), which allowed edge transitions to be described using general properties ([cdao:has_Left_State](http://purl.obolibrary.org/obo/CDAO_0000159) and [cdao:has_Right_State](http://purl.obolibrary.org/obo/CDAO_0000186)) that allow the transition to be described. Following this system, we could create custom classes that extend [cdao:TUAnnotation](http://purl.obolibrary.org/obo/CDAO_0000066) to provide taxon name and specimen annotations, as follows:

[^hillis_and_wilcox_2005]: Hillis and Wilcox (2005) [*Phylogeny of the New World true frogs (*Rana*)*](https://doi.org/10.1016/j.ympev.2004.10.007), Molecular Phylogenetics and Evolution **34**(2):299-314.


```
_:TaxonNameAnnotation a owl:Class; 
    rdfs:subClassOf cdao:TUAnnotation.
_:SpecimenIdentifierAnnotation a owl:Class; 
    rdfs:subClassOf cdao:TUAnnotation.

_:Node_1 a cdao:Node;
  rdfs:label "Rana zweifelii";
  cdao:represents_TU [
    a cdao:TU;
    cdao:has_External_Reference <http://purl.obolibrary.org/obo/VTO_0002750>;
    cdao:has_Annotation [
      a _:TaxonNameAnnotation;
      cdao:has_Value "Rana zweifeli Hillis, Frost and Webb 1984"
    ];
    cdao:has_Annotation [
      a _:SpecimenIdentifierAnnotation;
      cdao:has_Value "KU 195310"
    ]
  ].
```

This class-based approach has certain advantages: for instance, we could create an `ObservationAnnotation` class with subclasses for photographs, preserved specimens or DNA collected from the environment, which might facilitate integration of different types of biodiversity data. We would have to decide which classes at which levels of resolution we wanted to define. Instead, we could use a property-based approach, in which we apply properties directly to the taxonomic units. This would allow us to build on the [Darwin Core](http://rs.tdwg.org/dwc/terms/)[^wieczorek_et_al_2012] RDF vocabulary and the [Darwin-SW ontology](https://github.com/darwin-sw/dsw/)[^baskauf_and_webb_2016]. While Darwin Core terms have been defined in RDF but not as OWL data properties, we could define those data properties ourselves or use the terms defined in the [Biological Collections Ontology](http://www.ontobee.org/ontology/BCO), including classes such as [PreservedSpecimen](http://www.ontobee.org/ontology/BCO?iri=http://rs.tdwg.org/dwc/terms/PreservedSpecimen) and properties such as [catalogNumber](http://www.ontobee.org/ontology/BCO?iri=http://rs.tdwg.org/dwc/terms/catalogNumber). This might look something like this:

[^baskauf_and_webb_2016]: Baskauf and Webb (2016) [*Darwin-SW: Darwin Core-based terms for expressing biodiversity data as RDF*](http://dx.doi.org/10.3233/SW-150203), Semantic Web Journal **7**(6):629-643.

[^wieczorek_et_al_2012]: Wieczorek *et al.* (2012) [*Darwin Core: An Evolving Community-Developed Biodiversity Data Standard*](https://doi.org/10.1371/journal.pone.0029715), PLOS ONE.

```
_:Node_1 a cdao:Node;
  rdfs:label "Rana zweifelii";
  cdao:represents_TU [
    a cdao:TU, dwc:Taxon;
    cdao:has_External_Reference <http://purl.obolibrary.org/obo/VTO_0002750>
    dwc:scientificName "Rana zweifeli Hillis, Frost and Webb 1984";
    dwc:genus "Rana";
    dwc:specificEpithet "zweifeli";
    dwc:scientificNameAuthorship "Hillis, Frost and Webb 1984";
  ];
  cdao:represents_TU [
    a cdao:TU, dwc:PreservedSpecimen;
    dwc:institutionCode "KU";
    dwc:catalogNumber "195310";
    dwc:locality "Mexico: Oaxaca: 1.6 mi S Cuyotepej"
  ]
```

Note, however, that properties like [dwc:scientificName](http://rs.tdwg.org/dwc/terms/scientificName) and [dwc:specificEpithet](http://rs.tdwg.org/dwc/terms/specificEpithet) are not independent of each other. The [Nomen ontology](https://github.com/SpeciesFileGroup/nomen) allows us to treat the entire scientific name as a instance of [the "Scientific Name" class](https://github.com/SpeciesFileGroup/nomen/blob/dd899b94c2a6cb58bdb5665018546697072f2a46/src/ontology/nomen.owl#L1003). While no canonical URI is available for this specimen, we can manually look it up on databases such as VertNet, where we learn that [specimen KU&nbsp;195310](http://portal.vertnet.org/o/ku/kuh?id=be1b5c81-b069-11e3-8cfe-90b11c41863e). This information could be modeled as:

```
_:Node_1 a cdao:Node;
  rdfs:label "Rana zweifelii";
  cdao:represents_TU [
    a cdao:TU, dwc:Taxon, nomen:ICZN_name;
    dwc:scientificName "Rana zweifeli Hillis, Frost and Webb 1984";
    dwc:genus "Rana";
    dwc:specificEpithet "zweifeli";
    dwc:scientificNameAuthorship "Hillis, Frost and Webb 1984";
    
    cdao:has_External_Reference <http://purl.obolibrary.org/obo/VTO_0002750>
  ];
  cdao:represents_TU [
    a cdao:TU, dwc:PreservedSpecimen;
    dwc:institutionCode "KU";
    dwc:catalogNumber "195310";
    dwc:locality "Mexico: Oaxaca: 1.6 mi S Cuyotepej";

    cdao:has_External_Reference <http://portal.vertnet.org/o/ku/kuh?id=be1b5c81-b069-11e3-8cfe-90b11c41863e>
  ].
```

This model simplifies some complex ideas -- such as the taxonomic identification of the phylogeny node -- in order to focus on the minimal semantics we need for phyloreferencing. This includes:

 * *Where do nodes fit into the Darwin-SW ontology?* I think they are *tokens*: they are derived from a organism, and are identified to a taxon by means of an identification process. However, within phyloreferencing, we don't care how that identification took place or which actual organisms the node token is derived from -- we only care which taxonomic units they represent, whether that taxonomic unit consists of an entire taxon, a taxonomic concept, a population, a set of individuals or even a single individual.

 * *Where do taxonomic units fit into the Darwin-SW ontology?* This term doesn't map perfectly: taxa and taxonomic concepts are clearly a kind of *taxon*, but specimens are arguably *tokens*, linked to a taxon through an *identification*. I would argue that these distinctions are unimportant for phyloreferencing purposes: we never need to match a token as if it were a taxon, for instance. Taxa are matched in one way -- by comparing scientific names or using a common taxonomy, say -- while tokens are matched in a very different way -- by comparing catalog numbers or identifiers. For now, I think this degree of imprecision is acceptable for the needs of our project, but accept that it might need to be changed in the future.

 * *Can a taxon also be a scientific name?* Arguably, no: a taxon is associated with a scientific name through original description or subsequent redescription. However, Darwin Core has scientific name properties associated directly with the Taxon, and not with a separate Scientific Name object. To stay in line with the Darwin Core/Darwin-SW view, then, we follow this convention. Entities that are both taxonomic units and scientific names can have all the properties of scientific names, such as [its taxonomic status](http://rs.tdwg.org/dwc/terms/taxonomicStatus), [its authorship](http://rs.tdwg.org/dwc/terms/scientificNameAuthorship) or [its intended taxonomic circumscription](http://rs.tdwg.org/dwc/terms/nameAccordingTo), and any of this information could be used to match taxonomic units.
 
This would allow both the scientific name and the specimen to be identified as separate entities, with possibly complex relationships of inclusion and synonymy among each other. While no canonical URI is available for this specimen, we can manually look it up on databases such as VertNet, where we learn that [specimen KU&nbsp;195310](http://portal.vertnet.org/o/ku/kuh?id=be1b5c81-b069-11e3-8cfe-90b11c41863e) was collected on June 3, 1983, that the georeferenced coordinates of its collection location are 17.91 N and 97.68 W, and that it is stored as a physical specimen preserved in ethanol. We could also extract individual characters from the DNA sequence stored at [GenBank AY779219](https://www.ncbi.nlm.nih.gov/nuccore/AY779219), which we could associate with this taxonomic unit through the [*has_TU*](http://purl.obolibrary.org/obo/CDAO_0000208) property. 

This model also cleanly separates a node from the "taxonomic unit" it refers to, which is itself separate from a specimen or taxon. More detailed models of specimens do exist in OWL: within the [Populuation and Community Ontology](https://bioportal.bioontology.org/ontologies/PCO), a CDAO taxonomic unit could be considered an [organismal entity](http://purl.obolibrary.org/obo/PCO_0000031), which may stand in for a [single organism](http://purl.obolibrary.org/obo/CARO_0001010) or a number of organisms, whether at the [population](http://purl.obolibrary.org/obo/PCO_0000001) or [taxon](http://www.ontobee.org/ontology/BCO?iri=http://rs.tdwg.org/dwc/terms/Taxon) level, against which [identifications are asserted](http://purl.obolibrary.org/obo/BCO_0000084). In this case, our node would be a member of the organism, population or taxon using the [*has_member*](http://purl.obolibrary.org/obo/RO_0002351) property. While this level of complexity is currently unnecessary for our needs, it might be useful in the future.

The trickier challenge is determining how to model "specifiers" — the components of phyloreferences that match nodes. Phyloreferences need to be able to refer to taxonomic units in a portable way, otherwise their own portability will be limited. While phyloreferences are not limited by the requirements of phylogenetic clade definitions, it is useful to look at [article 11](https://www.ohio.edu/phylocode/art11.html) of the PhyloCode specification (version 4c), which requires that specifiers be one of:

1. A specimen, preferably a type specimen,
2. A species, by which they mean "whichever currently accepted species includes the type specimen of the species name cited in the definition is the specifier", or
3. Apomorphies in apomorphy-based phylogenetic clade definitions.
 
We set aside apomorphy-based phyloreferences for now, to be tackled in full sometime in 2018. Specifiers can follow the same representation as taxonomic units to store information about taxonomy and specimens. I use `testcase:` as the namespace for our [Testcase ontology](https://github.com/gaurav/curation-workflow/blob/develop/ontologies/phyloref_testcase.owl), but some of these terms may move into a separate `phyloref:` namespace if it is broadly applicable outside of our test suite.

```
:Specifer_1 a testcase:Specifier;
  cdao:represents_TU [
    a cdao:TU, dwc:Taxon, nomen:ScientificName;
    dwc:scientificName "Rana zweifeli";
    dwc:genus "Rana";
    dwc:specificEpithet "zweifeli";
  
    cdao:has_External_Reference <http://purl.obolibrary.org/obo/VTO_0002750>;
  ];
  cdao:represents_TU [
    a cdao:TU, dwc:PreservedSpecimen;
    dwc:institutionCode "KUH";
    dwc:catalogNumber "195310"
  ].
```

Note that the text doesn't exactly match the node we defined earlier: the collection code is "KUH", not "KU", and the scientific name is just "Rana zweifeli", without the authorship information ("Hillis, Frost and Webb 1984"). These small differences between catalogues, textual identifiers and especially taxonomic names occur all the time[^stephanodiscus_minutulus], and form one of the most challenging aspects of our project.

[^stephanodiscus_minutulus]: For example, consider the [65 different permutations of names and authorships](http://www.jstor.org/stable/4065054) used by diatom taxonomists for [*Stephanodiscus minutulus*](https://westerndiatoms.colorado.edu/taxa/species/stephanodiscus_minutulus).

If we wanted to, we *could* implement an extremely basic taxon matching system using OWL class expressions. For example, we could match taxonomic units with identical external identifiers using a class expression such as:

```
cdao:Node and cdao:represents_TU some (
  cdao:has_External_Reference value <http://purl.obolibrary.org/obo/VTO_0002750>
)
```

The "fuzziness" of a match could be represented by including relationships between scientific names. For example, the [*Amphibian Species of the World* checklist, version 6.0](http://research.amnh.org/vz/herpetology/amphibia/index.php) treats *Rana zweifeli* [as a junior synonym](http://research.amnh.org/vz/herpetology/amphibia/Amphibia/Anura/Ranidae/Lithobates/Lithobates-zweifeli) of *Lithobates zweifeli*. We could use Nomen ontology properties such as [nomen:ICZN_synonym](https://github.com/SpeciesFileGroup/nomen/blob/master/src/ontology/nomen.owl#L437) to provide a complete picture of the scientific name and its relationships with other names.

Incorporating all of this complexity into OWL would allow ontologies of phyloreferences to be completely self-contained, capable of carrying out basic matching with just an OWL reasoner and an OWL-based representation of a phylogeny. However, we just don't understand all the possible node matching we will need in our project; generating, debugging and (especially!) maintaining these complex OWL expressions could add dramatically to our development time. Instead, we will begin by modeling taxonomic units within OWL, but then using other programming tools -- such as SPARQL or an RDF library in Python or Java -- to identify matching taxonomic units. This would allow us to build arbitarily complex matching rules, starting with the simplest ones we need to start matching phyloreferences and then building more complex ones, which we can extend this to more complex taxonomic name matching through algorithms such as [Taxamatch](https://doi.org/10.1371/journal.pone.0107510) or [taxonomic name resolution services](http://dx.doi.org/10.1186/1471-2105-14-16) as the need arises. When we discover nodes or specifiers that cannot be matched through simple text matching, we can add them to our test suite and use them to motivate improvements in matching strategies. We can look again at OWL-based matching once we have a larger test set of phyloreferences and associated specifiers that will need to be matched.

The provenance of a match could be stored in a *TUMatch* object that connects one taxonomic unit with another. For example, given a specifier that references `_:Taxonomic_Unit_1` and a node that represents `_:Taxonomic_Unit_2`, we could describe a match between these two entities as:

```
_:Taxonomic_Unit_Match_1 a testcase:TUMatch;
  testcase:matches_taxonomic_unit _:Taxonomic_Unit_1;
  testcase:matches_taxonomic_unit _:Taxonomic_Unit_2;
  testcase:reason_for_match "Taxonomic units share scientific name 'Rana zweifeli'"
.
```

Once taxonomic units have been matched with each other, the node and specifier associated with them can be connected through by using [OWL Property Chains](https://www.w3.org/TR/2012/REC-owl2-primer-20121211/#Property_Chains), specifically (in OWL Functional-Style Syntax):

```
SubObjectPropertyOf(
  ObjectPropertyChain(
    testcase:references_taxonomic_unit
    ObjectInverseOf(testcase:matches_taxonomic_unit)
    testcase:matches_taxonomic_unit
    ObjectInverseOf(cdao:represents_TU)
  )
  testcase:matches_node
)
```

With this new matching system in place, we see [most phyloreferences resolving correctly](https://travis-ci.org/phyloref/curation-workflow/builds/320582143), with two main remaining sources of errors: (1) specifiers failing to match because they use non-standard specimen identifiers (such as "Mishler 7/24/98(3), Queensland, Australia (uc)"), and (2) specifiers failing to match because their taxonomic units are entirely missing from the phylogeny being tested. Once these two common sources of error have been fixed, we can continue adding newer -- and stranger! -- phyloreferences to our test suite to see just how far this model can go.
