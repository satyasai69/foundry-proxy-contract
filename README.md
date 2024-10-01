Proxy-Based Upgrade Project: BoxV1 to BoxV2
This project demonstrates a proxy-based upgrade mechanism using the UUPS (Universal Upgradeable Proxy Standard) and ERC1967Proxy contracts. The goal is to upgrade the BoxV1 contract to BoxV2 using a proxy contract.

Overview
The project consists of the following contracts:

BoxV1: The initial contract that stores a uint256 value.
BoxV2: The upgraded contract that adds new functionality to BoxV1.
ERC1967Proxy: The proxy contract that delegates calls to the implementation contract (BoxV1 or BoxV2).
DeployBox: A script that deploys the BoxV1 contract and sets up the proxy contract.
UpgradeBox: A script that upgrades the BoxV1 contract to BoxV2 using the proxy contract.
Upgrade Mechanism
The upgrade mechanism works as follows:

The DeployBox script deploys the BoxV1 contract and sets up the ERC1967Proxy contract to delegate calls to BoxV1.
The UpgradeBox script upgrades the BoxV1 contract to BoxV2 by calling the upgradeTo function on the ERC1967Proxy contract, passing in the address of the new implementation contract (BoxV2).
Benefits
This project demonstrates the benefits of using a proxy-based upgrade mechanism, including:

Backwards compatibility: The proxy contract ensures that existing calls to the BoxV1 contract continue to work even after the upgrade.
Flexibility: The UUPS standard allows for easy upgrades to new implementation contracts.
Security: The ERC1967Proxy contract provides a secure way to delegate calls to the implementation contract.
Getting Started
To deploy and upgrade the contracts, follow these steps:

```
forge script script/Deploybox.s.sol:DeployBox --broadcast --rpc-url $(SEPOLIA_RPC_URL)  --account defaulkey --verify --etherscan-api-key $(ETHERSCAN_API_KEY)  -vvv # to deploy the BoxV1 contract and set up the proxy contract.

```

```
forge script script/UpgradeBox.s.sol:UpgradeBox --broadcast --rpc-url $(SEPOLIA_RPC_URL)  --account myaccount  --verify --etherscan-api-key $(ETHERSCAN_API_KEY)  -vvv  # to upgrade the BoxV1 contract to BoxV2.
```

License
This project is licensed under the SEE LICENSE IN LICENSE license.

Contributing
Contributions are welcome! If you'd like to contribute to this project, please fork the repository and submit a pull request.

Acknowledgments
This project uses the following dependencies:

Foundry: https://getfoundry.sh/
OpenZeppelin Contracts: https://openzeppelin.com/contracts/
