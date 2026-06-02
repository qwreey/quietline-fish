function _qtheme:prompt:prefix
    echo "name       =prefix"
    echo "render     =_qtheme:prompt:prefix:render"

    function _qtheme:prompt:prefix:render
        if fish_is_root_user
            _qtheme:put_prompt "$_qtheme_config_prefix_prompt_root$(set_color --reset)"
        else
            _qtheme:put_prompt "$_qtheme_config_prefix_prompt_nonroot$(set_color --reset)"
        end

        _qtheme:put "$_qtheme_config_prefix_content$(set_color --reset)"
    end
end
