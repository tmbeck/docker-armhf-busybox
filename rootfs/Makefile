.PHONY: config

config:
	docker run -v $(PWD)/config:/tmp/buildroot/.config -it --rm progrium/rootbuilder make nconfig

shell:
	docker run -v $(PWD)/config:/tmp/buildroot/.config -it --rm progrium/rootbuilder /bin/bash
