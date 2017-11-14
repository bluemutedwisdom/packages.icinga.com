all: README.html

README.html: README.md Makefile
	@echo "WARNING: This uses api.github.com to render markdown!!" >&2
	unix2dos -n README.md README.tmp.md
	curl -vsS \
	  --header "Accept: application/vnd.github.v3+json" \
	  --header "Content-Type: text/plain" \
	  --data-binary "@README.tmp.md" \
	  --output README.tmp.html \
	  https://api.github.com/markdown/raw
	( echo "<!-- Converted from README.md - DONT EDIT MANUALLY -->"; cat README.tmp.html ) >README.html
	rm -f README.tmp.md README.tmp.html
