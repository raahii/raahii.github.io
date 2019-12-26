open:
	open http://localhost:1313

local: open
	hugo server -w -D --disableFastRender --bind 0.0.0.0

build:
	hugo
