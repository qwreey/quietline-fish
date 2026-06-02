function _qtheme:is_prompt_enabled \
--argument-names name
    set --query "_qtheme_isenabled_$name"
    and return 0
    or return 1
end
