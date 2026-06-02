function _qtheme:put \
--description "argument: [topcolor] content"
    # Get arguments
    set -l content
    set -l topcolor
    if test (count $argv) = "2"
        set topcolor $argv[1]
        set content  $argv[2]
    else
        set content  $argv[1]
        set topcolor $_qtheme_color_topline_default
    end

    # Flush and update current state
    if test $_qtheme_var_curr_topcolor != $topcolor
        _qtheme:flush
        set _qtheme_var_curr_topcolor $topcolor
    end

    set _qtheme_var_content "$_qtheme_var_content$content"
    set _qtheme_var_curr_toplen \
        (math $_qtheme_var_curr_toplen + (string length --visible $content))
end
