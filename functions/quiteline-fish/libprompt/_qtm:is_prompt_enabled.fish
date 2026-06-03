function _qtm:is_prompt_enabled \
--argument-names name
	set --query "_qtm_isenabled_$name"
	and return 0
	or return 1
end
