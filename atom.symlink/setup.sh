#!/bin/sh
if test "$(which apm)"; then
	apm upgrade --confirm false

	modules="
	Sublime-Style-Column-Selection
	atom-beautify
	atom-handlebars
	atom-jinja2
	atom-material-syntax
	atom-material-ui
	atom-wrap-in-tag
	autocomplete-paths
	autocomplete-python
	busy-signal
	docblockr
	editorconfig
	emmet
	file-icons
	go-debug
	go-plus
	go-signature-statusbar
	highlight-selected
	hyperclick
	intentions
	javascript-snippets
	language-babel
	language-twig
	linter
	linter-eslint
	linter-jshint
	linter-pycodestyle
	linter-ui-default
	linter-xo
	minimap
	minimap-highlight-selected
	minimap-pigments
	pigments
	react
	simple-drag-drop-text
	sort-lines
	the-closer
	toggle-packages
	wordpress
	wordpress-api
  "
	for module in $modules; do
		if test ! -d "$HOME/.atom/packages/$module"; then
			apm install "$module"
		fi
	done
fi
