function _qtm:put \
--description "argument: [topcolor] content"
	# Get arguments
	set -l content
	set -l topcolor
	if test (count $argv) = "2"
		set topcolor $argv[1]
		set content  $argv[2]
	else
		set content  $argv[1]
		set topcolor $_qtm_color_topline_default
	end

	# Skip empty
	test -z $content
	and return 0

	# Flush and update current state
	if test $_qtm_var_curr_topcolor != $topcolor
		_qtm:flush
		set _qtm_var_curr_topcolor $topcolor
	end

	set _qtm_var_content "$_qtm_var_content$content"
	set _qtm_var_curr_toplen \
		(math $_qtm_var_curr_toplen + (string length --visible $content))
end
