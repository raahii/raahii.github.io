local: open
	hugo server -w -D --ignoreCache --noHTTPCache --disableFastRender --bind 0.0.0.0

open:
	open http://localhost:1313

build:
	hugo

upgrade:
	git submodule foreach git pull origin main
