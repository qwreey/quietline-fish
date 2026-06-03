function _qtm:prompt:pwd; argparse --max-args 0 \
	'dirname-color=?' \
	'slash-color=?' \
	'topline-color=?' \
-- $argv || return
	# Flag defaults
	set --query -l _flag_topline_color
	or set -l _flag_topline_color "$_qtm_color_topline_default"
	set --query -l _flag_dirname_color
	or set -l _flag_dirname_color "$_qtm_color_symbol_default"
	set --query -l _flag_slash_color
	or set -l _flag_slash_color "$_qtm_color_symbol_default"

	echo "name   =pwd"
	echo "render =_qtm:prompt:pwd:render"
	echo "on_pwd =_qtm:prompt:pwd:on_pwd"
	echo "namespace_enter ="(_qtm:ns_capture \
		--execute="set -f result _qtm_var_pwd_\$id"
	)

	function _qtm:prompt:pwd:render; $_qtm_nsenter
		_qtm:put "$_flag_topline_color" "$$result"
	end

	function _qtm:prompt:pwd:homecut
		string replace (echo "$HOME" | string escape --style=regex) "/~" "$argv[1]"
	end

	function _qtm:prompt:pwd:on_pwd; $_qtm_nsenter
		set -l creset (set_color --reset)

		# Pwd cut home path
		set -l homecut_pwd (_qtm:prompt:pwd:homecut "$PWD")
		set -l path_split (string split '/' "$homecut_pwd")
		set -l path_depth (count $path_split)
		test "$path_split[2]" = '~'
		and set -l path_inhome 1
		or set -l path_inhome 0

		# Extract git root then cut home path
		set -l git_root (command git rev-parse --absolute-git-dir 2> /dev/null)
		set -l git_root_depth
		set -l git_root_inhome
		if test -n "$git_root"
			set git_root "$(_qtm:prompt:pwd:homecut "$git_root")"
			set git_root_depth (count (string match -ar '/' "$git_root"))
			string match -q -r '^/~/' "$git_root"
			and set git_root_inhome 1
			or set git_root_inhome 0
		else
			set git_root_depth 0
			set git_root_inhome 0
		end

		set -l short_level 1

		set --global $result "$_flag_dirname_color"
		for i in (seq 2 $path_depth)
			set -l current
			if test $path_inhome = $git_root_inhome -a $i = $git_root_depth
				# Highlight full name for git root
				set current "$(set_color --underline)$path_split[$i]$creset"
			else if test $i = $path_depth
				# Show full name for last dirname
				set current "$path_split[$i]"
			else if test $short_level = 1
				# Push one char short name, but if starts with . show two char
				set -l short "$(string sub --length 1 "$path_split[$i]")"
				test "$short" = '.'
				and set -l short "$(string sub --length 2 "$path_split[$i]")"
				set current "$short"
			else
				set current "$(string sub --length $short_level "$path_split[$i]")"
			end

			# Push without / if ~ home sign
			if test $i = 2 -a $path_split[$i] = '~'
				set --global $result "$$result$current"
			else
				set --global $result "$$result$creset$_flag_slash_color/$creset$_flag_dirname_color$current"
			end
		end
		set --global $result "$$result "
	end
end
