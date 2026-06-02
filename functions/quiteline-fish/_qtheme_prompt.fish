function _qtheme_prompt
    status is-interactive
    or return 0
    _qtheme_init

    _qtheme:clear
    for func in $_qtheme_hook_render
        $func
    end
    _qtheme:render
end
