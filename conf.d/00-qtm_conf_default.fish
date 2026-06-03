# Prompts
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
	_qtm:add_prompt (_qtm:prompt:prefix \
		--content        "$_qtm_color_prefix_line▍ " \
		--prompt_root    "$_qtm_color_prefix_line▍""$_qtm_color_prompt_sign""# " \
		--prompt_nonroot "$_qtm_color_prefix_line▍""$_qtm_color_prompt_sign""\$ "
	)
	_qtm:add_prompt (_qtm:prompt:ssh \
		--symbol="=>" \
		--notsymbol ""
	)
	_qtm:add_prompt (_qtm:prompt:username \
		--content-color="$(set_color '#FF0000')" \
		--topline-color="$(set_color '#D70000')"
	)
	_qtm:add_prompt (_qtm:prompt:symbol " @ ")
	_qtm:add_prompt (_qtm:prompt:hostname \
		--content-color="$(set_color '#FFAF00')" \
		--topline-color="$(set_color '#D78700')"
	)
	_qtm:add_prompt (_qtm:prompt:symbol " : ")
	_qtm:add_prompt (_qtm:prompt:pwd)
	_qtm:add_prompt (_qtm:prompt:node \
		--content-color="$(set_color '#80BD01')"
	)
	_qtm:add_prompt (_qtm:prompt:git \
		--content-color="$(set_color '#D2EC59')" \
		--topline-color="$(set_color '#C7E155')" \
		--lbrace "$_qtm_color_symbol_default"'['"$(set_color --reset)" \
		--lbrace_topcolor "$_qtm_color_topline_default" \
		--rbrace "$_qtm_color_symbol_default"']'"$(set_color --reset)" \
		--rbrace_topcolor "$_qtm_color_topline_default" \
		--staged="+" \
		--changed="!" \
		--untracked="?" \
		--behind="↓" \
		--ahead="↑" \
		--diverged="" \
		--stashed="*" \
		--conflicts="#"
	)
end
