// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";

import {FoundMe} from "../src/FoundMe.sol";

import {MockV3Aggregator} from "@chainlink/contracts/src/v0.8/tests/MockV3Aggregator.sol";

contract Helper_Net is Script {
    uint8 constant DECIMAL = 8;

    int256 constant INITAL_NUM = 200e8;

    uint256 public constant SEPOLEA_CHAIN_ID = 11155111;

    Network public Active_Net;

    struct Network {
        address pricefeed;
    }

    constructor() {
        if (block.chainid == 1) {
            Active_Net = getMainETHConfig();
        } else if (block.chainid == SEPOLEA_CHAIN_ID) {
            Active_Net = getSpoleaConfig();
        } else {
            Active_Net = getAnvilConfig();
        }
    }

    ///@dev get the spolia address in chainlink
    function getSpoleaConfig() public pure returns (Network memory) {
        Network memory spolea = Network(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266); //FAKE ADDR  SPOLEA_ETH/USD

        return spolea;
    }

    function getMainETHConfig() public pure returns (Network memory) {
        Network memory MainETH = Network(0x70997970C51812dc3A010C7d01b50e0d17dc79C8); //FAKE ADDR MAINETH_ETH/USD

        return MainETH;
    }

    function getAnvilConfig() public returns (Network memory) {
        if (Active_Net.pricefeed != address(0)) {
            return Active_Net;
        }

        vm.startBroadcast();

        MockV3Aggregator Mock_pricefeed = new MockV3Aggregator(DECIMAL, INITAL_NUM);

        vm.stopBroadcast();

        Network memory Anvil = Network(address(Mock_pricefeed));

        return Anvil;
    }
}
