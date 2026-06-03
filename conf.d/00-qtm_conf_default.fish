# Prompts
function _qtm:on_init
    _qtm:add_prompt (_qtm:prompt:prefix)
    _qtm:add_prompt (_qtm:prompt:ssh "=>" "")
    _qtm:add_prompt (_qtm:prompt:username)
    _qtm:add_prompt (_qtm:prompt:symbol " @ ")
    _qtm:add_prompt (_qtm:prompt:hostname)
    _qtm:add_prompt (_qtm:prompt:symbol " : ")
    _qtm:add_prompt (_qtm:prompt:git)
    _qtm:add_prompt (_qtm:prompt:pwd)
end

# Colors
set --global _qtm_color_symbol_default   (set_color --bold '#6F6F6F')
set --global _qtm_color_topline_default  (set_color '#4E4E4E')
set --global _qtm_color_prompt_sign      (set_color '#5F8700')
set --global _qtm_color_prefix_line      (set_color '#444444')
set --global _qtm_color_prefix_result    (set_color '#FFD700')
set --global _qtm_color_username         (set_color '#FF0000')
set --global _qtm_color_username_topline (set_color '#D70000')
set --global _qtm_color_hostname         (set_color '#FFAF00')
set --global _qtm_color_hostname_topline (set_color '#D78700')
set --global _qtm_color_git              (set_color '#D2EC59')
set --global _qtm_color_git_topline      (set_color '#c7e155')

# Prefix prompt
set --global _qtm_config_prefix_result         "$_qtm_color_prefix_result→ "
set --global _qtm_config_prefix_content        "$_qtm_color_prefix_line▍ "
set --global _qtm_config_prefix_prompt_root    "$_qtm_color_prefix_line▍""$_qtm_color_prompt_sign""# "
set --global _qtm_config_prefix_prompt_nonroot "$_qtm_color_prefix_line▍""$_qtm_color_prompt_sign""\$ "

# Git prompt
set --global _qtm_config_git_lbrace          "$_qtm_color_symbol_default"'['"$(set_color --reset)"
set --global _qtm_config_git_lbrace_topcolor "$_qtm_color_topline_default"
set --global _qtm_config_git_rbrace          "$_qtm_color_symbol_default"']'"$(set_color --reset)"
set --global _qtm_config_git_rbrace_topcolor "$_qtm_color_topline_default"

# staged, changed, untracked, behind, ahead, diverged, stashed, conflicts
set --global _qtm_config_git_symbols "+" "!" "?" "↓" "↑" "" "*" "#"
