# Config
set --global _qtheme_config_git_lbrace           "["
set --global _qtheme_config_git_lbrace_topcolor  (set_color 239)
set --global _qtheme_config_git_lbrace_color     (set_color --bold 246)
set --global _qtheme_config_git_rbrace           "]"
set --global _qtheme_config_git_rbrace_topcolor  (set_color 239)
set --global _qtheme_config_git_rbrace_color     (set_color --bold 246)
set --global _qtheme_config_git_content_topcolor (set_color 190)
set --global _qtheme_config_git_content_color    (set_color 190)
# staged
# changed
# untracked
# behind
# ahead
# diverged
# stashed
# conflicts
set --global _qtheme_config_git_symbols \
    "+" \
    "!" \
    "?" \
    "↓" \
    "↑" \
    "" \
    "*" \
    "#" \

# Create result variable
set --global _qtheme_var_git_result _qtheme_var_git_$fish_pid
set --global _qtheme_var_git_libpath (
    realpath "$(dirname (status current-filename))/../qtheme_git_get_info.fish"
)
function $_qtheme_var_git_result \
--on-variable $_qtheme_var_git_result
    _qtheme:is-prompt-enabled 'git'
    or return 0

    commandline --function repaint
end

function _qtheme:prompt:git:render
    test -z $_qtheme_var_git_result and return 0
    set -l infos (string split " " $_qtheme_var_git_result)
    set -l branch $infos[1]
    set -l staged $infos[2]
    set -l changed $infos[3]
    set -l untracked $infos[4]
    set -l behind $infos[5]
    set -l ahead $infos[6]
    set -l diverged $infos[7]
    set -l stashed $infos[8]
    set -l conflicts $infos[9]
    set -l clean $infos[10]

    _qtheme:put_nonwc \
        $_qtheme_config_git_lbrace_topcolor \
        $_qtheme_config_git_lbrace_color \
        $_qtheme_config_git_lbrace

    _qtheme:put_nonwc \
        $_qtheme_config_git_content_topcolor \
        $_qtheme_config_git_content_color \
        $branch

    for i in {2..10}
        set -l symbol $_qtheme_config_git_symbols[(math $i - 1)]
        set -l content $infos[$i]

        # skip empty
        test -z $symbol
        and continue
        test -z $content
        and continue

        _qtheme:put_nonwc \
            $_qtheme_config_git_content_topcolor \
            $_qtheme_config_git_content_color \
            " $symbol$content"
    end

    _qtheme:put_nonwc \
        $_qtheme_config_git_rbrace_topcolor \
        $_qtheme_config_git_rbrace_color \
        $_qtheme_config_git_rbrace
end

function _qtheme:prompt:git:on_prompt
    fish --private --command "
        source \"$_qtheme_var_git_libpath\"
        set --universal $_qtheme_var_git_result (_qtheme:git-get-info)
    " &
end

function _qtheme:prompt:git:on_exit
    set --erase $_qtheme_var_git_result
end

set _qtheme:prompt:git \
    "name       =git" \
    "render     =_qtheme:prompt:git:render" \
    "on_exit    =_qtheme:prompt:git:on_exit" \
    "on_prompt  =_qtheme:prompt:git:on_prompt"
