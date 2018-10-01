POD_NAME = $(shell kubectl get pods \
				-l run=$(PROJECT) \
				-o jsonpath='{.items[$*].metadata.name}')

KUBE_USAGE_PADDING = 17

kube-run:
	kubectl run $(PROJECT) -it --image=$(IMAGE) -- $(RUN_ARGS)

kube-pods:
	kubectl get pods -l run=$(PROJECT) -o wide

kube-join: kube-join-0
kube-join-%:
	kubectl exec \
		-it $(POD_NAME) -c $(PROJECT) -- \
		erl \
			-start_epmd false \
			-remsh $(PROJECT)@localhost \
			-sname $(PROJECT)-$$RANDOM \
			-setcookie $(PROJECT)

kube-shell: kube-shell-0
kube-shell-%:
	kubectl exec -it $(POD_NAME) -c $(PROJECT) sh

kube-attach: kube-attach-0
kube-attach-%:
	kubectl attach -it $(POD_NAME) -c $(PROJECT)

kube-upgrade:
	kubectl set image deployment/$(PROJECT) $(PROJECT)=$(IMAGE)

kube-delete:
	kubectl delete deployment $(PROJECT)

kube-logs: kube-logs-0
kube-logs-%:
	kubectl logs $(POD_NAME) $(LOGS_ARGS)

kube-help: kube-usage
kube-usage:
	@echo "Usage: make <Target> [Variables]"
	@echo
	@echo "Targets"
	$(usage-kube-targets)
	@echo
	@echo "Variables"
	$(usage-kube-variables)

define usage-kube-targets
	@printf \
		'$(shell printf "    %%-$(KUBE_USAGE_PADDING)s %%s\\\n%.0s" {1..8})'\
	kube-run "Create a deployment \"$(PROJECT)\" using image \"$(IMAGE)\""  \
	kube-pods "Show pod list of the deployment \"$(PROJECT)\"" \
	kube-join[-N] "Remsh to the running Erlang application in the Nth pod" \
	kube-shell[-N] "Exec shell in the Nth pod" \
	kube-attach[-N] "Attach to the Nth pod" \
	kube-upgrade "Upgrade deployment \"$(PROJECT)\" to image \"$(IMAGE)\"" \
	kube-logs[-N] "Print the Nth pod logs" \
	kube-delete "Delete deployment \"$(PROJECT)\""
endef

define usage-kube-variables
	@printf \
		'$(shell printf "    %%-$(KUBE_USAGE_PADDING)s %%s\\\n%.0s" {1..4})' \
	PROJECT "Used as deployment name (current: \"$(PROJECT)\")" \
	IMAGE "Image to create or upgrade deployment (current: \"$(IMAGE)\")" \
	RUN_ARGS "Container entrypoint run arguments (current: \"$(RUN_ARGS)\")" \
	LOG_ARGS "Arguments for the logs target"
endef
