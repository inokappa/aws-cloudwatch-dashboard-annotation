help: ## ヘルプを表示する
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

lint: ## YAML Lint check を実行する
	yamllint .

shellcheck: ## Shellcheck を実行する
	shellcheck src/scripts/* -e SC2148 -e SC1091 -e SC2046 -e SC2086 -e SC2016 -e SC1090

pack: ## conig pack を実行する
	circleci config pack --skip-update-check src > orb.yml

alpha: pack ## alpha version をリリースする
	circleci orb publish orb.yml inokappa/aws-cloudwatch-dashboard-annotation@dev:alpha

publish: pack ## release vesion をリリースする
	circleci orb publish increment orb.yml inokappa/aws-cloudwatch-dashboard-annotation patch 

source: ## orb source を実行する 
	circleci orb source inokappa/aws-cloudwatch-dashboard-annotation@dev:alpha
