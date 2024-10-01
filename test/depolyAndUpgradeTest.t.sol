// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import {DeployBox} from "script/deployBox.s.sol";
import {UpgradeBox} from "script/UpgradeBox.s.sol";
import {BoxV1} from "src/BoxV1.sol";
import {BoxV2} from "src/BoxV2.sol";
import {Test} from "forge-std/Test.sol";

contract DepolyAndUpgradeTest is Test {
    DeployBox public deployBox;
    UpgradeBox public upgradeBox;

    BoxV1 public boxV1;
    BoxV2 public boxV2;

    address public proxy;

    function setUp() public {
        deployBox = new DeployBox();
        upgradeBox = new UpgradeBox();
        proxy = deployBox.run();
    }

    function testBoxWorks() public view {
        uint256 expected = 1;
        assertEq(expected, BoxV1(proxy).getVersion());
    }

    function testdepolymentV1() public {
        uint256 expertValue = 7;
        vm.expectRevert();
        BoxV2(proxy).setNumber(expertValue);
    }

    function testUpgrade() public {
        boxV2 = new BoxV2();
        upgradeBox.upgradeBox(proxy, address(boxV2));

        BoxV2(proxy).getVersion();

        uint256 expected = 2;
        assertEq(expected, BoxV2(proxy).getVersion());
    }
}
