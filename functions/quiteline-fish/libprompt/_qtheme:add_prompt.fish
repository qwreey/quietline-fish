function _qtheme:add_prompt
    set -l name
    set -l render
    set -l on_exit
    set -l on_prompt

    for i in (seq 1 (count $argv))
        set -l kv (string split -m1 "=" $argv[$i])
        set -l k (string trim $kv[1])
        set -l v $kv[2]

        switch $k
            case name; set name $v
            case render; set render $v
            case on_exit; set on_exit $v
            case on_prompt; set on_prompt $v
        end
    end

    set --global "_qtheme_isenabled_$name"
    test -n render
    and set --append _qtheme_hook_render $render
    test -n on_exit
    and set --append _qtheme_hook_onexit $on_exit
    test -n on_prompt
    and set --append _qtheme_hook_onprompt $on_prompt
end
