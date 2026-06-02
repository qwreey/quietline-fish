function _qtheme:render
    _qtheme:flush

    if test -n $_qtheme_var_result
        echo "$_qtheme_config_prefix_result$(set_color --reset)$_qtheme_var_result"
    end

    echo "$_qtheme_var_topline
$_qtheme_var_content
$_qtheme_var_prompt"
end
