// SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";

import {Helper_Net} from "./Helper_Net.s.sol";

import {FoundMe} from "../src/FoundMe.sol";

contract Deploy_FoundMe is Script {
    FoundMe public found;

    Helper_Net hepler_net = new Helper_Net();

    address net_active = hepler_net.Active_Net();

    function run() external returns (FoundMe) {
        vm.startBroadcast();

        found = new FoundMe(net_active);

        vm.stopBroadcast();

        return found;
    }
}
