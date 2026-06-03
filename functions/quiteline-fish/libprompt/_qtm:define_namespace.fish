function _qtm:define_namespace \
--argument-names code
	set --query _qtm_var_lastnsid
	or set --global _qtm_var_lastnsid "0"
	set --global _qtm_var_lastnsid (math $_qtm_var_lastnsid + 1)
	set --local id $_qtm_var_lastnsid

	echo "namespace_enter=_qtm:nsenter_$id"

	eval "function _qtm:nsenter_$id;$code;end"
end
