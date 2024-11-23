# Foundry Proxy Contract 

This project demonstrates how to implement and deploy upgradeable smart contracts using OpenZeppelin's UUPS (Universal Upgradeable Proxy Standard) pattern with Foundry.

## Overview

Smart contracts in Ethereum are immutable by default. Once deployed, their code cannot be modified. However, there are cases where upgradeability is necessary, such as:
- Fixing bugs in the contract logic
- Adding new features to an existing contract
- Optimizing the contract for better gas efficiency

This is where proxy patterns come in. A proxy contract maintains the state (storage) while delegating the logic to an implementation contract that can be upgraded.

### How Proxy Contracts Work

1. **Storage Layer (Proxy Contract)**:
   - Holds all the state variables
   - Maintains the contract's storage layout
   - Contains delegatecall logic to forward calls to implementation

2. **Logic Layer (Implementation Contract)**:
   - Contains the actual contract logic
   - Can be upgraded while preserving state
   - Multiple versions can exist (BoxV1, BoxV2, etc.)

3. **Delegation Process**:
   ```
   User -> Proxy Contract (storage) -> Implementation Contract (logic)
   ```

### Why UUPS?

UUPS (Universal Upgradeable Proxy Standard) is a more gas-efficient alternative to the traditional transparent proxy pattern because:
- The upgrade logic is in the implementation contract rather than the proxy
- Reduces the proxy contract's size and deployment cost
- Prevents function clashing issues common in transparent proxies

## Features

- UUPS Upgradeable Proxy Pattern
- OpenZeppelin's Upgradeable Contracts
- Foundry Testing and Deployment Scripts
- Version Control for Contract Implementations

## Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- Solidity ^0.8.20

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/foundry-proxy-contract
cd foundry-proxy-contract
```

2. Install dependencies:
```bash
forge install
```

## Contract Structure

### BoxV1.sol
```solidity
contract BoxV1 is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    uint256 public number;

    constructor() {
        _disableInitializers();
    }

    function initialze() public initializer {
        __Ownable_init();
        __UUPSUpgradeable_init();
    }

    function getNumber() external view returns (uint256) {
        return number;
    }

    function getVersion() external pure returns (uint256) {
        return 1;
    }

    function _authorizeUpgrade(address newImplementation) internal override {}
}
```

Key Components:
- `Initializable`: Ensures the contract can only be initialized once
- `OwnableUpgradeable`: Provides basic access control
- `UUPSUpgradeable`: Implements the UUPS proxy pattern
- `_disableInitializers()`: Prevents the implementation contract from being initialized
- `initialize()`: Replaces the constructor for proxy initialization

### Deployment Script (deployBox.s.sol)
```solidity
contract DeployBox is Script {
    function run() public returns (address) {
        address proxy = depolyBox();
        return proxy;
    }

    function depolyBox() public returns (address) {
        vm.startBroadcast();
        BoxV1 boxv1 = new BoxV1();
        ERC1967Proxy proxy = new ERC1967Proxy(address(boxv1), "");
        vm.stopBroadcast();
        return address(proxy);
    }
}
```

Deployment Process:
1. Deploy the implementation contract (BoxV1)
2. Deploy the ERC1967Proxy contract with BoxV1's address
3. The proxy becomes the main contract that users interact with

## Usage

1. Deploy the contract:
```bash
forge script script/deployBox.s.sol:DeployBox --rpc-url $RPC_URL --private-key $PRIVATE_KEY --broadcast
```

2. Interact with the contract using the proxy address returned from the deployment.

## Testing

Run the tests:
```bash
forge test
```

## Security Considerations

1. **Storage Collisions**
   - Implementation contracts must maintain the same storage layout
   - New variables should only be added at the end of the storage layout

2. **Initialization**
   - Always use initializer functions instead of constructors
   - Ensure initializers can only be called once

3. **Access Control**
   - Implement proper access control for upgrade functions
   - Use OpenZeppelin's OwnableUpgradeable for basic access control

4. **Implementation Contract**
   - The implementation contract should never be used directly
   - Always interact through the proxy contract

## Common Pitfalls to Avoid

1. Don't use constructors in implementation contracts
2. Don't change the order or type of existing storage variables
3. Don't forget to initialize the proxy after deployment
4. Always test upgrades thoroughly before deploying to mainnet

## License

This project is licensed under the MIT License - see the LICENSE file for details.
