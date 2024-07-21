//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {Test, console2} from "forge-std/Test.sol";

import {Helper_Net} from "../script/Helper_Net.s.sol";

contract test_helper is Test {
    Helper_Net helper;

    address getAnvil;

    function setUp() public {
        helper = new Helper_Net();
    }

    function test_net() public {
        if (block.chainid == 1) {
            getAnvil = helper.getMainETHConfig().pricefeed;

            assert(helper.Active_Net() == getAnvil);
        } else if (block.chainid == helper.SEPOLEA_CHAIN_ID()) {
            getAnvil = helper.getSpoleaConfig().pricefeed;

            assert(helper.Active_Net() == getAnvil);
        } else {
            getAnvil = helper.getAnvilConfig().pricefeed;
            assert(helper.Active_Net() == getAnvil);
        }
    }
}
