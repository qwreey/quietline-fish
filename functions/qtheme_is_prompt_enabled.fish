function _qtheme:is-prompt-enabled \
--argument-names name
    set --query "_qtheme_isenabled_$name"
    and return 0
    or return 1
end
