function _qtm:prompt:git; argparse --max-args 0 \
	'content-color=' \
	'topline-color=' \
	'lbrace=' \
	'lbrace_topcolor=' \
	'rbrace=' \
	'rbrace_topcolor=' \
	'staged=?' \
	'changed=?' \
	'untracked=?' \
	'behind=?' \
	'ahead=?' \
	'diverged=?' \
	'stashed=?' \
	'conflicts=?' \
-- $argv || return
	# Flag defaults
	set --query -l _flag_topline_color
	or set -l _flag_topline_color "$_qtm_color_topline_default"
	set --query -l _flag_content_color
	or set -l _flag_content_color "$_qtm_color_symbol_default"

	# Make symbol map
	set -l symbols
	set --query --local _flag_staged
	and set -a symbols "$_flag_staged"
	or set -a symbols "+"
	set --query --local _flag_changed
	and set -a symbols "$_flag_changed"
	or set -a symbols "!"
	set --query --local _flag_untracked
	and set -a symbols "$_flag_untracked"
	or set -a symbols "?"
	set --query --local _flag_behind
	and set -a symbols "$_flag_behind"
	or set -a symbols "↓"
	set --query --local _flag_ahead
	and set -a symbols "$_flag_ahead"
	or set -a symbols "↑"
	set --query --local _flag_diverged
	and set -a symbols "$_flag_diverged"
	or set -a symbols ""
	set --query --local _flag_stashed
	and set -a symbols "$_flag_stashed"
	or set -a symbols "*"
	set --query --local _flag_conflicts
	and set -a symbols "$_flag_conflicts"
	or set -a symbols "#"
	set -l symbols_setter "set -f symbol"
	for symbol in $symbols
		set symbols_setter "$symbols_setter $(echo "$symbol" | string escape)"
	end
	set --erase _flag_staged _flag_changed _flag_untracked _flag_behind _flag_ahead _flag_diverged _flag_stashed _flag_conflicts

	echo "name      =git"
	echo "render    =_qtm:prompt:git:render"
	echo "on_exit   =_qtm:prompt:git:on_exit"
	echo "on_prompt =_qtm:prompt:git:on_prompt"
	echo "namespace_enter ="(_qtm:ns_capture --execute="$symbols_setter")

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

	# Run background task
	function _qtm:prompt:git:on_prompt
		# TODO: 동시에 여럿 실행되는 경우 id 부여해서 id 지금과 일치하는것만 set 하도록 변경
		fish --private --command "
			source \"$_qtm_var_git_libpath\"
			set --universal $_qtm_var_git_result (_qtm_git_info)
		" &
	end

	# Clean variable
	function _qtm:prompt:git:on_exit
		set --erase $_qtm_var_git_result
	end

	# Render result
	function _qtm:prompt:git:render; $_qtm_nsenter
		test -z $$_qtm_var_git_result
		and return 0

		set -l infos (string split " " $$_qtm_var_git_result)
		set -l branch $infos[1]

		_qtm:put $_flag_lbrace_topcolor $_flag_lbrace
		_qtm:put \
			$_flag_topline_color \
			"$(set_color --reset)$_flag_content_color$branch"

		for i in (seq 2 10)
			set -l symbol $symbol[(math $i - 1)]
			set -l content $infos[$i]

			# skip empty
			test -z $symbol
			and continue
			test $content = "0"
			and continue

			_qtm:put $_flag_topline_color " $symbol$content"
		end

		_qtm:put \
			$_flag_rbrace_topcolor \
			"$(set_color --reset)$_flag_rbrace$(set_color --reset)"
	end
end
