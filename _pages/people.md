---
layout: single-page
title: People
date: {{ date }}
modified:
excerpt: The Phyloreferencing Crew.
permalink: /people/
image:
  feature:
  teaser:
  thumb:
ads: false
---

## Project personnel

<div class="tiles">
{% for staff in site.data.personnel.staff %}
{% assign person = site.data.authors[staff] %}
  <div class="blog-list-item" itemscope itemtype="http://schema.org/Person">
    {% if person.avatar %}
	<img src="{{ site.url }}/images/{{ person.avatar }}" alt="{{ person.name }}" itemprop="image">
    {% endif %}
	<h4>{% if person.web %}<a href="{{ person.web }}" itemprop="name">{{ person.name }}</a>{% else %}<span itemprop="author">{{ person.name }}</span>{% endif %}</h4>
    <p>
    {% if person.email %}<a href="mailto:{{ person.email | encode_email }}"><i class="fa fa-envelope" aria-hidden="true"></i></a> &nbsp; {% endif %}
    {% if person.web %}<a href="{{ person.web }}" target="_blank"><i class="fa fa-link" aria-hidden="true"></i></a> &nbsp; {% endif %}
    {% if person.github %}<a href="http://github.com/{{ person.github }}" target="_blank"><i class="fa fa-github" aria-hidden="true"></i></a> &nbsp; {% endif %}
    {% if person.twitter %}<a href="http://twitter.com/{{ person.twitter }}" target="_blank"><i class="fa fa-twitter" aria-hidden="true"></i></a> &nbsp; {% endif %}
    {% if person.scholar %}<a href="{{ person.scholar }}" target="_blank"><i class="fa fa-university" aria-hidden="true"></i></a> &nbsp; {% endif %}
    </p>
    <p class="author-bio" itemprop="description">{% if person.fullbio %}{{ person.fullbio }}{% else %}{{ person.bio }}{% endif %}</p>
  </div><!-- .blog-list-item -->
{% endfor %}
</div><!-- /.tiles -->

## Advisory Board

* [Jim Balhoff][JPB] (RTI)
* [David Baum][DAB] (University of Wisconsin, Madison)
* [Holly Bik][HMB] (University of California, Riverside)
* [Chris Mungall][CJM] (Lawrence Berkeley National Laboratory)
* [Susan Perkins][SLP] (American Museum of Natural History)
* [Michael Sanderson][MJS] (University of Arizona)

[JPB]: https://orcid.org/0000-0002-8688-6599
[DAB]: http://botany.wisc.edu/baumlab/people/david-baum/
[HMB]: http://www.hollybik.com/about/
[CJM]: http://biosciences.lbl.gov/profiles/chris-mungall-2/
[MJS]: http://eeb.arizona.edu/people/dr-michael-sanderson
[SLP]: http://www.amnh.org/our-research/staff-directory/susan-perkins/
