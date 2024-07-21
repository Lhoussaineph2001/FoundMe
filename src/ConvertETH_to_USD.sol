// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library ConvertETH_to_USD {
    function getPrice(AggregatorV3Interface Net_Addr) internal view returns (uint256) {
        (, int256 Price,,,) = Net_Addr.latestRoundData();

        return uint256(Price);
    }

    function ConvertETH(uint256 Value, AggregatorV3Interface Net_Addr) internal view returns (uint256) {
        uint256 amout = getPrice(Net_Addr);

        amout = (amout * Value) / 1e18;

        return amout;
    }
}
