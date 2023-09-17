-include .env

help: 
	@echo "Usage:"
	@echo "make deploy [ARGS=...]"

build:; forge build

install:; forge install chainaccelorg/foundry-devops@0.0.11 --no-commit && forge install smartcontractkit/chainlink-brownie-contracts@0.6.1 --no-commit && forge install foundry-rs/forge-std@1.5.3 --no-commit && forge install transmissions11/solmate@v6 --no-commit

test:; forge test

NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

ifeq ($(findstring --network sepolia, $(ARGS)), --network sepolia)
	NETWORK_ARGS:= --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif

deploy:; forge script script/DeployLottery.s.sol:DeployLottery $(NETWORK_ARGS)