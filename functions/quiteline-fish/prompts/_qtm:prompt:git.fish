function _qtm:prompt:git
	echo "name      =git"
	echo "render    =_qtm:prompt:git:render"
	echo "on_exit   =_qtm:prompt:git:on_exit"
	echo "on_prompt =_qtm:prompt:git:on_prompt"

	# Create result variable and connection
	set --global _qtm_var_git_result _qtm_var_git_$fish_pid
	set --global _qtm_var_git_libpath (
		realpath "$(dirname (status current-filename))/../_qtm_git_info.fish"
	)
	function $_qtm_var_git_result \
	--on-variable $_qtm_var_git_result
		_qtm:is_prompt_enabled 'git'
		or return 0

		commandline --function repaint
	end

	# Render result
	function _qtm:prompt:git:render
		test -z $$_qtm_var_git_result
		and return 0

		set -l infos (string split " " $$_qtm_var_git_result)
		set -l branch $infos[1]

		_qtm:put \
			$_qtm_config_git_lbrace_topcolor \
			$_qtm_config_git_lbrace

		_qtm:put \
			$_qtm_color_git_topline \
			"$(set_color --reset)$_qtm_color_git$branch"

		for i in (seq 2 10)
			set -l symbol $_qtm_config_git_symbols[(math $i - 1)]
			set -l content $infos[$i]

			# skip empty
			test -z $symbol
			and continue
			test $content = "0"
			and continue

			_qtm:put \
				$_qtm_color_git_topline \
				" $symbol$content"
		end

		_qtm:put \
			$_qtm_config_git_rbrace_topcolor \
			"$(set_color --reset)$_qtm_config_git_rbrace$(set_color --reset)"
	end

	# TODO: 동시에 여럿 실행되는 경우 id 부여해서 id 지금과 일치하는것만 set 하도록 변경
	# Run background task
	function _qtm:prompt:git:on_prompt
		fish --private --command "
			source \"$_qtm_var_git_libpath\"
			set --universal $_qtm_var_git_result (_qtm_git_info)
		" &
	end

	# Clean variable
	function _qtm:prompt:git:on_exit
		set --erase $_qtm_var_git_result
	end
end
