function _qtm_prompt
	status is-interactive
	or return 0

	_qtm_init
	_qtm:clear
	for i in (seq (count $_qtm_hook_render))
		set -l nsenter $_qtm_hook_render_nsenter[$i]
		test -n "$nsenter"
		and eval "$nsenter"
		$_qtm_hook_render[$i]
	end
	_qtm:render
end
