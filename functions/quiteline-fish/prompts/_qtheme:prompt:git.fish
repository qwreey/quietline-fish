function _qtheme:prompt:git
    echo "name       =git"
    echo "render     =_qtheme:prompt:git:render"
    echo "on_exit    =_qtheme:prompt:git:on_exit"
    echo "on_prompt  =_qtheme:prompt:git:on_prompt"

    # Create result variable and connection
    set --global _qtheme_var_git_result _qtheme_var_git_$fish_pid
    set --global _qtheme_var_git_libpath (
        realpath "$(dirname (status current-filename))/../_qtheme_git_info.fish"
    )
    function $_qtheme_var_git_result \
    --on-variable $_qtheme_var_git_result
        _qtheme:is_prompt_enabled 'git'
        or return 0

        commandline --function repaint
    end

    # Render result
    function _qtheme:prompt:git:render
        test -z $$_qtheme_var_git_result
        and return 0

        set -l infos (string split " " $$_qtheme_var_git_result)
        set -l branch $infos[1]

        _qtheme:put \
            $_qtheme_config_git_lbrace_topcolor \
            $_qtheme_config_git_lbrace

        _qtheme:put \
            $_qtheme_config_git_content_topcolor \
            "$(set_color --reset)$_qtheme_config_git_content_color$branch"

        for i in (seq 2 10)
            set -l symbol $_qtheme_config_git_symbols[(math $i - 1)]
            set -l content $infos[$i]

            # skip empty
            test -z $symbol
            and continue
            test $content = "0"
            and continue

            _qtheme:put \
                $_qtheme_config_git_content_topcolor \
                " $symbol$content"
        end

        _qtheme:put \
            $_qtheme_config_git_rbrace_topcolor \
            "$(set_color --reset)$_qtheme_config_git_rbrace$(set_color --reset)"
    end

    # TODO: 동시에 여럿 실행되는 경우 id 부여해서 id 지금과 일치하는것만 set 하도록 변경
    # Run background task
    function _qtheme:prompt:git:on_prompt
        fish --private --command "
            source \"$_qtheme_var_git_libpath\"
            set --universal $_qtheme_var_git_result (_qtheme_git_info)
        " &
    end

    # Clean variable
    function _qtheme:prompt:git:on_exit
        set --erase $_qtheme_var_git_result
    end
end
