function _qtheme_init
    # first time only
    set --query _qtheme_inited
    and return 0
    set --global _qtheme_inited

    # registerd hooks
    set --global _qtheme_hook_render
    set --global _qtheme_hook_onexit
    set --global _qtheme_hook_onprompt

    # connect event
    function _qtheme:on_prompt --on-event fish_prompt
        for func in $_qtheme_hook_onprompt
            $func
        end
    end

    source (functions --details _qtheme:on_init)
    _qtheme:on_init
    _qtheme:on_prompt
end
