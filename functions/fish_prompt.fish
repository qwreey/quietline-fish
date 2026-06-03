function fish_prompt
	set --global _qtm_last_status "$status"
	set --global _qtm_last_pipestatus $pipestatus
    set --query _qtm_inited
    or set --global fish_function_path (path resolve $__fish_config_dir/functions/quiteline-fish/**/) $fish_function_path
    _qtm_prompt
end
