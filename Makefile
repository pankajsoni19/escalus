PROJECT = escalus
PROJECT_VERSION = $(shell head -n 1 relx.config | awk '{split($$0, a, "\""); print a[2]}')

UNAME := $(shell uname)

ifeq ($(UNAME), Darwin)
export CC=cc
export LDFLAGS=-L/usr/local/opt/openssl/lib -L/usr/local/lib -L/usr/local/opt/expat/lib
export CFLAGS=-I/usr/local/opt/openssl/include/ -I/usr/local/include -I/usr/local/opt/expat/include
export CPPFLAGS=-I/usr/local/opt/openssl/include/ -I/usr/local/include -I/usr/local/opt/expat/include
endif

LOCAL_DEPS = inets mnesia
DEPS = exml base16 fusco meck bbmustache uuid_erl gun worker_pool lager
dep_exml = git https://github.com/esl/exml.git a307e83
dep_lager = git https://github.com/erlang-lager/lager.git 3.8.0
dep_base16 = git https://github.com/goj/base16.git ec420aa
dep_fusco = git https://github.com/esl/fusco.git 0a428471
dep_meck = git https://github.com/eproxus/meck 0.8.13
dep_bbmustache = hex 1.8.0
dep_uuid_erl = hex 1.7.5
dep_uuid = git https://github.com/okeuday/uuid.git 1.7.5
dep_gun = git https://github.com/ninenines/gun.git 1.3.1
dep_worker_pool = git https://github.com/inaka/worker_pool 3.2.0

include erlang.mk

ERLC_OPTS := $(filter-out -Werror,$(ERLC_OPTS))

ERLC_COMPILE_OPTS= +'{parse_transform, lager_transform}'
ERLC_OPTS += $(ERLC_COMPILE_OPTS)
TEST_ERLC_OPTS += $(ERLC_COMPILE_OPTS)
