// SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

import {ConvertETH_to_USD} from "./ConvertETH_to_USD.sol";

contract FoundMe {

    ////////////////////
    //   ERRORS   /////
    //////////////////

    error OnlyOwnerErr(string);

    using ConvertETH_to_USD for uint256;

    //////////////////////
    // VARIABLES STATE ///
    /////////////////////

    address public immutable i_Owner;

    uint256 public constant MIN_USD = 50;

    address[] private s_founders;

    mapping(address => uint256) private s_addrToamout;

    AggregatorV3Interface Net_Addr;

    ////////////////////
    // FUNCTIONS    ///
    //////////////////

    constructor(address net_Addr) {
        i_Owner = msg.sender;

        Net_Addr = AggregatorV3Interface(net_Addr);
    }

    function fund() public payable {
        require(msg.value.ConvertETH(Net_Addr) >= MIN_USD, " Not Enough ETH ");

        s_founders.push(msg.sender);

        s_addrToamout[msg.sender] += msg.value;
    }

    function Withdrow() public OnlyOwner {
        uint256 founder = s_founders.length;

        for (uint256 i = 0; i < founder; i++) {
            address fundd = s_founders[0];

            s_addrToamout[fundd] = 0;
        }

        s_founders = new address[](0);

        address payable send = payable(msg.sender);

        (send).transfer(address(this).balance);
    }

    function getSender(uint256 id) public view returns (address) {
        return s_founders[id];
    }

    function getAmoutOfSender(address sender) public view returns (uint256) {
        return s_addrToamout[sender];
    }

    //@ausit-info put this modifier above that best  practice

    modifier OnlyOwner() {
        if (msg.sender != i_Owner) {
            revert OnlyOwnerErr(" Must be owner ");
        }

        _;
    }

    function getOwner() public view returns (address) {
        return i_Owner;
    }

    //e that good to have , so no one can push the money her without calling the `fund` function great
    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}
