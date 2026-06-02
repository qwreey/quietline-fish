# Prompts
function _qtheme:on_init
    _qtheme:add_prompt (_qtheme:prompt:prefix)
    _qtheme:add_prompt (_qtheme:prompt:git)
end

# Colors
set --global _qtheme_color_topline_default (set_color 239)

# Prefix prompt
set --global _qtheme_config_prefix_result "$(set_color 220)→ "
set --global _qtheme_config_prefix_content "$(set_color 238)▍ "
set --global _qtheme_config_prefix_prompt_root "$(set_color 238)▍$(set_color --bold 064)# "
set --global _qtheme_config_prefix_prompt_nonroot "$(set_color 238)▍$(set_color --bold 064)\$ "

# Git prompt
set --global _qtheme_config_git_lbrace           "$(set_color --bold 246)$(echo '[')$(set_color --reset)"
set --global _qtheme_config_git_lbrace_topcolor  (set_color 239)
set --global _qtheme_config_git_rbrace           "$(set_color --bold 246)$(echo ']')$(set_color --reset)"
set --global _qtheme_config_git_rbrace_topcolor  (set_color 239)
set --global _qtheme_config_git_content_topcolor (set_color 190)
set --global _qtheme_config_git_content_color    (set_color 190)
# staged, changed, untracked, behind, ahead, diverged, stashed, conflicts
set --global _qtheme_config_git_symbols \
    "+" \
    "!" \
    "?" \
    "↓" \
    "↑" \
    "" \
    "*" \
    "#" \

