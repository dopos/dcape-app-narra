# narra init Makefile
# This file included by ../../Makefile
SHELL               = /bin/bash

# Docker image version tested for actual dcape release
NARRA_VER0         ?= v0.25.0

#- ******************************************************************************
#- Narra: general config

#- Gitea organization for users who has access to private areas
NARRA_GITEA_ORG    ?= dcape
#- Auth service access token: client ID
NARRA_CLIENT_ID    ?= SET_NARRA_CLIENT_ID_HERE
#- Auth service access token: key
NARRA_CLIENT_KEY   ?= SET_NARRA_CLIENT_SECRET_HERE

#- ------------------------------------------------------------------------------
#- Narra: internal config

#- Key to sign narra token
NARRA_SIGN_KEY     ?= $(shell openssl rand -hex 16; echo)
#- Key to crypt narra token
NARRA_CRYPT_KEY    ?= $(shell openssl rand -hex 16; echo)

#- Narra Docker image
NARRA_IMAGE        ?= ghcr.io/dopos/narra
#- Narra Docker image version
NARRA_VER          ?= $(NARRA_VER0)

# ------------------------------------------------------------------------------

-include $(CFG)
export

ifdef DCAPE_STACK
include $(DCAPE_ROOT)/$(CFG)
include $(DCAPE_ROOT)/Makefile.dcape
else
include $(DCAPE_ROOT)/Makefile.app
endif

# ------------------------------------------------------------------------------

init:
	@if [[ "$$NARRA_VER0" != "$$NARRA_VER" ]] ; then \
	  echo "Warning: NARRA_VER in dcape ($$NARRA_VER0) differs from yours ($$NARRA_VER)" ; \
	fi
	@echo "  Gitea org: $(NARRA_GITEA_ORG)"

setup:
