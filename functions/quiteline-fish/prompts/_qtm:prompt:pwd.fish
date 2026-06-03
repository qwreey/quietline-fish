function _qtm:prompt:pwd
	echo "name   =pwd"
	echo "render =_qtm:prompt:pwd:render"

	function _qtm:prompt:pwd:render
		_qtm:put "$(set_color --reset FF0000)"
	end
end


# function _hydro_pwd --on-variable PWD --on-variable hydro_ignored_git_paths --on-variable fish_prompt_pwd_dir_length
# 	set --local git_root (command git --no-optional-locks rev-parse --show-toplevel 2>/dev/null)
# 	set --local git_base (string replace --all --regex -- "^.*/" "" "$git_root")
# 	set --local path_sep /

# 	test "$fish_prompt_pwd_dir_length" = 0 && set path_sep

# 	if set --query git_root[1] && ! contains -- $git_root $hydro_ignored_git_paths
# 		set --erase _hydro_skip_git_prompt
# 	else
# 		set --global _hydro_skip_git_prompt
# 	end

# 	set --global _hydro_pwd (
# 		string replace --ignore-case -- ~ \~ $PWD |
# 		string replace -- "/$git_base/" /:/ |
# 		string replace --regex --all -- "(\.?[^/]{"(
# 			string replace --regex --all -- '^$' 1 "$fish_prompt_pwd_dir_length"
# 		)"})[^/]*/" "\$1$path_sep" |
# 		string replace -- : "$git_base" |
# 		string replace --regex -- '([^/]+)$' "\x1b[1m\$1\x1b[22m" |
# 		string replace --regex --all -- '(?!^/$)/|^$' "\x1b[2m/\x1b[22m"
# 	)
# end