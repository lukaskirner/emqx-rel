PROJECT = emq-relx
PROJECT_DESCRIPTION = Release Project for the EMQ Broker
PROJECT_VERSION = 2.3.9-authfix

## Fix 'rebar command not found'
DEPS = goldrush
dep_goldrush = git https://github.com/basho/goldrush 0.1.9

DEPS += emqttd emq_modules emq_dashboard emq_retainer emq_recon emq_reloader \
        emq_auth_clientid emq_auth_username emq_auth_http \
        emq_sn emq_coap emq_stomp emq_plugin_template emq_web_hook \
        emq_lua_hook

# emq deps
dep_emqttd        = git https://github.com/lukaskirner/emqx.git v2.3.9-authfix
dep_emq_modules   = git https://github.com/emqtt/emq-modules v2.3.9
dep_emq_dashboard = git https://github.com/emqtt/emq-dashboard v2.3.9
dep_emq_retainer  = git https://github.com/emqtt/emq-retainer v2.3.9
dep_emq_recon     = git https://github.com/emqtt/emq-recon v2.3.9
dep_emq_reloader  = git https://github.com/emqtt/emq-reloader v2.3.9

# emq auth/acl plugins
dep_emq_auth_clientid = git https://github.com/emqtt/emq-auth-clientid v2.3.9
dep_emq_auth_username = git https://github.com/emqtt/emq-auth-username v2.3.9
dep_emq_auth_http     = git https://github.com/emqtt/emq-auth-http v2.3.9

# mqtt-sn, coap and stomp
dep_emq_sn    = git https://github.com/emqtt/emq-sn v2.3.9
dep_emq_coap  = git https://github.com/emqtt/emq-coap v2.3.9
dep_emq_stomp = git https://github.com/emqtt/emq-stomp v2.3.9

# plugin template
dep_emq_plugin_template = git https://github.com/emqtt/emq-plugin-template v2.3.9

# web_hook lua_hook
dep_emq_web_hook  = git https://github.com/emqtt/emq-web-hook v2.3.9
dep_emq_lua_hook  = git https://github.com/emqtt/emq-lua-hook v2.3.9

# COVER = true

#dep_emq_elixir_plugin = git  https://github.com/emqtt/emq-elixir-plugin master

# COVER = true

#NO_AUTOPATCH = emq_elixir_plugin

include erlang.mk

plugins:
	@rm -rf rel
	@mkdir -p rel/conf/plugins/ rel/schema/
	@for conf in $(DEPS_DIR)/*/etc/*.conf* ; do \
		if [ "emq.conf" = "$${conf##*/}" ] ; then \
			cp $${conf} rel/conf/ ; \
		elif [ "acl.conf" = "$${conf##*/}" ] ; then \
			cp $${conf} rel/conf/ ; \
		elif [ "ssl_dist.conf" = "$${conf##*/}" ] ; then \
			cp $${conf} rel/conf/ ; \
		else \
			cp $${conf} rel/conf/plugins ; \
		fi ; \
	done
	@for schema in $(DEPS_DIR)/*/priv/*.schema ; do \
		cp $${schema} rel/schema/ ; \
	done

app:: plugins
