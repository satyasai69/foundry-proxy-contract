// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {BoxV1} from "src/BoxV1.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

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
