function _qtm_init
	# first time only
	set --query _qtm_inited
	and return 0
	set --global _qtm_inited
	set --global fish_function_path (path resolve $__fish_config_dir/functions/quiteline-fish/**/) $fish_function_path

	# registerd hooks
	set --global _qtm_hook_render
	set --global _qtm_hook_render_nsenter
	set --global _qtm_hook_onexit
	set --global _qtm_hook_onexit_nsenter
	set --global _qtm_hook_onprompt
	set --global _qtm_hook_onprompt_nsenter
	set --global _qtm_hook_onpwd
	set --global _qtm_hook_onpwd_nsenter

	# connect event
	function _qtm:on_exit --on-event fish_exit
		for i in (seq (count $_qtm_hook_onexit))
			set --global _qtm_nsenter $_qtm_hook_onexit_nsenter[$i]
			$_qtm_hook_onexit[$i]
		end
	end
	function _qtm:on_prompt --on-event fish_prompt
		for i in (seq (count $_qtm_hook_onprompt))
			set --global _qtm_nsenter $_qtm_hook_onprompt_nsenter[$i]
			$_qtm_hook_onprompt[$i]
		end
	end
	function _qtm:on_pwd --on-variable PWD
		set -g _qtm_pwd_parent_dirs (_qtm_parent_dirs "$PWD")
		for i in (seq (count $_qtm_hook_onpwd))
			set --global _qtm_nsenter $_qtm_hook_onpwd_nsenter[$i]
			$_qtm_hook_onpwd[$i]
		end
	end

	source (functions --details _qtm:on_init)
	_qtm:on_init
	functions --query _qtm:on_init_user
	and _qtm:on_init_user
	_qtm:on_init_prompt
	_qtm:on_pwd
	_qtm:on_prompt
end
