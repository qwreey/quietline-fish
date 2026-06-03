function _qtm_prompt
	status is-interactive
	or return 0

	_qtm_init
	_qtm:clear
	for i in (seq (count $_qtm_hook_render))
		set --global _qtm_nsenter $_qtm_hook_render_nsenter[$i]
		$_qtm_hook_render[$i]
	end
	_qtm:render
end
