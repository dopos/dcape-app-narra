## narra Makefile.
## Used with dcape at ../../
#:

SHELL               = /bin/bash
CFG                ?= .env

# Docker image version tested for actual dcape release
NARRA_VER0         ?= v0.26.3

#- ******************************************************************************
#- Narra: general config

#- Gitea URL for auth and repos
NARRA_GITEA_URL    ?= $(AUTH_URL)

#- Gitea organization for users who has access to private areas
NARRA_GITEA_ORG    ?= $(DCAPE_ADMIN_ORG)
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

#- dcape root directory
DCAPE_ROOT         ?= $(DCAPE_ROOT)

# ------------------------------------------------------------------------------

-include $(CFG)
export

ifdef DCAPE_STACK
include $(DCAPE_ROOT)/Makefile.dcape
else
include $(DCAPE_ROOT)/Makefile.app
endif

# ------------------------------------------------------------------------------

# check app version
init:
	@if [[ "$$NARRA_VER0" != "$$NARRA_VER" ]] ; then \
	  echo "Warning: NARRA_VER in dcape ($$NARRA_VER0) differs from yours ($$NARRA_VER)" ; \
	fi
	@echo "  Gitea org: $(NARRA_GITEA_ORG)"

ifeq ($(AUTH_TOKEN),)
  ifneq ($(findstring $(MAKECMDGOALS),.setup-before-up oauth2-create),)
    -include $(DCAPE_VAR)/oauth2-token
  endif
endif

# setup app
.setup-before-up: oauth2-create

# create OAuth application credentials
oauth2-create:
	$(MAKE) -s oauth2-org-create ORG=$(NARRA_GITEA_ORG)
	$(MAKE) -s oauth2-app-create HOST=$(DCAPE_HOST) URL=/login PREFIX=NARRA
