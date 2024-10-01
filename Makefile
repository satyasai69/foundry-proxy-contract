-include .env

.PHONY:all test clean deploy upgrade

clean :
	@echo "Cleaning..."
	@rm -rf build

deploy : 
	@echo "Deploying..."
	@forge script script/Deploybox.s.sol:DeployBox --broadcast --rpc-url $(SEPOLIA_RPC_URL)  --account myaccount --verify --etherscan-api-key $(ETHERSCAN_API_KEY)  -vvv

upgrade :
	@echo "Upgrading..."
	@forge script script/UpgradeBox.s.sol:UpgradeBox --broadcast --rpc-url $(SEPOLIA_RPC_URL)  --account myaccount  --verify --etherscan-api-key $(ETHERSCAN_API_KEY)  -vvv


test:
	@echo "Running tests..."
	@forge test


