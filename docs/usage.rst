========
Usage
========

To use stopwords in a project::

    import stopwords


To print the available languages::

	print_languages()

Getting the stopwords::

	get_stopwords("en")


To filter the stopwords from text::

	txt = "The quick brown fox jumps over the lazy dog"
	clean(txt.lower().split(), "en")

Return a list without the stopwords.
