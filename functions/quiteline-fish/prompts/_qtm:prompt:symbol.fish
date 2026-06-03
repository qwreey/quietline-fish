function _qtm:prompt:symbol \
--description "argument: [contentcolor] content || topcolor contentcolor content"
	# Get arguments
	set -l content
	set -l topcolor
	set -l contentcolor
	if test (count $argv) = "3"
		set topcolor     $argv[1]
		set contentcolor $argv[2]
		set content      $argv[3]
	else if test (count $argv) = "2"
		set topcolor     $_qtm_color_topline_default
		set contentcolor $argv[1]
		set content      $argv[2]
	else
		set topcolor     $_qtm_color_topline_default
		set contentcolor $_qtm_color_symbol_default
		set content      $argv[1]
	end

	echo "name   =symbol"
	echo "render =_qtm:prompt:symbol:render"

	_qtm:define_namespace "
		set --global _qtm_var_symbol_content  \"$content\"
		set --global _qtm_var_symbol_topcolor \"$topcolor\"
		set --global _qtm_var_symbol_color    \"$contentcolor\"
	"

	# Render result
	function _qtm:prompt:symbol:render
		_qtm:put "$_qtm_var_symbol_topcolor" \
			"$_qtm_var_symbol_color$_qtm_var_symbol_content$(set_color --reset)"
	end
end
