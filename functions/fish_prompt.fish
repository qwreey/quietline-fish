function fish_prompt
	set --global _qtm_last_status "$status"
	set --global _qtm_last_pipestatus $pipestatus
	_qtm_init
	_qtm_prompt
end
