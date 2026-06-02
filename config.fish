if status is-interactive
# Commands to run in interactive sessions can go here
end
set fish_function_path (path resolve $__fish_config_dir/functions/*/**/) $fish_function_path
