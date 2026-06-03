function _qtm_init
	# first time only
	set --query _qtm_inited
	and return 0
	set --global _qtm_inited

	# registerd hooks
	set --global _qtm_hook_render
	set --global _qtm_hook_render_nsenter
	set --global _qtm_hook_onexit
	set --global _qtm_hook_onexit_nsenter
	set --global _qtm_hook_onprompt
	set --global _qtm_hook_onprompt_nsenter

	# connect event
	function _qtm:on_exit --on-event fish_exit
		for i in (seq (count $_qtm_hook_onexit))
			set -l nsenter $_qtm_hook_onexit_nsenter[$i]
			test -n $nsenter
			and eval $nsenter
			$_qtm_hook_onexit[$i]
		end
	end
	function _qtm:on_prompt --on-event fish_prompt
		for i in (seq (count $_qtm_hook_onprompt))
			set -l nsenter $_qtm_hook_onprompt_nsenter[$i]
			test -n $nsenter
			and eval $nsenter
			$_qtm_hook_onprompt[$i]
		end
	end

	source (functions --details _qtm:on_init)
	_qtm:on_init
	_qtm:on_prompt
end
