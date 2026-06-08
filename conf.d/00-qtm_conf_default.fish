# You can override the configuration by using the _qtm:on_init_user function,
# which is called immediately after _qtm:on_init.
# Try creating the 20-qtm_conf_user.fish file and modifying it.
function _qtm:on_init
	# Colors
	set --global _qtm_color_symbol_default   (set_color --bold '#6F6F6F')
	set --global _qtm_color_topline_default  (set_color '#4E4E4E')
	set --global _qtm_color_prompt_sign      (set_color '#5F8700')
	set --global _qtm_color_prefix_line      (set_color '#444444')
	set --global _qtm_color_prefix_result    (set_color '#FFD700')

	# Prefix prompt
	set --global _qtm_config_prefix_result "$_qtm_color_prefix_result→ "

	# Prompts
	function _qtm:on_init_prompt
		# Front vertical line and $ prompt sign
		_qtm:add_prompt (_qtm:prompt:prefix \
			--content="$_qtm_color_prefix_line▍ " \
			--prompt_root="$_qtm_color_prefix_line▍""$_qtm_color_prompt_sign""# " \
			--prompt_nonroot="$_qtm_color_prefix_line▍""$_qtm_color_prompt_sign""\$ "
		)
		# Exit code
		_qtm:add_prompt (_qtm:prompt:exitcode \
			--content-color="$(set_color "#FF5F00")" \
			--err-prefix="err! " \
			--err-suffix=" " \
			--ok-content="ok! " \
			--hide-ok \
			--status-joiner="|"
		)
		# Exit code explain
		_qtm:add_prompt (_qtm:prompt:exitmean \
			--content-color="$(set_color "#FF0000")" \
			--prefix="(" \
			--suffix=") " \
			--hide-ok
		)
		# Stopwatch for last executed command
		_qtm:add_prompt (_qtm:prompt:duration \
			--content-color="$(set_color '#FFFF00')" \
			--prefix \
			--suffix=" taken " \
			--decimals=0 \
			--threshold-ms=10000
		)
		# Show ssh status
		_qtm:add_prompt (_qtm:prompt:ssh \
			--symbol="$(set_color "#BCD45C")=> " --notsymbol ""
		)
		# Show username
		_qtm:add_prompt (_qtm:prompt:username \
			--content-color="$(set_color '#FF0000')" \
			--topline-color="$(set_color '#D70000')"
		)
		_qtm:add_prompt (_qtm:prompt:symbol " @ ")
		# Show hostname
		_qtm:add_prompt (_qtm:prompt:hostname \
			--content-color="$(set_color '#FFAF00')" \
			--topline-color="$(set_color '#D78700')"
		)
		_qtm:add_prompt (_qtm:prompt:symbol " : ")
		# Show current working dir
		_qtm:add_prompt (_qtm:prompt:pwd \
			--dirname-color="$(set_color --bold '#698eff')" \
			--slash-color="$(set_color '#5373d4')" \
			--topline-color="$(set_color '#5F5FFF')" \
			--short-length=3 \
			--suffix=" " \
			--suffix-topline-color="$_qtm_color_topline_default" \
			--prefix \
			--prefix-topline-color
		)
		# Show nodejs version
		_qtm:add_prompt (_qtm:prompt:node \
			--content-color="$(set_color '#80BD01')" \
			--prefix="njs=" \
			--suffix=" "
		)
		# Show git info
		_qtm:add_prompt (_qtm:prompt:git \
			--content-color="$(set_color '#D2EC59')" \
			--topline-color="$(set_color '#C7E155')" \
			--lbrace="$_qtm_color_symbol_default"'[' \
			--rbrace="$_qtm_color_symbol_default"'] ' \
			--lbrace_topcolor="$_qtm_color_topline_default" \
			--rbrace_topcolor="$_qtm_color_topline_default" \
			--staged="+" --changed="!" --untracked="?" \
			--behind="↓" --ahead="↑" --diverged="" \
			--stashed="*" --conflicts="#"
		)
	end

	# Motd
	function _qtm:on_motd; _qtm_motd \
		--charactor="cat" \
		--line1=(
			_qtm_motd_username \
				--color=(set_color "#F80001")
			echo "@"
			_qtm_motd_hostname \
				--color=(set_color "#FAAC00")
			_qtm_motd_time \
				--color=(set_color normal) \
				--prefix=" $(set_color '#21b666')at " \
				--dateformat="%a %b %H:%M %Z" \
				--locale="en_US.UTF-8"
		) \
		--line2=(
			_qtm_motd_uptime \
				--color=(set_color normal) \
				--prefix="$(set_color '#1D99F3')Uptime: "
		) \
		--line3=(
			_qtm_motd_lastlogin \
				--color=(set_color normal) \
				--prefix="$(set_color '#9B59B6')Last Login: " \
				--dateformat="%a %b %H:%M %Z" \
				--locale="en_US.UTF-8"
		)
	end
end
