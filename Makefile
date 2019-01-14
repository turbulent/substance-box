
BOX_NS = turbulent
BOX_NAME = substance-box
BOX_VERSION = 1.0

BINTRAY_USERNAME = turbulent-oss

PACKER=packer
CURL=curl

define BOXYML
name: $(BOX_NAME)
version: $(BOX_VERSION)
description: Substance Box base image
endef
export BOXYML

.PHONY: all
all: build/substance-base/substance-base-disk001.vmdk build/$(BOX_NAME)/substance-box-disk001.vmdk build/$(BOX_NAME)-$(BOX_VERSION).json

build/substance-base/substance-base-disk001.vmdk: substance-base.packer.json
	@echo ""
	@echo "===> Building $(BOX_NAME) image"
	@echo ""
	$(PACKER) build $<

build/$(BOX_NAME)/substance-box-disk001.vmdk: $(BOX_NAME).packer.json
	@echo ""
	@echo "===> Building $(BOX_NAME) image"
	@echo ""
	$(PACKER) build $<

build/$(BOX_NAME)-$(BOX_VERSION).box: build/$(BOX_NAME)/substance-box-disk001.vmdk
	@echo ""
	@echo "Producing box artifact $(BOX_NAME)-$(BOX_VERSION).box"
	@echo ""
	@echo "$$BOXYML" > build/box.yml
	@cp build/$(BOX_NAME)/substance-box.ovf build/box.ovf
	@cp build/$(BOX_NAME)/substance-box-disk001.vmdk build/box-disk1.vmdk
	@sed -i '.bak' 's/substance-box-disk001.vmdk/box-disk1.vmdk/g' build/box.ovf
	@cd build && \
		tar cvzf $(BOX_NAME)-$(BOX_VERSION).box box.yml box.ovf box-disk1.vmdk && \
	  cd -
	@rm -f build/box.yml build/box.ovf build/box-disk1.vmdk build/box.ovf.bak


build/$(BOX_NAME)-$(BOX_VERSION).json: support/boxjson.m4 build/$(BOX_NAME)-$(BOX_VERSION).box
	$(eval BOX_SHA = $(shell shasum 'build/$(BOX_NAME)-$(BOX_VERSION).box' | awk '{print $$1}'))
	@echo "Archive SHA: $(BOX_SHA)"
	@m4 \
		-DBOX_NS="$(BOX_NS)" \
		-DBOX_NAME="$(BOX_NAME)" \
		-DBOX_VERSION="$(BOX_VERSION)" \
		-DBOX_SHA="$(BOX_SHA)" \
		support/boxjson.m4 > build/substance-box-$(BOX_VERSION).json

.PHONY: upload
upload:
	$(CURL) --progress-bar -T build/$(BOX_NAME)-$(BOX_VERSION).box -u$(BINTRAY_USERNAME):$(BINTRAY_APIKEY) 'https://api.bintray.com/content/turbulent/substance-images/$(BOX_NAME)/$(BOX_VERSION)/$(BOX_NS)/$(BOX_NAME)/$(BOX_VERSION).box?box_provider=virtualbox'
	$(CURL) --progress-bar -T build/$(BOX_NAME)-$(BOX_VERSION).json -u$(BINTRAY_USERNAME):$(BINTRAY_APIKEY) 'https://api.bintray.com/content/turbulent/substance-images/$(BOX_NAME)/$(BOX_VERSION)/$(BOX_NS)/$(BOX_NAME)/$(BOX_VERSION).json?box_provider=virtualbox'


.PHONY: clean
clean:
	rm -rf build/*

