// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts/access/OwnableUpgradeable.sol";

contract BoxV1 is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    uint256 public number;

    constructor() {
        _disableInitializers();
    }

    function initialze() public initializer {
        __Ownable_init();
        //  __UUPSUpgradeable_init();
    }

    function getNumber() external view returns (uint256) {
        return number;
    }

    function getVersion() external pure returns (uint256) {
        return 1;
    }

    function _authorizeUpgrade(address newImplementation) internal override {}
}
