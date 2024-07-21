//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {Deploy_FoundMe} from "../script/Deploy_FoundMe.s.sol";
import {FoundMe} from "../src/FoundMe.sol";

contract TestFound is Test {
    address USER = makeAddr("Lhoussaine Ph");

    uint256 constant USER_ETH = 0.1 ether;

    FoundMe found;

    function setUp() public {
        Deploy_FoundMe deploy_found = new Deploy_FoundMe();

        found = deploy_found.run();

        vm.deal(USER, USER_ETH);
    }

    function testfund() public Addfund {
        address user = found.getSender(0);

        vm.prank(USER);

        vm.deal(USER, 1 ether);

        found.fund{value: USER_ETH}();

        uint256 value = USER_ETH + USER_ETH;

        uint256 value2 = found.getAmoutOfSender(USER);

        assertEq(user, USER);
        assertEq(value, value2);
    }

    function testNotEnoughtETH() public {
        vm.expectRevert();
        found.fund();
    }

    function OnlyOwnerWithdrow() public {
        vm.prank(USER);

        vm.expectRevert();
        found.Withdrow();
    }

    function testwithdrow() public Addfund {
        uint256 value = found.getOwner().balance + address(found).balance;

        vm.prank(found.getOwner());

        found.Withdrow();

        assert(address(found).balance == 0);
        assert(value == found.getOwner().balance);
    }

    function testwithdrawWithMultipesender() public {
        for (uint160 i = 1; i < 10; i++) {
            hoax(address(i), USER_ETH);

            found.fund{value: USER_ETH}();
        }

        uint256 value = found.getOwner().balance + address(found).balance;

        vm.prank(found.getOwner());

        uint256 gas_before = gasleft();
        found.Withdrow();
        uint256 gas_After = gasleft();

        console.log("Before : ", gas_before);
        console.log("After : ", gas_After);

        assert(address(found).balance == 0);
        assert(value == found.getOwner().balance);
    }

    function OwnerTest() public {
        address owner = found.getOwner();

        assertEq(owner, address(this));
    }

    modifier Addfund() {
        vm.prank(USER);

        found.fund{value: USER_ETH}();
        _;
    }
}
