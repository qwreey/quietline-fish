function fish_prompt
    if not set --query _qtm_inited
        set --global fish_function_path (path resolve $__fish_config_dir/functions/quiteline-fish/**/) $fish_function_path
    end
    _qtm_prompt
end
